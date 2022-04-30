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
            let
                updatedInventory =
                    model.droneInventory
                        |> Inventory.update res count

                updatedModel =
                    { model | droneInventory = updatedInventory }
            in
            ( updatedModel, Cmd.none )

        ReturnToBase ->
            let
                updatedModel =
                    { model | location = Location.Base }
            in
            ( updatedModel, Cmd.none )

        ResourcesToBase ->
            let
                updatedModel =
                    { model | inventory = Inventory.merge model.inventory model.droneInventory, droneInventory = Inventory.empty }
            in
            ( updatedModel, Model.store updatedModel )

        StartMission ->
            ( { model | location = Location.Mission { fuel = 9, depth = 0 } }, Cmd.none )
