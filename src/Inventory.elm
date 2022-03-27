module Inventory exposing (Inventory, empty, update, view)

import Dict exposing (Dict)
import Html.Styled exposing (Html, div, li, text, ul)
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
                , ul [] (Dict.toList dict |> List.map (viewResource >> List.singleton >> li []))
                ]
            ]


viewResource : ( String, Int ) -> Html Msg
viewResource ( res, count ) =
    [ String.fromInt count, res ]
        |> String.join " "
        |> text
