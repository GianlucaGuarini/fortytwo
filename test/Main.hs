module Main (main) where

import qualified Specs.Core
import qualified Specs.Utils
import Test.Hspec

main :: IO ()
main = hspec $
  describe "FortyTwo" $ do
    Specs.Core.main
    Specs.Utils.main
