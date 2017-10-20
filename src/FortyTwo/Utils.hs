module FortyTwo.Utils where

import Data.Maybe
import System.IO
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

getKey = reverse <$> getKey' ""
  where
    getKey' chars = do
      char <- getChar
      more <- hReady stdin
      (if more then getKey' else return) (char:chars)
