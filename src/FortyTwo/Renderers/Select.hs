{-# LANGUAGE NamedFieldPuns #-}

module FortyTwo.Renderers.Select (getOption) where

import Data.Maybe
import System.IO
import Control.Monad (when)
import FortyTwo.Types (Option(..), Options)
import FortyTwo.Constants
import FortyTwo.Utils

getOption :: Options -> IO String
getOption options = do
  noBuffering
  render
  restoreBuffering
  return "foo"

render :: IO ()
render = do
   noEcho
   key <- getKey
   handleEvent key
   restoreEcho

handleEvent :: String -> IO()
handleEvent key
  | key == keyUp = do putStr "↑"; render
  | key == keyDown = do putStr "↓"; render
  | key == keyRight = do putStr "→"; render
  | key == keyLeft = do putStr "←"; render
  | key == enterKey = putStr "done"
  | otherwise = do putStr "bla bla"; render

renderOptions :: Options -> IO ()
renderOptions = mapM_ renderOption

renderOption :: Option -> IO()
renderOption Option { isSelected, isFocused, value } = do
  when isFocused $ putStr $ unwords [[selectFocusIcon], " "]
  putStrLn value
