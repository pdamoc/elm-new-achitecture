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
    { onUpdate : Model -> msg
    , onRemove : msg
    }


counterWithRemove : Config msg -> Model -> Html msg
counterWithRemove cfg model =
    div []
        [ button [ onClick ((update Decrement model) |> cfg.onUpdate) ] [ text "-" ]
        , div [ countStyle ] [ text (toString model) ]
        , button [ onClick ((update Increment model) |> cfg.onUpdate) ] [ text "+" ]
        , button [ onClick cfg.onRemove ] [ text "x" ]
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
