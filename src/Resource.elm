module Resource exposing (Resource(..), random, toString, weight)

import Array
import Random


type Resource
    = Iron
    | Water
    | Rock
    | Gems
    | Nanobots
    | Fuel
    | Algae


allResourceTypes : Array.Array Resource
allResourceTypes =
    Array.fromList
        [ Iron
        , Water
        , Rock
        , Gems
        , Nanobots
        , Fuel
        , Algae
        ]


toString : Resource -> String
toString res =
    case res of
        Iron ->
            "Iron"

        Water ->
            "Water"

        Rock ->
            "Rock"

        Gems ->
            "Gems"

        Nanobots ->
            "Nanobots"

        Fuel ->
            "Fuel"

        Algae ->
            "Algae"


weight : Resource -> Int -> Float
weight res depth =
    let
        fDepth =
            toFloat depth / 100

        base =
            case res of
                Iron ->
                    0.7

                Water ->
                    0.8

                Rock ->
                    1.0

                Gems ->
                    0.2

                Nanobots ->
                    0.1

                Fuel ->
                    0.4

                Algae ->
                    0.6
    in
    -- more depth = more weight to lower base weights and less weight to higher base weights
    fDepth
        - ((-1 + (2 * fDepth)) * (base ^ 2))
        |> max 0


random : Int -> Random.Generator Resource
random depth =
    allResourceTypes
        |> Array.map (\t -> ( weight t depth, t ))
        |> Array.toList
        |> (\list ->
                case list of
                    head :: tail ->
                        Random.weighted head tail

                    _ ->
                        -- something's broken
                        Random.constant Rock
           )
