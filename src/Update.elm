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
                    in
                    ( { model | location = Location.Mission newStatus }, cmd )

                Location.Base ->
                    ( model, Cmd.none )

        GoDeeper ->
            case model.location of
                Location.Mission status ->
                    if status.fuel > 0 then
                        let
                            newStatus =
                                { status | fuel = status.fuel - 1, depth = status.depth + 1 }
                        in
                        ( { model | location = Location.Mission newStatus }, Cmd.none )

                    else
                        ( model, Cmd.none )

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

        ReturnToBase ->
            case model.location of
                Location.Mission status ->
                    let
                        newInventory =
                            Inventory.merge model.inventory status.loot
                    in
                    ( { model | location = Location.Base, inventory = newInventory }, Cmd.none )

                Location.Base ->
                    ( model, Cmd.none )

        StartMission ->
            ( { model | location = Location.Mission { fuel = 3, loot = Inventory.empty, depth = 0 } }, Cmd.none )
