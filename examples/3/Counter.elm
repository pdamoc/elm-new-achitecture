module Counter exposing (..)

import Html exposing (..)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)


-- MODEL


type alias Model =
    Int


init : Int -> Model
init v =
    v



-- UPDATE


type Msg
    = Increment
    | Decrement


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            model + 1

        Decrement ->
            model - 1



-- VIEW


type alias Config msg =
    { onUpdate : Model -> msg }


counter : Config msg -> Model -> Html msg
counter cfg model =
    let
        adapter =
            ((flip update) model) >> cfg.onUpdate
    in
        div []
            [ button [ onClick (adapter Decrement) ] [ text "-" ]
            , div [ countStyle ] [ text (toString model) ]
            , button [ onClick (adapter Increment) ] [ text "+" ]
            ]


countStyle : Attribute msg
countStyle =
    style
        [ ( "font-size", "20px" )
        , ( "font-family", "monospace" )
        , ( "display", "inline-block" )
        , ( "width", "50px" )
        , ( "text-align", "center" )
        ]
