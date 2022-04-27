module Inventory exposing (Inventory, decode, empty, encode, update, view)

import Css exposing (absolute, backgroundColor, borderRadius, borderRadius4, bottom, center, displayFlex, flexWrap, height, hidden, hover, int, justifyContent, lineHeight, marginRight, maxWidth, overflow, padding4, pct, position, px, relative, rgba, right, width, wrap)
import Dict exposing (Dict)
import Html.Styled exposing (Html, div, img, span, text)
import Html.Styled.Attributes exposing (css, draggable, src)
import Json.Decode
import Json.Encode
import Msg exposing (Msg)
import Resource
import String


type Inventory
    = Inventory { dict : Dict String Int }


empty : Inventory
empty =
    Inventory { dict = Dict.empty }


update : Resource.Resource -> Int -> Inventory -> Inventory
update resource count inv =
    let
        updateCount existing =
            Maybe.withDefault 0 existing
                |> (+) count
                |> Just
    in
    case inv of
        Inventory { dict } ->
            Dict.update (Resource.toString resource) updateCount dict
                |> (\newDict -> Inventory { dict = newDict })


view : Inventory -> List (Html Msg)
view inv =
    case inv of
        Inventory { dict } ->
            [ div []
                [ text "Your inventory:"
                , div
                    [ css [ displayFlex, flexWrap wrap, justifyContent center ]
                    ]
                    (Dict.toList dict |> List.map (viewResource >> div []))
                ]
            ]


viewResource : ( String, Int ) -> List (Html Msg)
viewResource ( res, count ) =
    let
        description =
            res
                |> text

        imageSource =
            "resources/" ++ res ++ ".png"
    in
    [ div
        [ css
            [ position relative
            , backgroundColor (rgba 0 0 10 0.4)
            , borderRadius4 (pct 15) (pct 20) (pct 0) (pct 20)
            , overflow hidden
            , padding4 (px 9) (px 13) (px 13) (px 9)
            , height (px 60)
            , width (px 60)
            , marginRight (px 10)
            , hover [ backgroundColor (rgba 10 10 30 0.4) ]
            ]
        ]
        [ img
            [ src imageSource
            , css
                [ maxWidth (pct 100)
                , borderRadius (pct 50)
                ]
            ]
            []
        , span
            [ css [ position absolute, right (px 5), bottom (px 5), lineHeight (int 1) ]
            ]
            [ text (String.fromInt count) ]
        ]
    , description
    ]


encode : Inventory -> Json.Encode.Value
encode inv =
    case inv of
        Inventory { dict } ->
            Json.Encode.dict identity Json.Encode.int dict


decode : Json.Decode.Decoder Inventory
decode =
    Json.Decode.dict Json.Decode.int
        |> Json.Decode.map (\dict -> Inventory { dict = dict })
