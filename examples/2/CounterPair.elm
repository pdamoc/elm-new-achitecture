module CounterPair exposing (..)

import Counter exposing (counter)
import Html exposing (..)
import Html.Events exposing (..)


-- MODEL


type alias Model =
    { topCounter : Counter.Model
    , bottomCounter : Counter.Model
    }


init : Int -> Int -> Model
init top bottom =
    { topCounter = Counter.init top
    , bottomCounter = Counter.init bottom
    }



-- UPDATE


type Msg
    = Reset
    | Top Counter.Model
    | Bottom Counter.Model


update : Msg -> Model -> Model
update msg model =
    case msg of
        Reset ->
            init 0 0

        Top mdl ->
            { model
                | topCounter = mdl
            }

        Bottom mdl ->
            { model
                | bottomCounter = mdl
            }



-- VIEW


type alias Config msg =
    { onUpdate : Model -> msg }


counterPair : Config msg -> Model -> Html msg
counterPair cfg model =
    let
        onUpdate tagger =
            (tagger >> ((flip update) model) >> cfg.onUpdate)
    in
        div []
            [ counter { onUpdate = onUpdate Top } model.topCounter
            , counter { onUpdate = onUpdate Bottom } model.bottomCounter
            , button [ onClick ((update Reset model) |> cfg.onUpdate) ] [ text "RESET" ]
            ]
