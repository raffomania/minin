module Model exposing (..)

import Inventory exposing (Inventory)
import Location exposing (Location)


type alias Model =
    { inventory : Inventory, location : Location }
