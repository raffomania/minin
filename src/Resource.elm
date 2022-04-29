module Resource exposing (Resource(..), random, toString)

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


random : Random.Generator Resource
random =
    Random.int 0 (Array.length allResourceTypes)
        |> Random.map (\n -> Array.get n allResourceTypes |> Maybe.withDefault Iron)
