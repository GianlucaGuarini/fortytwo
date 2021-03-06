module Specs.Utils (main) where

import Data.Maybe
import FortyTwo.Utils
import FortyTwo.Types
import Test.Hspec

main :: SpecWith ()
main =
  describe "Utils" $ do
    let list = ["one", "two", "three"]
    it "It converts strings to valid options" $ do
      let options = stringsToOptions list
      getOptionValue ((!!) options 0) `shouldBe` (!!) list 0

    it "Can focus properly an option in a collection via index" $ do
      let selectedIndex = 1
      let options = focusOption selectedIndex $ stringsToOptions list
      fromJust (getFocusedOptionIndex options) `shouldBe` selectedIndex

    it "Return 0 if no option will be selected" $
        fromMaybe 0 (getFocusedOptionIndex $ stringsToOptions list) `shouldBe` 0

    it "Can activate properly an option in a collection via index" $ do
      let selectedIndex = 1
      let options = toggleFocusedOption selectedIndex $ stringsToOptions list
      getSelecteOptionsIndexes options `shouldBe` [selectedIndex]
