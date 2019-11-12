module Monitors where

import           Xmobar

weather station = WeatherX
    station
    [ (""            , "<fc=gray60><fn=1>🌑</fn></fc>")
    , ("clear"       , "<fn=1>🌣</fn>")
    , ("sunny"       , "<fn=1>🌣</fn>")
    , ("mostly clear", "<fn=1>🌤</fn>")
    , ("mostly sunny", "<fn=1>🌤</fn>")
    , ("partly sunny", "<fn=1>⛅</fn>")
    , ("fair"        , "<fn=1>🌑</fn>")
    , ( "obscured"
      , "<fn=1>🌁</fn>"
      ) -- 🌫
    , ("cloudy"                 , "<fn=1>☁</fn>")
    , ("overcast"               , "<fn=1>☁</fn>")
    , ("partly cloudy"          , "<fn=1>⛅</fn>")
    , ("mostly cloudy"          , "<fn=1>☁</fn>")
    , ("considerable cloudiness", "<fn=1>⛈</fn>")
    ]
    [ "-t"
    , "<skyConditionS> <tempC>° <rh>% <windKmh> (<hour>)"
    , "-L"
    , "10"
    , "-H"
    , "25"
    ]
    18000

cpu = Cpu ["-L", "3", "-H", "50", "--normal", "green", "--high", "red"] 10

memory = Memory ["-t", "Mem: <usedratio>%"] 10

swap = Swap [] 10

date = Date "%a %b %_d %H:%M:%S" "date" 10

batt = Battery
    [ "-t"
    , "Batt: <left>% / <timeleft>"
    , "--"
    , "-i"
    , "<fn=1>\9211</fn>"
    , "-O"
    , " <fn=1>\9211</fn> <timeleft> <watts>"
    , "-o"
    , " <fn=1>🔋</fn> <timeleft> <watts>"
    ]
    50
