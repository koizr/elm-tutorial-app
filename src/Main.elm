module Main exposing (..)

import Msgs exposing (Msg)
import Models exposing (Model, initialModel)
import Update exposing (update)
import View exposing (view)
import Commands exposing (fetchPlayers)
import Navigation exposing (Location)
import Routing


-- location に応じた画面を表示する
init : Location ->  ( Model, Cmd Msg)
init location =
    let
        currentRoute =
            Routing.parseLocation location
    in
        ( initialModel currentRoute, fetchPlayers )


-- Subscription


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


-- Main


main : Program Never Model Msg
main =
    Navigation.program Msgs.OnLocationChange
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
