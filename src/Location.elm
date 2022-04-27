module Location exposing (..)

import Html.Styled as Html
import Html.Styled.Events as Events
import Msg
import Random
import Resource


type Location
    = Base
    | Mission MissionStatus


type alias MissionStatus =
    { fuel : Int
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


view : MissionStatus -> List (Html.Html Msg.Msg)
view status =
    [ Html.p []
        [ Html.text <|
            "you have "
                ++ String.fromInt status.fuel
                ++ " fuel"
        ]
    , Html.button [ Events.onClick Msg.Drill ]
        [ Html.text "Drill" ]
    ]
