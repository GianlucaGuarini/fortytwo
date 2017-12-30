module MultiselectExample where

import FortyTwo (multiselect, multiselectWithDefault)

main :: IO [String]
main = do
  multiselect "Which kind of sports do you like?" ["Soccer", "Tennis", "Golf"]
  multiselectWithDefault
    "What are your \nfavourite books?"
    ["1984", "Multi\nline\nentry", "Moby Dick", "The Hitchhiker's Guide\n to the Galaxy"]
    ["1984", "The Hitchhiker's Guide to the Galaxy"]
