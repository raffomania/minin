module Update exposing (..)

import Model exposing (Model)


type Msg
    = None


update : Msg -> Model -> ( Model, Cmd Msg )
update _ model =
    ( model, Cmd.none )
