module Models exposing (..)

import RemoteData exposing (WebData)


type alias Model =
    { players : WebData (List Player)
    , route : Route
    }


-- 初期表示に使う Model
initialModel : Route -> Model
initialModel route =
    { players = RemoteData.Loading
    , route = route
    }


type alias PlayerId =
    String


type alias Player =
    { id : PlayerId
    , name : String
    , level : Int
    }


-- Route


type Route
    = PlayersRoute
    | PlayerRoute PlayerId
    | NotFoundRoute -- 他のどの route にもマッチしなかったときにの route
