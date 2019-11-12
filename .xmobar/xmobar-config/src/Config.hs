module Config
    ( baseConfig
    )
where

import           Xmobar                         ( Config(..)
                                                , defaultConfig
                                                , Border(..)
                                                , XPosition(..)
                                                )

baseConfig = defaultConfig { bgColor         = "black"
                           , fgColor         = "gray"
                           , additionalFonts = ["xft:Symbola:size=10"]
                           , border          = BottomB
                           , borderColor     = "#0000FF"
                           , position        = Top
                           , lowerOnStart    = True
                           , hideOnStart     = False
                           , allDesktops     = True
                           , persistent      = True
                           , sepChar         = "|"
                           , alignSep        = "}{"
                           }
