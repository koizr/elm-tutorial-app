{- | プレイヤーの編集画面を表すモジュール -}

module Players.Edit exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class)
import Msgs exposing (Msg)
import Models exposing (Player)


view : Player -> Html Msg
view model =
    div []
        [ nav model
        , form model
        ]


nav : Player -> Html Msg
nav model =
    div [ class "clearfix mb2 white bg-black p1" ]
        []


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
    a [ class "btn ml1 h1" ]
        [ i [ class "fa fa-minus-circle" ] [] ]


-- player のレベルを上げるボタン
btnLevelIncrease : Player -> Html Msg
btnLevelIncrease player =
    a [ class "btn ml1 h1" ]
        [ i [ class "fa fa-plus-circle" ] [] ]