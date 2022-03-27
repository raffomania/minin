module Msg exposing (..)

import Resource exposing (Resource)


type Msg
    = Drill
    | UpdateResource Resource Int
    | StartMission
