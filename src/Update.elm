module Update exposing (..)

import Inventory
import Location
import Model exposing (Model)
import Msg exposing (..)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Drill ->
            case model.location of
                Location.Mission status ->
                    let
                        ( newStatus, cmd ) =
                            Location.drill status

                        newLocation =
                            if newStatus.fuel > 0 then
                                Location.Mission newStatus

                            else
                                Location.Base
                    in
                    ( { model | location = newLocation }, cmd )

                Location.Base ->
                    ( model, Cmd.none )

        UpdateResource res count ->
            let
                updatedInventory =
                    model.inventory
                        |> Inventory.update res count
            in
            ( { model | inventory = updatedInventory }, Cmd.none )

        StartMission ->
            ( { model | location = Location.Mission { fuel = 3 } }, Cmd.none )
