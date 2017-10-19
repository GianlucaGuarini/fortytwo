module Main where

import Test.DocTest

main :: IO ()
main = doctest [
    "src/FortyTwo.hs",
    "src/FortyTwo/TheAnswerToEverything.hs",
    "src/FortyTwo/Types.hs",
    "src/FortyTwo/Prompts/Input.hs",
    "src/FortyTwo/Renderers/Question.hs"
  ]
