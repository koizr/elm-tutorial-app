module View exposing (..)

import Html exposing (Html, div, text)
import Msgs exposing (Msg)
import Models exposing (Model, PlayerId)
import Players.List
import Players.Edit
import RemoteData


view : Model -> Html Msg
view model =
    div []
        [ page model ] -- 部品を個別に定義して、それらを組み合わせて画面を作る


-- location から導かれた Route に応じた画面を表示する
page : Model -> Html Msg
page model =
    case model.route of
        Models.PlayersRoute ->
            Players.List.view model.players

        Models.PlayerRoute id ->
            playerEditPage model id

        Models.NotFoundRoute ->
            notFoundView


-- player の編集画面
playerEditPage : Model -> PlayerId -> Html Msg
playerEditPage model playerId =
    case model.players of
        RemoteData.NotAsked ->
            text ""

        RemoteData.Loading ->
            text "Loading ..."

        -- players の取得に成功した場合
        RemoteData.Success players ->
            let
                -- player 一覧の中から、指定された ID を持つ player を取得する
                maybePlayer =
                    players
                        |> List.filter (\player -> player.id == playerId)
                        |> List.head
            in
                -- 指定された ID の player が存在していたら編集画面を返す
                case maybePlayer of
                    Just player ->
                        Players.Edit.view player

                    Nothing ->
                        notFoundView

        RemoteData.Failure err ->
            text <| toString err


-- 404 view
-- Html Msg ではない。 Msg はメッセージの型を指定するために渡していた。
-- Html msg の msg は型変数。特に使うことはないのですべてを受け入れるようにしてある
notFoundView : Html msg
notFoundView =
    div [] [ text "Not found." ]
