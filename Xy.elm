module Xy exposing (screenwidth, getx, gety, xmax, xmin, ymax, ymin, xdiff, ydiff, origox, origoy, convertx, converty, xold, yold, xnew, ynew)
import Maybe exposing (withDefault)
import Castles exposing (Castle, castles)
import Beacons exposing (Beacon, beacons)


margin : Float
margin = 50

screenwidth : Float
screenwidth = 800

screendiff : Float
screendiff = screenwidth - margin

getx : Castle -> Int
getx castle = castle.x

xnew = List.map (getx >> convertx) castles
xold = List.map getx castles
xmin = toFloat (withDefault 0 (List.minimum xold))
xmax = toFloat (withDefault 1 (List.maximum xold))
xdiff = xmax - xmin
origox = xdiff / 2 + xmin

halfscreen = screendiff / 2


maxdiff =
    if xdiff > ydiff then
        -- xdiff + 10
        xdiff
    else
        ydiff
        -- (max xdiff (ydiff + 10))

ratio = screendiff / maxdiff


convertx : Int -> Int
convertx ix =
    let
        fx = toFloat ix
        -- xmid = fx - origox
        -- rat = screendiff / ((maxdiff - ydiff) * 2)
        -- newx = xmid * rat + halfscreen + margin / 2
        -- newx = fx * screenwidth / (xmax - xmin) / 2
        newx = (fx * screenwidth / maxdiff) + screenwidth/2
    in
        round newx


gety : Castle -> Int
gety castle = castle.y

ynew = List.map (gety >> converty) castles
yold = List.map gety castles
ymin = toFloat (withDefault 0   (List.minimum yold))
ymax = toFloat (withDefault 800 (List.maximum yold))
ydiff = ymax - ymin
origoy = ydiff / 2 + ymin


converty : Int -> Int
converty iy =
    let
        fy = toFloat iy
        -- ymid = fy - origoy
        -- rat = screendiff / ((maxdiff - ydiff) * 2)
        -- newy = ymid * rat + halfscreen + margin / 2
        -- newy = fy * screenwidth / (ymax - ymin) / 2
        newy = (fy * screenwidth / maxdiff) + screenwidth/2
    in
        round newy

