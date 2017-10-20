module FortyTwo.Renderers.Password (getPassword, hideLetters, passwordHiddenChar) where

import Data.Maybe
import qualified System.Console.Haskeline as H

-- | Char used to hide the password letters
passwordHiddenChar :: Char
passwordHiddenChar = '*'

-- | IO event to get the password values hiding them in the UI
getPassword :: IO String
getPassword = H.runInputT H.defaultSettings $ do
  pass <- H.getPassword (Just passwordHiddenChar) ""
  return $ fromJust pass

-- | Hide any string replacing its letters with the passwordHiddenChar
hideLetters :: String -> String
hideLetters letters = [passwordHiddenChar | x <- letters]
