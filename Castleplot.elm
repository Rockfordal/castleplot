import Html exposing (Html)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Time exposing (Time, second)
import Http
import Json.Decode as Json exposing ((:=))
import Task exposing (..)
import Debug exposing (log)
import Xy exposing (castles, convertx, converty, Castle)

-- type alias Artist = String
  -- { id: Int
  -- , name: String
  -- }

-- getData : String -> Task Http.Error (List Artist)
-- getData query =
--     Http.get places ("http://api.zippopotam.us/us/" ++ query)


-- places : Json.Decoder (List String)
-- places =
--   let place =
--         Json.object2 (\city state -> city ++ ", " ++ state)
--           ("place name" := Json.string)
--           ("state" := Json.string)
--   in
--       "places" := Json.list place

-- port runner : Task Http.Error (List Artist)
-- port runner =
--   getData "90210"


type alias Model =
  List Castle

type Action
  = NoOp
  | SetCastles (List Castle)


main = view init
init : Model
init = Xy.castles


update : Action -> Model -> Model
update action model =
  case action of
    NoOp ->
      model

    SetCastles model' ->
      model'


viewcastle : Castle -> Svg a
viewcastle castle =
  circle [ cx <| toString <| convertx <| castle.x
         , cy <| toString <| converty <| castle.y
         , r "5"
         , fill "#FFFF00"
         ] []

mywidth = (toString Xy.screenwidth)

castleview : Model -> List (Svg a)
castleview model = (List.map viewcastle model)

rekt : Svg a
rekt = rect [ x "0", y "0", width "800", height "800", rx "15", ry "15" ] []

view model =
    svg [ viewBox ("0 0 " ++ mywidth ++ " " ++ mywidth), width mywidth ]
        (rekt :: (castleview model))
