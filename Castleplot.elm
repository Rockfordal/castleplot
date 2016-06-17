import Html exposing (Html)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Time exposing (Time, second)
import Http
import Json.Decode as Json exposing ((:=))
import Task exposing (..)
import Debug exposing (log)
import Xy exposing (convertx, converty)
import Castles exposing (Castle, castles)
import Beacons exposing (Beacon, beacons)


type alias Model =
    { castles : List Castle
    , beacons : List Castle
    }

type Action
  = NoOp
  -- | SetCastles (List Castle)


main = view init

init : Model
init = { castles = castles
       , beacons = beacons
       }


update : Action -> Model -> Model
update action model =
  case action of
    NoOp ->
      model

    -- SetCastles model' -> model'


viewcastle : Castle -> Svg a
viewcastle castle =
    let
        color = "#FFAA00"
    in
        circle [ cx <| toString <| convertx <| castle.x
               , cy <| toString <| converty <| castle.y
               , r "1"
               , fill color
               ] []

viewbeacon : Castle -> Svg a
viewbeacon beacon =
    let
        size = toString (round ((toFloat beacon.l) / 1) + 1)
    in
        circle [ cx <| toString <| convertx <| beacon.x
              , cy <| toString <| converty <| beacon.y
              , r size
              , fill "#0000FF"
              ] []

mywidth = (toString Xy.screenwidth)

castleview : List Castle -> List (Svg a)
castleview castles = (List.map viewcastle castles)

beaconview : List Castle -> List (Svg a)
beaconview beacons = (List.map viewbeacon beacons)

rekt : Svg a
rekt = rect [ x "0", y "0", width "800", height "800", rx "15", ry "15" ] []

view model =
    svg [ viewBox ("0 0 " ++ mywidth ++ " " ++ mywidth), width mywidth ]
        (rekt
        :: List.append
            (beaconview model.beacons)
            (castleview model.castles)
        )
