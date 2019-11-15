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
        { commands = [ Run StdinReader
                     , Run date
                     ]
        , template =
            "|StdinReader| }{ \
            \<fc=#00FF00>|date|</fc>"
        }
