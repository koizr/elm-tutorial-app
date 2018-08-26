module Update exposing (..)

import Msgs exposing (Msg)
import Models exposing (Model)
import Routing exposing (parseLocation)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        -- response には fetch してきた players が入る
        Msgs.OnFetchPlayers response ->
            ( { model | players = response }, Cmd.none )

        -- 変更された location から対応する Route を取得して更新する
        Msgs.OnLocationChange location ->
            let
                newRoute = parseLocation location
            in
                ( { model | route = newRoute }, Cmd.none )
