module InputExample where

import FortyTwo (input, inputWithDefault)

main :: IO String
main = do
  input "What's \n your name?"
  inputWithDefault "How old are you?" "22"
