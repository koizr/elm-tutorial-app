module Commands exposing (..)

import Http
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required)
import Msgs exposing (Msg)
import Models exposing (PlayerId, Player)
import RemoteData


-- player を取得する cmd
fetchPlayers : Cmd Msg
fetchPlayers =
    Http.get fetchPlayersUrl playersDecoder -- request を作る
        |> RemoteData.sendRequest -- WebData でラップされた request を投げる Cmd を作る
        |> Cmd.map Msgs.OnFetchPlayers -- パイプで渡された Cmd に OnFetchPlayers を紐付ける


fetchPlayersUrl : String
fetchPlayersUrl =
    "http://localhost:4000/players"


-- JSON のリストにデコーダを適用するやつ
playersDecoder : Decode.Decoder (List Player)
playersDecoder =
    Decode.list playerDecoder


-- JSON から Player に変換するデコーダ
playerDecoder : Decode.Decoder Player
playerDecoder =
    decode Player
        |> required "id" Decode.string
        |> required "name" Decode.string
        |> required "level" Decode.int
