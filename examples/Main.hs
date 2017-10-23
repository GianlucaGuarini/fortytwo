module Main where

import qualified InputExample
import qualified ConfirmExample
import qualified PasswordExample
import qualified SelectExample
import qualified MultiselectExample

main :: IO()
main = do
  MultiselectExample.main
  SelectExample.main
  PasswordExample.main
  InputExample.main
  ConfirmExample.main
  return ()
