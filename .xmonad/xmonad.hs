import           XMonad
import           XMonad.Hooks.DynamicLog
import           XMonad.Hooks.ManageDocks
import           XMonad.Util.Run                ( spawnPipe )
import           XMonad.Util.EZConfig           ( additionalKeysP )
import           System.IO
import           Graphics.X11.ExtraTypes.XF86

main = do
    xmproc <- spawnPipe "xmobar"
    xmonad
        $                 def
                              { modMask = mod4Mask
                              , terminal = "urxvt"
                              , borderWidth = 1
                              , normalBorderColor = "#dddddd"
                              , focusedBorderColor = "#00ff00"
                              , manageHook = manageDocks <+> manageHook defaultConfig
                              , layoutHook = avoidStruts $ layoutHook defaultConfig
                              , handleEventHook = handleEventHook defaultConfig
                                                      <+> docksEventHook
                              , logHook = dynamicLogWithPP xmobarPP
                                              { ppOutput = hPutStrLn xmproc
                                              , ppTitle = xmobarColor "green" "" . shorten 50
                                              }
                              }
        `additionalKeysP` [ ("<XF86MonBrightnessUp>"  , spawn "lux -a 10%")
                          , ("<XF86MonBrightnessDown>", spawn "lux -s 10%")
                          ]
