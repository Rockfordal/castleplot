import Html exposing (Html)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Time exposing (Time, second)
import Http
import Json.Decode as Json exposing ((:=))
import Task exposing (..)

type alias Artist = String
  -- { id: Int
  -- , name: String
  -- }

getData : String -> Task Http.Error (List Artist)
getData query =
    Http.get places ("http://api.zippopotam.us/us/" ++ query)


places : Json.Decoder (List String)
places =
  let place =
        Json.object2 (\city state -> city ++ ", " ++ state)
          ("place name" := Json.string)
          ("state" := Json.string)
  in
      "places" := Json.list place


port runner : Task Http.Error (List Artist)
port runner =
  getData "90210"


main : Html
main = view init

-- MODEL
type alias Castle =
  { x : Int
  , y : Int
  }

type alias Model =
  List Castle


castle1 = { x = 4345, y = -2300 }
castle2 = { x = 5285, y = -2255 }
castle3 = { x = 5111, y = -2669 }
castle4 = { x = 4291, y = -2049 }
castle5 = { x = 3405, y = -2340 }
castle6 = { x = 4380, y = -2925 }
castle7 = { x = 5205, y = -2549 }
castle8 = { x = 5041, y = -2790 }


init : Model
init =
  [ castle1, castle2, castle3, castle3, castle4
    , castle5, castle6, castle7, castle8
    ]


type Action
  = NoOp
  | SetCastles (List Castle)

update : Action -> Model -> Model
update action model =
  case action of
    NoOp ->
      model

    SetCastles model' ->
      model'


getpos : Int -> String
getpos i =
  toString <| (i+1500) // 15


viewcastle : Castle -> Html
viewcastle castle =
  circle [ cx <| getpos <| castle.x - 5000
         , cy <| getpos <| castle.y + 4000
         , r "2"
         , fill "#0B79CE"
         ] []


view : Model -> Html
view model =
    svg [ viewBox "0 0 300 300", width "800" ]
      (List.map viewcastle model)
