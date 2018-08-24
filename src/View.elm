module View exposing (..)

import Html exposing (Html, div, text)
import Msgs exposing (Msg)
import Models exposing (Model)
import Players.List


view : Model -> Html Msg
view model =
    div []
        [ page model ] -- 部品を個別に定義して、それらを組み合わせて画面を作る


-- 外部のモジュールを画面に埋め込む
page : Model -> Html Msg
page model =
    Players.List.view model.players
