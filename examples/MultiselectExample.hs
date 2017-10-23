module MultiselectExample where

import FortyTwo (multiselect, multiselectWithDefault)

main :: IO [String]
main = do
  multiselect "Which kind of sports do you like?" ["Soccer", "Tennis", "Golf"]
  multiselectWithDefault
    "What are your favourite books?"
    ["1984", "Moby Dick", "The Hitchhiker's Guide to the Galaxy"]
    ["1984", "The Hitchhiker's Guide to the Galaxy"]
