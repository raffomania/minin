module View exposing (..)

import Css exposing (..)
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css)
import Model exposing (Model)
import Update exposing (Msg)


view : Model -> Html.Html Msg
view =
    body >> toUnstyled


body _ =
    div [ css [ backgroundImage (url "/stardust.png"), minHeight (vh 100), color (rgb 255 255 255), fontFamily sansSerif ] ] [ text "hi" ]
