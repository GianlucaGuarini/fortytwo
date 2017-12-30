module SelectExample where

import FortyTwo (select, selectWithDefault)

main :: IO String
main = do
  select "What's your favourite color?" ["Red", "Yellow", "Blue"]
  selectWithDefault "What's your favourite film?" ["28 Days Later", "Multi\nline\nentry", "Blade Runner", "Matrix", "Multi\nline\ntext"] "28 Days Later"
