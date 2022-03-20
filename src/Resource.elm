module Resource exposing (Resource(..), toString)


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
