module Main exposing (init, main)

import Browser
import Inventory
import Model exposing (Model)
import Msg exposing (Msg)
import Resource
import Update exposing (update)
import View exposing (view)


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { inventory = Inventory.empty |> Inventory.update Resource.Iron 3 |> Inventory.update Resource.Water 4 }
    , Cmd.batch
        []
    )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.batch
        []
