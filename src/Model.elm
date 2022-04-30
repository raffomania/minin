port module Model exposing (Model, decode, encode, store)

import Inventory exposing (Inventory)
import Json.Decode
import Json.Encode
import Location exposing (Location)
import Util


port storeModel : Json.Encode.Value -> Cmd msg


type alias Model =
    { inventory : Inventory, location : Location, droneInventory : Inventory }


store : Model -> Cmd msg
store model =
    encode model |> storeModel


encode : Model -> Json.Encode.Value
encode model =
    Json.Encode.object [ ( "inventory", Inventory.encode model.inventory ) ]


decode : Json.Decode.Value -> Result Json.Decode.Error Model
decode val =
    let
        decoder =
            Json.Decode.map3 Model
                (Json.Decode.field "inventory" Inventory.decode)
                (Json.Decode.succeed Location.Base)
                (Json.Decode.oneOf [ Json.Decode.field "droneInventory" Inventory.decode, Json.Decode.succeed Inventory.empty ])
                |> Util.debug "save"
    in
    Json.Decode.decodeValue decoder val
