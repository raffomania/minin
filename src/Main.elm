module Main exposing (init, main)

import Browser
import Model exposing (Model)
import Update exposing (Msg, update)
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
    ( {}
    , Cmd.batch
        []
    )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.batch
        []
