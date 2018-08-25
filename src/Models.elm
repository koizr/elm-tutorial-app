module Models exposing (..)

import RemoteData exposing (WebData)


type alias Model =
    { players : WebData (List Player) }


-- 初期表示に使う Model
initialModel : Model
initialModel =
    { players = RemoteData.Loading }


type alias PlayerId =
    String


type alias Player =
    { id : PlayerId
    , name : String
    , level : Int
    }
