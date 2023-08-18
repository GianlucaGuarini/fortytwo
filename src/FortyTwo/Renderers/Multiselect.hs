{-# LANGUAGE NamedFieldPuns #-}

module FortyTwo.Renderers.Multiselect (renderOptions, renderOption) where

import Control.Monad.IO.Class

import FortyTwo.Types (Option(..), Options)
import FortyTwo.Utils (addBreakingLinesSpacing)
import System.Console.ANSI
import FortyTwo.Constants

-- | Render all the options collection
renderOptions :: MonadIO m => Options -> m ()
renderOptions = mapM_ renderOption

-- | Render a single option items
renderOption :: MonadIO m => Option -> m ()
renderOption Option { isSelected, isFocused, value } = liftIO $ do
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
  putStr $ " " ++ addBreakingLinesSpacing "    " value
  putStrLn emptyString
