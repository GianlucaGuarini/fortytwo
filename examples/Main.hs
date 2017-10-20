module Main where

import qualified InputExample
import qualified ConfirmExample
import qualified PasswordExample
import qualified SelectExample

main :: IO()
main = do
  SelectExample.main
  PasswordExample.main
  InputExample.main
  ConfirmExample.main
  return ()
