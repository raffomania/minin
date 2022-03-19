module Main exposing (init, main)

import Browser
import Html


type Msg
    = None


type alias Model =
    {}


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


view _ =
    Html.div [] [ Html.text "hello" ]


update _ model =
    ( model, Cmd.none )


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
