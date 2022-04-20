port module Model exposing (Model, decode, encode, store)

import Inventory exposing (Inventory)
import Json.Decode
import Json.Encode
import Location exposing (Location)


port storeModel : Json.Encode.Value -> Cmd msg


type alias Model =
    { inventory : Inventory, location : Location }


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
            Json.Decode.map2 Model
                (Json.Decode.field "inventory" Inventory.decode)
                (Json.Decode.succeed Location.Base)
    in
    Json.Decode.decodeValue decoder val
