module Resource exposing (Resource(..), random, toString)

import Random


type Resource
    = Iron
    | Water
    | Rock


toString : Resource -> String
toString res =
    case res of
        Iron ->
            "Iron"

        Water ->
            "Water"

        Rock ->
            "Rock"


random : Random.Generator Resource
random =
    Random.int 0 2
        |> Random.map
            (\n ->
                case n of
                    0 ->
                        Iron

                    1 ->
                        Water

                    2 ->
                        Rock

                    _ ->
                        Iron
            )
