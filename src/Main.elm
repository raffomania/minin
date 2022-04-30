module Main exposing (init, main)

import Browser
import Inventory
import Json.Decode
import Location
import Model exposing (Model)
import Msg exposing (Msg)
import Update exposing (update)
import View exposing (view)


main : Program Json.Decode.Value Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


init : Json.Decode.Value -> ( Model, Cmd Msg )
init savegame =
    let
        decoded =
            Model.decode savegame
                |> Result.withDefault { inventory = Inventory.empty, location = Location.Base, droneInventory = Inventory.empty }
    in
    ( decoded
    , Cmd.none
    )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none
