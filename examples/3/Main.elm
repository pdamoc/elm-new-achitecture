module Main exposing (..)

import Html exposing (Html)
import CounterList exposing (counterList)


main : Program Never CounterList.Model Msg
main =
    Html.beginnerProgram
        { model = CounterList.init, update = update, view = view }


type Msg
    = CounterUpdate CounterList.Model


update : Msg -> CounterList.Model -> CounterList.Model
update (CounterUpdate newModel) oldModel =
    newModel


view : CounterList.Model -> Html Msg
view model =
    counterList { onUpdate = CounterUpdate } model
