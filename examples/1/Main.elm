module Main exposing (..)

import Html exposing (Html)
import Counter exposing (counter)


main : Program Never Counter.Model Msg
main =
    Html.beginnerProgram
        { model = Counter.init 0, update = update, view = view }


type Msg
    = CounterUpdate Counter.Model


update : Msg -> Counter.Model -> Counter.Model
update (CounterUpdate newModel) oldModel =
    newModel


view : Counter.Model -> Html Msg
view model =
    counter { onUpdate = CounterUpdate } model
