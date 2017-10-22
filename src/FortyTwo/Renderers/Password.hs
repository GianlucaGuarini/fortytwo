module FortyTwo.Renderers.Password (getPassword, hideLetters) where

import Data.Maybe
import FortyTwo.Constants (passwordHiddenChar, emptyString)
import qualified System.Console.Haskeline as H

-- | IO event to get the password values hiding them in the UI
getPassword :: IO String
getPassword = H.runInputT H.defaultSettings $ do
  pass <- H.getPassword (Just passwordHiddenChar) emptyString
  return $ fromJust pass

-- | Hide any string replacing its letters with the passwordHiddenChar
hideLetters :: String -> String
hideLetters letters = [passwordHiddenChar | x <- letters]
