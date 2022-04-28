module View exposing (..)

import Background
import Css exposing (..)
import Html as UnstyledHtml
import Html.Styled as Html exposing (Html, button, div, p, text)
import Html.Styled.Attributes exposing (css)
import Html.Styled.Events as Events
import Inventory
import Location
import Mission
import Model exposing (Model)
import Msg exposing (Msg)


view : Model -> UnstyledHtml.Html Msg
view =
    body >> Html.toUnstyled


body : Model -> Html Msg
body model =
    div
        [ css
            [ color
                (rgb 255 255 255)
            , fontFamily sansSerif
            , displayFlex
            , justifyContent center
            ]
        ]
        [ Background.view
        , div
            [ css
                [ maxWidth (px 900)
                , padding (px 10)
                , displayFlex
                , flexDirection column
                , zIndex (int 1)
                ]
            ]
            [ p [] [ text "hi" ]
            , p []
                (case model.location of
                    Location.Mission status ->
                        Mission.viewMission status

                    Location.Base ->
                        [ p [] (Inventory.view model.inventory)
                        , button [ Events.onClick Msg.StartMission ]
                            [ text "Start mission "
                            ]
                        ]
                )
            ]
        ]
