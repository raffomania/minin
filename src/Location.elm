module Location exposing (..)

import Mission exposing (MissionStatus)


type Location
    = Base
    | Mission MissionStatus


returnToBaseIfFuelEmpty : MissionStatus -> Location
returnToBaseIfFuelEmpty status =
    if status.fuel > 0 then
        Mission status

    else
        Base
