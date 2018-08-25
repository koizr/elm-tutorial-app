module Update exposing (..)

import Msgs exposing (Msg)
import Models exposing (Model)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        -- response には fetch してきた players が入る
        Msgs.OnFetchPlayers response ->
            ( { model | players = response }, Cmd.none )
