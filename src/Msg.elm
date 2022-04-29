module Msg exposing (..)

import Resource exposing (Resource)


type Msg
    = Drill
    | GoDeeper
    | UpdateResource Resource Int
    | StartMission
