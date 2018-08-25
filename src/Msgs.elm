module Msgs exposing (..)

import Models exposing (Player)
import RemoteData exposing (WebData)


-- WebData は NotAsked, Loading, Success, Failure という
-- http アクセスの状態を表す 4 つの構築子を持っている
type Msg
    = OnFetchPlayers (WebData (List Player))
