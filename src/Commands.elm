module Commands exposing (..)

import Http
import Json.Encode as Encode
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


-- player を保存する cmd
savePlayerCmd : Player -> Cmd Msg
savePlayerCmd player =
    savePlayerRequest player
        |> Http.send Msgs.OnPlayerSave -- Http.send は http request を送出する Cmd を返す


-- player を保存する http リクエスト
savePlayerRequest : Player -> Http.Request Player
savePlayerRequest player =
    Http.request
        { body = playerEncoder player |> Http.jsonBody -- player を JSON に変換する
        , expect = Http.expectJson playerDecoder --  https response の JSON を playerDecoder でデコードする
        , headers = []
        , method = "PATCH"
        , timeout = Nothing
        , url = savePlayerUrl player.id
        , withCredentials = False
        }


savePlayerUrl : PlayerId -> String
savePlayerUrl playerId =
    "http://localhost:4000/players/" ++ playerId


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


-- player を JSON に変換するエンコーダ
playerEncoder : Player -> Encode.Value
playerEncoder player =
    let
        attributes =
            [ ( "id", Encode.string player.id )
            , ( "name", Encode.string player.name )
            , ( "level", Encode.int player.level )
            ]
    in
        Encode.object attributes
