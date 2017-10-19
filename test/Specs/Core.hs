module Specs.Core (main) where
import FortyTwo
import Test.Hspec

main :: IO ()
main = hspec $
  describe "FortyTwo.theAnswerToEverything" $
    it "Get the answer to everything" $
      theAnswerToEverything `shouldBe` (42 :: Int)
