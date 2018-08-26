{- | ルーティングを行うためのモジュール -}

module Routing exposing (..)

import Navigation exposing (Location)
import Models exposing (PlayerId, Route(..))
import UrlParser exposing (..)


-- routing テープル
matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map PlayersRoute top
        , map PlayerRoute (s "players" </> string) -- players/[string]
        , map PlayersRoute (s "players") -- players
        ]


-- location から対応する Route を引き出す
parseLocation : Location -> Route
parseLocation location =
    -- parseHash は matchers からマッチした route を Maybe で包んで返す
    -- マッチしなかったら Nothing を返す
    -- ハッシュによるルーティングをしたくない場合は、代わりに parsePath を使うといい
    case (parseHash matchers location) of
        Just route ->
            route

        Nothing ->
            NotFoundRoute


-- player 一覧画面のパスを返す
playersPath : String
playersPath =
    "#players"


-- player 編集画面のパスを返す
playerPath : PlayerId -> String
playerPath id =
    "#players/" ++ id
