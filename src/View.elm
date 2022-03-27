module View exposing (..)

import Css exposing (..)
import Html as UnstyledHtml
import Html.Styled as Html exposing (Html, button, div, p, text)
import Html.Styled.Attributes exposing (css)
import Html.Styled.Events as Events
import Inventory
import Location
import Model exposing (Model)
import Msg exposing (Msg)


view : Model -> UnstyledHtml.Html Msg
view =
    body >> Html.toUnstyled


body : Model -> Html Msg
body model =
    div
        [ css
            [ backgroundImage (url "stardust.png")
            , minHeight (vh 100)
            , color (rgb 255 255 255)
            , fontFamily sansSerif
            , displayFlex
            , justifyContent center
            ]
        ]
        [ div
            [ css
                [ maxWidth (px 900)
                ]
            ]
            [ p [] [ text "hi" ]
            , p [] (Inventory.view model.inventory)
            , p []
                (case model.location of
                    Location.Mission status ->
                        Location.view status

                    Location.Base ->
                        [ button [ Events.onClick Msg.StartMission ]
                            [ text "Start mission "
                            ]
                        ]
                )
            ]
        ]
