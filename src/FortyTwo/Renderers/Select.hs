{-# LANGUAGE NamedFieldPuns #-}

module FortyTwo.Renderers.Select (renderOptions, renderOption) where

import FortyTwo.Types (Option(..), Options)
import System.Console.ANSI
import FortyTwo.Utils (addBreakingLinesSpacing)
import FortyTwo.Constants

-- | Render all the options collection
renderOptions :: Options -> IO ()
renderOptions = mapM_ renderOption

-- | Render a single option items
renderOption :: Option -> IO()
renderOption Option { isFocused, value } =
  if isFocused then do
    setSGR [SetColor Foreground Dull Cyan]
    putStrLn $ unwords [[focusIcon], text]
    setSGR [Reset]
  else
    putStrLn $ separator ++ text
  where
    separator = "  "
    text = addBreakingLinesSpacing separator value
