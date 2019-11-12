module Top where

import           Xmobar                         ( xmobar
                                                , configFromArgs
                                                , Runnable(Run)
                                                , Config(..)
                                                , StdinReader(..)
                                                )

import           Config
import           Monitors

main :: IO ()
main = config >>= xmobar
  where
    config = configFromArgs $ baseConfig
        { commands = [ Run (weather "EHAM")
                     , Run cpu
                     , Run memory
                     , Run swap
                     , Run date
                     , Run StdinReader
                     , Run batt
                     ]
        , template =
            "|StdinReader| }{ \
            \|battery| |cpu| |memory| * |swap| \
            \<fc=#00FF00>|date|</fc> |EHAM|"
        }
