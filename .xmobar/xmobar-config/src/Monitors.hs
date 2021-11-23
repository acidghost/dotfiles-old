module Monitors where

import           Xmobar


cpu = Cpu ["-L", "3", "-H", "50", "--normal", "green", "--high", "red"] 10

memory = Memory ["-t", "Mem: <usedratio>%"] 10

swap = Swap [] 10

date = Date "%a %b %_d %H:%M:%S" "date" 10

batt = Battery ["-t", "Batt: <left>% / <timeleft>"] 100
