module Update exposing (..)

import Inventory
import Model exposing (Model)
import Msg exposing (..)
import Random
import Resource


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Drill ->
            if model.fuel > 0 then
                let
                    cmd =
                        Random.generate (\res -> UpdateResource res 1) Resource.random
                in
                ( { model | fuel = model.fuel - 1 }, cmd )

            else
                ( model, Cmd.none )

        UpdateResource res count ->
            let
                updatedInventory =
                    model.inventory
                        |> Inventory.update res count
            in
            ( { model | inventory = updatedInventory }, Cmd.none )
