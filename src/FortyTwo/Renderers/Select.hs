{-# LANGUAGE NamedFieldPuns #-}

module FortyTwo.Renderers.Select (renderOptions, renderOption) where

import Control.Monad.IO.Class

import FortyTwo.Types (Option(..), Options)
import System.Console.ANSI
import FortyTwo.Utils (addBreakingLinesSpacing)
import FortyTwo.Constants

-- | Render all the options collection
renderOptions :: MonadIO m => Options -> m ()
renderOptions = mapM_ renderOption

-- | Render a single option items
renderOption :: MonadIO m => Option -> m ()
renderOption Option { isFocused, value } = liftIO $ do
  if isFocused then do
    setSGR [SetColor Foreground Dull Cyan]
    putStrLn $ unwords [[focusIcon], text]
    setSGR [Reset]
  else
    putStrLn $ separator ++ text
  where
    separator = "  "
    text = addBreakingLinesSpacing separator value
