module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode as Decode


main =
    Html.program
        { init = searchFor "cats"
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type alias Model =
    { topic : String
    , gifUrl : String
    , searchText : String
    }


init : String -> ( Model, Cmd Message )
init =
    ( Model "" "" "", getRandomGif topic )


type Message
    = AskedForNewPic
    | SearchTextChanged String
    | NewGifReceived (Result Http.Error String)


update : Message -> Model -> ( Model, Cmd Message )
update message model =
    case message of
        SearchTextChanged newText ->
            ( { model | searchText = newText }, Cmd.none )

        AskedForNewPic ->
            if String.length model.searchText < 1 then
                ( model, getRandomGif model.topic )
            else
                ( { model
                    | searchText = ""
                    , topic = model.searchText
                  }
                , getRandomGif model.searchText
                )

        NewGifReceived (Ok newImageUrl) ->
            ( Model model.topic newImageUrl "", Cmd.none )

        NewGifReceived (Err _) ->
            ( model, Cmd.none )


view : Model -> Html Message
view model =
    div [ pageStyle ]
        [ h2 [ titleStyle ]
            [ text model.topic ]
        , input
            [ inputStyle
            , value model.searchText
            , onInput SearchTextChanged
            , placeholder "search"
            ]
            []
        , br [] []
        , br [] []
        , button [ buttonStyle, onClick AskedForNewPic ]
            [ text "more please!" ]
        , br [] []
        , br [] []
        , img [ imgStyle, src model.gifUrl ] []
        ]


subscriptions : Model -> Sub Message
subscriptions model =
    Sub.none


getRandomGif : String -> Cmd Message
getRandomGif topic =
    let
        url =
            "https://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag="
                ++ topic
    in
        Http.send NewGifReceived (Http.get url decodeGifUrl)


decodeGifUrl : Decode.Decoder String
decodeGifUrl =
    Decode.at [ "data", "image_url" ] Decode.string



-- Styles


pageStyle =
    style [ ( "text-align", "center" ) ]


inputStyle =
    style
        [ ( "padding-top", "16px" )
        , ( "padding-bottom", "6px" )
        , ( "width", "188px" )
        , ( "outline", "none" )
        , ( "color", "#000" )
        , ( "font-size", "16px" )
        , ( "font-weight", "400" )
        , ( "border", "none" )
        , ( "border-bottom", "2px solid #99ddff" )
        ]


titleStyle =
    style [ ( "font-size", "2em" ), ( "color", "#333" ) ]


buttonStyle =
    style
        [ ( "padding", "10px" )
        , ( "background-color", "#99ddff" )
        , ( "border-radius", "2px" )
        , ( "border", "1px solid #99ddff" )
        , ( "color", "white" )
        , ( "font-size", "1.5em" )
        , ( "cursor", "pointer" )
        ]


imgStyle =
    style
        [ ( "border-radius", "2px" )
        , ( "box-shadow"
          , "0 2px 4px rgba(0,0,0,0.12), 0 2px 3px rgba(0,0,0,0.24)"
          )
        ]
