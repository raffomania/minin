module Mission exposing (..)

import Html.Styled as Html exposing (text)
import Html.Styled.Events as Events
import Inventory exposing (Inventory)
import Msg
import Random
import Resource


type alias MissionStatus =
    { fuel : Int
    , loot : Inventory
    }


drill : MissionStatus -> ( MissionStatus, Cmd Msg.Msg )
drill status =
    if status.fuel > 0 then
        let
            cmd =
                Random.generate (\res -> Msg.UpdateResource res 1) Resource.random
        in
        ( { status | fuel = status.fuel - 1 }, cmd )

    else
        ( status, Cmd.none )


viewMission : MissionStatus -> List (Html.Html Msg.Msg)
viewMission status =
    [ text "Resources mined on this mission:"
    , Inventory.view status.loot
    , Html.p []
        [ Html.text <|
            "you have "
                ++ String.fromInt status.fuel
                ++ " fuel"
        ]
    , Html.button [ Events.onClick Msg.Drill ]
        [ Html.text "Drill" ]
    ]
