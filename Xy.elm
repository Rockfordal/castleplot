module Xy exposing (screenwidth, castles, getx, gety, xmax, xmin, ymax, ymin, xdiff, ydiff, origox, origoy, convertx, converty, xold, allnewx, allnewy, Castle)
import Maybe exposing (withDefault)

type alias Castle =
  { x : Int
  , y : Int
  }

castle1 = { x = 4345, y = -2300 }
castle2 = { x = 5285, y = -2255 }
castle3 = { x = 5111, y = -2669 }
castle4 = { x = 4291, y = -2049 }
castle5 = { x = 3405, y = -2340 }
castle6 = { x = 4380, y = -2925 }
castle7 = { x = 5205, y = -2549 }
castle8 = { x = 5041, y = -2790 }

castles =
  [ castle1, castle2, castle3, castle3, castle4
  , castle5, castle6, castle7, castle8
  ]

margin : Float
margin = 50

screenwidth : Float
screenwidth = 800

screendiff : Float
screendiff = screenwidth - margin

getx : Castle -> Int
getx castle = castle.x

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
        xmid = fx - origox
        rat = screendiff / ((maxdiff - ydiff) * 2)
        newx = xmid * rat + halfscreen + margin / 2
    in
        round newx

allnewx = List.map (getx >> convertx) castles



gety : Castle -> Int
gety castle = castle.y

yold = List.map gety castles
ymin = toFloat (withDefault 0   (List.minimum yold))
ymax = toFloat (withDefault 800 (List.maximum yold))
ydiff = ymax - ymin
origoy = ydiff / 2 + ymin


converty : Int -> Int
converty iy =
    let
        fy = toFloat iy
        ymid = fy - origoy
        rat = screendiff / ((maxdiff - ydiff) * 2)
        newy = ymid * rat + halfscreen + margin / 2
    in
        round newy

allnewy = List.map (gety >> converty) castles
