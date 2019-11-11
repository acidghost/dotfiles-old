import           XMonad
import           XMonad.Hooks.DynamicLog
import           XMonad.Hooks.ManageDocks
import           XMonad.Util.Run                ( spawnPipe )
import           XMonad.Util.EZConfig           ( additionalKeys
                                                , additionalKeysP
                                                )
import           System.IO
import           Graphics.X11.ExtraTypes.XF86

main = do
    xmproc <- spawnPipe "xmobar"
    xmonad
        $                 (myConfig xmproc)
        `additionalKeys`  myKeys
        `additionalKeysP` myKeysXF86

myConfig xmproc = def
    { modMask            = mod4Mask
    , terminal           = "urxvt"
    , borderWidth        = 1
    , normalBorderColor  = "#dddddd"
    , focusedBorderColor = "#00ff00"
    , manageHook         = manageDocks <+> manageHook def
    , layoutHook         = avoidStruts $ layoutHook def
    , handleEventHook    = handleEventHook def <+> docksEventHook
    , logHook            = dynamicLogWithPP xmobarPP
                               { ppOutput = hPutStrLn xmproc
                               , ppTitle  = xmobarColor "green" "" . shorten 180
                               }
    }

myKeys = [((mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock")]

myKeysXF86 =
    [ ("<XF86MonBrightnessUp>"  , spawn "lux -a 10%")
    , ("<XF86MonBrightnessDown>", spawn "lux -s 10%")
    , ("<XF86AudioLowerVolume>" , spawn "amixer set Master 10%-")
    , ("<XF86AudioRaiseVolume>" , spawn "amixer set Master 10%+")
    , ("<XF86AudioMute>"        , spawn "amixer set Master toggle")
    ]
