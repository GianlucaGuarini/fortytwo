module MultiselectExample where

import FortyTwo (multiselect, multiselectWithDefault)

main :: IO [String]
main = do
  multiselect "Which kind of sport do you like?" ["Soccer", "Tennis", "Golf"]
  multiselectWithDefault "What's your favourite film?" ["28 Days Later", "Blade Runner", "Matrix"] ["28 Days Later"]
