module Inventory exposing (Inventory, decode, empty, encode, update, view)

import Css exposing (backgroundColor, border, border3, borderColor, borderRadius, height, margin, padding, pct, property, px, rgb, rgba, solid)
import Dict exposing (Dict)
import Html.Styled exposing (Html, div, img, li, text, ul)
import Html.Styled.Attributes exposing (css, src)
import Json.Decode
import Json.Encode
import Msg exposing (Msg)
import Resource


type Inventory
    = Inventory (Dict String Int)


empty : Inventory
empty =
    Inventory Dict.empty


update : Resource.Resource -> Int -> Inventory -> Inventory
update resource count inv =
    let
        updateCount existing =
            Maybe.withDefault 0 existing
                |> (+) count
                |> Just
    in
    case inv of
        Inventory dict ->
            Dict.update (Resource.toString resource) updateCount dict
                |> Inventory


view : Inventory -> List (Html Msg)
view inv =
    case inv of
        Inventory dict ->
            [ div []
                [ text "Your inventory:"
                , ul [] (Dict.toList dict |> List.map (viewResource >> li []))
                ]
            ]


viewResource : ( String, Int ) -> List (Html Msg)
viewResource ( res, count ) =
    let
        description =
            [ String.fromInt count, res ]
                |> String.join " "
                |> text

        imageSource =
            "resources/" ++ res ++ ".png"
    in
    [ img
        [ src imageSource
        , css
            [ margin (px 10)
            , padding (px 10)
            , height (px 60)
            , borderRadius (pct 20)
            , border3 (px 0) solid (rgb 255 255 255)
            , backgroundColor (rgba 0 0 10 0.4)
            ]
        ]
        []
    , description
    ]


encode : Inventory -> Json.Encode.Value
encode inv =
    case inv of
        Inventory dict ->
            Json.Encode.dict identity Json.Encode.int dict


decode : Json.Decode.Decoder Inventory
decode =
    Json.Decode.dict Json.Decode.int
        |> Json.Decode.map Inventory
