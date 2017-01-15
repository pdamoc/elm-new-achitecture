module CounterList exposing (..)

import Counter exposing (counter)
import Html exposing (..)
import Html.Events exposing (..)


-- MODEL


type alias Model =
    { counters : List ( ID, Counter.Model )
    , nextID : ID
    }


type alias ID =
    Int


init : Model
init =
    { counters = []
    , nextID = 0
    }



-- UPDATE


type Msg
    = Insert
    | Remove
    | Modify ID Counter.Model


update : Msg -> Model -> Model
update msg model =
    case msg of
        Insert ->
            let
                newCounter =
                    ( model.nextID, Counter.init 0 )

                newCounters =
                    model.counters ++ [ newCounter ]
            in
                { model
                    | counters = newCounters
                    , nextID = model.nextID + 1
                }

        Remove ->
            { model | counters = List.drop 1 model.counters }

        Modify id newCounterModel ->
            let
                updateCounter ( counterID, counterModel ) =
                    if counterID == id then
                        ( counterID, newCounterModel )
                    else
                        ( counterID, counterModel )
            in
                { model | counters = List.map updateCounter model.counters }



-- VIEW


type alias Config msg =
    { onUpdate : Model -> msg }


counterList : Config msg -> Model -> Html msg
counterList cfg model =
    let
        onUpdate id =
            ((Modify id) >> ((flip update) model) >> cfg.onUpdate)

        counters =
            List.map (viewCounter onUpdate) model.counters

        remove =
            button [ onClick ((update Remove model) |> cfg.onUpdate) ] [ text "Remove" ]

        insert =
            button [ onClick ((update Insert model) |> cfg.onUpdate) ] [ text "Add" ]
    in
        div [] ([ remove, insert ] ++ counters)


viewCounter : (ID -> (Counter.Model -> msg)) -> ( ID, Counter.Model ) -> Html msg
viewCounter updater ( id, model ) =
    counter { onUpdate = updater id } model
