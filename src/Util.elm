module Util exposing (..)

import Json.Decode as Decode


debug : String -> Decode.Decoder a -> Decode.Decoder a
debug message decoder =
    Decode.value
        |> Decode.andThen (debugHelper message decoder)


debugHelper : String -> Decode.Decoder a -> Decode.Value -> Decode.Decoder a
debugHelper message decoder value =
    let
        _ =
            Debug.log message (Decode.decodeValue decoder value)
    in
    decoder
