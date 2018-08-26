{- | プレイヤーの編集画面を表すモジュール -}

module Players.Edit exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, value, href)
import Html.Events exposing (onClick)
import Msgs exposing (Msg)
import Models exposing (Player)
import Routing exposing (playersPath)


view : Player -> Html Msg
view model =
    div []
        [ nav model
        , form model
        ]


nav : Player -> Html Msg
nav model =
    div [ class "clearfix mb2 white bg-black p1" ]
        [ listBtn ]


-- プレイヤーの情報を変更するフォーム
form : Player -> Html Msg
form player =
    div [ class "m3"]
        [ h1 [] [ text player.name ]
        , formLevel player
        ]


-- レベルを上下させるボタンを配置したフォーム
formLevel : Player -> Html Msg
formLevel player =
    div [ class "clearfix py1" ]
        [ div [ class "col col-5" ]
            [ text "Level" ]
        , div [ class "col col-7" ]
            [ span [class "h2 bold"] [ text <| toString player.level]
            , btnLevelDecrease player
            , btnLevelIncrease player
            ]
        ]


-- player のレベルを下げるボタン
btnLevelDecrease : Player -> Html Msg
btnLevelDecrease player =
    let
        message =
            Msgs.ChangeLevel player -1
    in
        a [ class "btn ml1 h1", onClick message ]
            [ i [ class "fa fa-minus-circle" ] [] ]


-- player のレベルを上げるボタン
btnLevelIncrease : Player -> Html Msg
btnLevelIncrease player =
    let
        message =
            Msgs.ChangeLevel player 1
    in
        a [ class "btn ml1 h1", onClick message ]
            [ i [ class "fa fa-plus-circle" ] [] ]


-- player 一覧画面へ遷移するボタン
listBtn : Html Msg
listBtn =
    a [ class "btn regular", href playersPath]
        [ i [ class "fa fa-chevron-left mr1" ] []
        , text "List"
        ]
