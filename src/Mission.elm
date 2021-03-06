module Mission exposing (..)

import Html.Styled as Html exposing (button, div, p)
import Html.Styled.Attributes exposing (disabled)
import Html.Styled.Events as Events
import Msg
import Random
import Resource


type alias MissionStatus =
    { fuel : Int
    , depth : Int
    }


drill : MissionStatus -> ( MissionStatus, Cmd Msg.Msg )
drill status =
    if status.fuel > 0 then
        let
            cmd =
                Random.generate (\res -> Msg.UpdateResource res 1) (Resource.random status.depth)
        in
        ( { status | fuel = status.fuel - 1 }, cmd )

    else
        ( status, Cmd.none )


viewMission : MissionStatus -> Html.Html Msg.Msg
viewMission status =
    div []
        [ p []
            [ Html.text <|
                "you have "
                    ++ String.fromInt status.fuel
                    ++ " fuel."
            ]
        , p []
            [ Html.text <| "You are " ++ String.fromInt (status.depth * 50) ++ " meters deep." ]
        , button [ Events.onClick Msg.Drill, disabled (status.fuel <= 0) ]
            [ Html.text "Drill" ]
        , button [ Events.onClick Msg.GoDeeper, disabled (status.fuel <= 0) ]
            [ Html.text "Dig Deeper" ]
        , button [ Events.onClick Msg.ReturnToBase ]
            [ Html.text "Return to Ship" ]
        ]
