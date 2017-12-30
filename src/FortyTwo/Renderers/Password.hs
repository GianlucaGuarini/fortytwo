module FortyTwo.Renderers.Password (renderPassword, hideLetters) where

import FortyTwo.Constants (passwordHiddenChar)

-- | Print the password value to the user hiding it
renderPassword :: String -> IO ()
renderPassword letters = putStr $ hideLetters letters

-- | Hide any string replacing its letters with the passwordHiddenChar
hideLetters :: String -> String
hideLetters letters = [passwordHiddenChar | _ <- letters]
