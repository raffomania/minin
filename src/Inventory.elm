module Inventory exposing (Inventory, decode, empty, encode, update, view)

import Css exposing (center, displayFlex, flexWrap, justifyContent, wrap)
import Dict exposing (Dict)
import GridCell
import Html.Styled exposing (Html, div, text)
import Html.Styled.Attributes exposing (css)
import Json.Decode
import Json.Encode
import Msg exposing (Msg)
import Resource


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
                    (Dict.toList dict |> List.map (\( res, count ) -> GridCell.view (Just res) (Just count) (Just ("/resources/" ++ res ++ ".png"))))
                ]
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
