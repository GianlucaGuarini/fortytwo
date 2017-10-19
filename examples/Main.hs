module Main where

import qualified InputExample
import qualified ConfirmExample

main :: IO()
main = do
  InputExample.main
  ConfirmExample.main
  return ()
