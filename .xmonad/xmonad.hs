import           XMonad
import           XMonad.Hooks.DynamicLog
import           XMonad.Hooks.ManageDocks
import           XMonad.Util.Run                ( spawnPipe )
import           XMonad.Util.EZConfig           ( additionalKeys
                                                , additionalKeysP
                                                )
import           Graphics.X11.ExtraTypes.XF86
import           System.IO


main = do
    xmproc <- spawnPipe "xmobar-top"
    xmonad $ myConfig xmproc `additionalKeys` myKeys

myConfig xmproc = def
    { modMask            = myMod
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

myMod = mod4Mask

myKeys =
    [ ((myMod .|. shiftMask, xK_z)  , spawn "xscreensaver-command -lock")
    , ((myMod .|. shiftMask, xK_p)  , spawn "dmenu_aliases")
    , ((0, xF86XK_MonBrightnessUp)  , spawn "lux -a 10%")
    , ((0, xF86XK_MonBrightnessDown), spawn "lux -s 10%")
    , ((0, xF86XK_AudioLowerVolume) , spawn "pactl set-sink-volume 0 -10%")
    , ( (shiftMask, xF86XK_AudioLowerVolume)
      , spawn "pactl set-sink-volume 0 -1%"
      )
    , ((0, xF86XK_AudioRaiseVolume), spawn "pactl set-sink-volume 0 +10%")
    , ( (shiftMask, xF86XK_AudioRaiseVolume)
      , spawn "pactl set-sink-volume 0 +1%"
      )
    , ((0, xF86XK_AudioMute), spawn "pactl set-sink-mute 0 toggle")
    ]
