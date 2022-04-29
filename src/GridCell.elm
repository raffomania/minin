module GridCell exposing (..)

import Css exposing (absolute, backgroundColor, backgroundImage, borderRadius, borderRadius4, bottom, center, displayFlex, height, hidden, hover, int, justifyContent, left, lineHeight, linearGradient, margin, maxWidth, opacity, overflow, padding4, paddingTop, pct, position, px, relative, rgba, right, stop, stop2, top, width)
import Html.Styled exposing (Html, div, img, span, text)
import Html.Styled.Attributes exposing (css, src)
import Msg exposing (Msg)


view : Maybe String -> Maybe Int -> Maybe String -> Html Msg
view maybeDescription maybeCount maybeImage =
    div
        [ css
            [ position relative
            , backgroundColor (rgba 0 0 10 0.4)
            , borderRadius4 (pct 15) (pct 20) (pct 0) (pct 20)
            , overflow hidden
            , padding4 (px 9) (px 13) (px 13) (px 9)
            , height (px 60)
            , width (px 60)
            , margin (px 5)
            , hover [ backgroundColor (rgba 0 0 20 0.6) ]
            ]
        ]
        ([ maybeImage
            |> Maybe.map
                (\image ->
                    img
                        [ css
                            [ maxWidth (pct 100)
                            , borderRadius (pct 50)
                            ]
                        , src image
                        ]
                        []
                )
         , maybeCount
            |> Maybe.map
                (\count ->
                    span
                        [ css [ position absolute, right (px 5), bottom (px 5), lineHeight (int 1) ]
                        ]
                        [ text (count |> String.fromInt) ]
                )
         , maybeDescription
            |> Maybe.map
                (\description ->
                    div
                        [ css
                            [ hover [ opacity (int 1) ]
                            , opacity (int 0)
                            , width (pct 100)
                            , height (pct 100)
                            , position absolute
                            , top (px 0)
                            , left (px 0)
                            , paddingTop (px 5)
                            , displayFlex
                            , justifyContent center
                            , backgroundImage (linearGradient (stop (rgba 0 0 0 0.8)) (stop2 (rgba 0 0 0 0) (pct 60)) [])
                            ]
                        ]
                        [ text description ]
                )
         ]
            |> List.filterMap identity
        )
