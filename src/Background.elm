module Background exposing (view)

import Css exposing (..)
import Css.Animations
import Html.Styled
import Msg exposing (Msg)
import Svg.Styled.Attributes exposing (css)


view : Html.Styled.Html Msg
view =
    let
        animSize =
            30

        animSteps =
            8

        stepToPosition step =
            let
                fac =
                    toFloat step / animSteps

                x =
                    sin (fac * pi * 4)

                y =
                    sin (fac * pi * 7)
            in
            [ ( "x", x * animSize ), ( "y", y * animSize ) ]

        backgroundPositions =
            List.range 0 animSteps
                |> List.map stepToPosition
                |> List.indexedMap (\i pos -> ( floor (toFloat i * 100 / animSteps), pos ))

        backgroundAnimation =
            backgroundPositions
                |> List.map
                    (\( percent, props ) ->
                        ( percent
                        , props |> List.map (\( kind, pos ) -> Css.Animations.property ("background-position-" ++ kind) (String.fromFloat pos ++ "px"))
                        )
                    )
                |> Css.Animations.keyframes
    in
    Html.Styled.div
        [ css
            [ backgroundImage (url "stardust.png")
            , height (vh 100)
            , width (vw 100)
            , animationName backgroundAnimation
            , animationDuration (sec 60)
            , animationIterationCount infinite
            , property "animation-timing-function" "ease-in-out"
            , position fixed
            ]
        ]
        []
