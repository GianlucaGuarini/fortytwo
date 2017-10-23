module ConfirmExample where

import FortyTwo (confirm, confirmWithDefault)

main :: IO Bool
main = do
  confirm "Do you like music?"
  confirmWithDefault "Do you like pop music?" False
  confirmWithDefault "Do you play an instrument?" True
