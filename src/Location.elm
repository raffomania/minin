module Location exposing (..)

import Mission exposing (MissionStatus)
import Msg
import Random
import Resource


type Location
    = Base
    | Mission MissionStatus


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
