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

volumeUpdate n = spawn $ "pactl set-sink-volume 0 " ++ (sho n) ++ "%"
  where
    sho n | n > 0     = "+" ++ (show n)
          | otherwise = show n

volumeToggle = spawn "pactl set-sink-mute 0 toggle"

myKeys =
    [ ((myMod .|. shiftMask, xK_z)         , spawn "xscreensaver-command -lock")
    , ((myMod, xK_p)                       , spawn "dmenu_run")
    , ((myMod .|. shiftMask, xK_p)         , spawn "dmenu_aliases")
    , ((0, xF86XK_MonBrightnessUp)         , spawn "lux -a 10%")
    , ((0, xF86XK_MonBrightnessDown)       , spawn "lux -s 10%")
    , ((0, xF86XK_AudioLowerVolume)        , volumeUpdate (-10))
    , ((shiftMask, xF86XK_AudioLowerVolume), volumeUpdate (-1))
    , ((0, xF86XK_AudioRaiseVolume)        , volumeUpdate 10)
    , ((shiftMask, xF86XK_AudioRaiseVolume), volumeUpdate 1)
    , ((0, xF86XK_AudioMute)               , volumeToggle)
    ]
