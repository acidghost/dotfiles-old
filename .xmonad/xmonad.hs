import           XMonad
import           XMonad.Hooks.DynamicLog
import           XMonad.Hooks.ManageDocks
import           XMonad.Util.Run                ( spawnPipe )
import           XMonad.Util.EZConfig           ( additionalKeysP )
import           System.IO
import           Graphics.X11.ExtraTypes.XF86

main = do
    xmproc <- spawnPipe "xmobar"
    xmonad $ (myConfig xmproc) `additionalKeysP` myKeysXF86

myConfig xmproc = def
    { modMask            = mod4Mask
    , terminal           = "urxvt"
    , borderWidth        = 1
    , normalBorderColor  = "#dddddd"
    , focusedBorderColor = "#00ff00"
    , manageHook         = manageDocks <+> manageHook defaultConfig
    , layoutHook         = avoidStruts $ layoutHook defaultConfig
    , handleEventHook    = handleEventHook defaultConfig <+> docksEventHook
    , logHook            = dynamicLogWithPP xmobarPP
                               { ppOutput = hPutStrLn xmproc
                               , ppTitle  = xmobarColor "green" "" . shorten 180
                               }
    }

myKeysXF86 =
    [ ("<XF86MonBrightnessUp>"  , spawn "lux -a 10%")
    , ("<XF86MonBrightnessDown>", spawn "lux -s 10%")
    , ("<XF86AudioLowerVolume>" , spawn "amixer set Master 10%-")
    , ("<XF86AudioRaiseVolume>" , spawn "amixer set Master 10%+")
    , ("<XF86AudioMute>"        , spawn "amixer set Master toggle")
    ]
