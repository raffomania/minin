module View exposing (..)

import Css exposing (..)
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css)
import Html.Styled.Events exposing (onClick)
import Inventory
import Model exposing (Model)
import Msg exposing (Msg)


view : Model -> Html.Html Msg
view =
    body >> toUnstyled


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
            , p [] [ text <| "you have " ++ String.fromInt model.fuel ++ " fuel" ]
            , Inventory.view model.inventory
            , button [ onClick Msg.Drill ] [ text "drill" ]
            ]
        ]
