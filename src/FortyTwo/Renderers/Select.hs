{-# LANGUAGE NamedFieldPuns #-}

module FortyTwo.Renderers.Select (renderOptions, renderOption) where

import FortyTwo.Types (Option(..), Options)
import System.Console.ANSI
import FortyTwo.Constants

-- | Render all the options collection
renderOptions :: Options -> IO ()
renderOptions = mapM_ renderOption

-- | Render a single option items
renderOption :: Option -> IO()
renderOption Option { isSelected, isFocused, value } =
  if isFocused then do
    setSGR [SetColor Foreground Dull Cyan]
    putStrLn $ unwords [[selectFocusIcon], value]
    setSGR [Reset]
  else
    putStrLn $ "  " ++ value
