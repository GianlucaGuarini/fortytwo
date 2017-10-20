module Main where

import qualified InputExample
import qualified ConfirmExample
import qualified PasswordExample

main :: IO()
main = do
  PasswordExample.main
  InputExample.main
  ConfirmExample.main
  return ()
