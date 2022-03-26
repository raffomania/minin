module Resource exposing (Resource(..), random, toString)

import Random


type Resource
    = Iron
    | Water


toString : Resource -> String
toString res =
    case res of
        Iron ->
            "Iron"

        Water ->
            "Water"


random : Random.Generator Resource
random =
    Random.int 0 1
        |> Random.map
            (\n ->
                case n of
                    0 ->
                        Iron

                    1 ->
                        Water

                    _ ->
                        Iron
            )
