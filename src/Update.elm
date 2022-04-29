module Update exposing (..)

import Inventory
import Location
import Mission
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
                            Mission.drill status

                        newLocation =
                            if newStatus.fuel > 0 then
                                Location.Mission newStatus

                            else
                                Location.Base

                        updatedInventory =
                            if newLocation == Location.Base then
                                model.inventory |> Inventory.merge status.loot

                            else
                                model.inventory
                    in
                    ( { model | location = newLocation, inventory = updatedInventory }, cmd )

                Location.Base ->
                    ( model, Cmd.none )

        UpdateResource res count ->
            case model.location of
                Location.Mission status ->
                    let
                        updatedInventory =
                            status.loot
                                |> Inventory.update res count

                        updatedModel =
                            { model | location = Location.Mission { status | loot = updatedInventory } }
                    in
                    ( updatedModel, Model.store updatedModel )

                Location.Base ->
                    ( model, Cmd.none )

        StartMission ->
            ( { model | location = Location.Mission { fuel = 3, loot = Inventory.empty } }, Cmd.none )
