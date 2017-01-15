module Main exposing (..)

import Html exposing (Html)
import CounterPair exposing (counterPair)


main : Program Never CounterPair.Model Msg
main =
    Html.beginnerProgram
        { model = CounterPair.init 0 0, update = update, view = view }


type Msg
    = CounterUpdate CounterPair.Model


update : Msg -> CounterPair.Model -> CounterPair.Model
update (CounterUpdate newModel) oldModel =
    newModel


view : CounterPair.Model -> Html Msg
view model =
    counterPair { onUpdate = CounterUpdate } model
