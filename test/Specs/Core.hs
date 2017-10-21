module Specs.Core (main) where
import FortyTwo
import Test.Hspec

main :: SpecWith ()
main =
  describe "theAnswerToEverything" $
    it "Get the answer to everything" $
      theAnswerToEverything `shouldBe` (42 :: Int)
