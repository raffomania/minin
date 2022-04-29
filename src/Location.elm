module Location exposing (..)

import Mission exposing (MissionStatus)


type Location
    = Base
    | Mission MissionStatus
