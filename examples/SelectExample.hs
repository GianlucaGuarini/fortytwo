module SelectExample where

import FortyTwo (select)

main :: IO [String]
main = do
  select "What's your favourite color?" ["Red", "Yellow", "Blue"]
