module PasswordExample where

import FortyTwo (password)

main :: IO String
main = password "What's your \nsecret password?"
