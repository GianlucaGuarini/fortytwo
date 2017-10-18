module Main (main) where
import FortyTwo
import Test.Hspec

main :: IO ()
main = hspec $
  describe "FortyTwo.theAnswer" $
    it "Expect the answer to everything" $
      theAnswer `shouldBe` (42 :: Int)
