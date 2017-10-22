module FortyTwo.Utils where

import System.Console.ANSI (cursorUpLine, clearFromCursorToScreenEnd)
import Data.Maybe
import System.IO
import FortyTwo.Constants (emptyString)
import Control.Monad (when)

noBuffering :: IO()
noBuffering = do
  hSetBuffering stdin NoBuffering
  hSetBuffering stdout NoBuffering

restoreBuffering :: IO()
restoreBuffering = do
  hSetBuffering stdin LineBuffering
  hSetBuffering stdout LineBuffering

noEcho :: IO ()
noEcho = hSetEcho stdin False

restoreEcho :: IO ()
restoreEcho = hSetEcho stdin True

clearLines :: Int -> IO()
clearLines lines' = do
  -- move up of 1 line...
  cursorUpLine lines'
  -- and clear them
  clearFromCursorToScreenEnd

getKey = reverse <$> getKey' emptyString
  where
    getKey' chars = do
      char <- getChar
      more <- hReady stdin
      (if more then getKey' else return) (char:chars)
