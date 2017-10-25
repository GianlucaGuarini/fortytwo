module SelectExample where

import FortyTwo (select, selectWithDefault)

main :: IO String
main = do
  select "What's your favourite color?" ["Red", "Yellow", "Blue"]
  selectWithDefault "What's your favourite film?" ["28 Days Later", "Blade Runner", "Matrix"] "28 Days Later"
