module Model exposing (..)

import Inventory exposing (Inventory)


type alias Model =
    { inventory : Inventory, fuel : Int }
