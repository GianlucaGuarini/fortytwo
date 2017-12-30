{-# LANGUAGE NamedFieldPuns #-}

module FortyTwo.Renderers.Multiselect (renderOptions, renderOption) where

import FortyTwo.Types (Option(..), Options)
import System.Console.ANSI
import FortyTwo.Constants

-- | Render all the options collection
renderOptions :: Options -> IO ()
renderOptions = mapM_ renderOption

-- | Render a single option items
renderOption :: Option -> IO()
renderOption Option { isSelected, isFocused, value } = do
  if isFocused then do
    setSGR [SetColor Foreground Dull Cyan]
    putStr $ focusIcon : " "
    setSGR [Reset]
  else
    putStr "  "
  if isSelected then do
    setSGR [SetColor Foreground Dull Green]
    putStr [selectedIcon]
    setSGR [Reset]
  else putStr [unselectedIcon]
  putStr $ " " ++ value
  putStrLn emptyString
