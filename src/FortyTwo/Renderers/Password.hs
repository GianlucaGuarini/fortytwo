module FortyTwo.Renderers.Password (renderPassword, hideLetters) where

import Control.Monad.IO.Class

import FortyTwo.Constants (passwordHiddenChar)

-- | Print the password value to the user hiding it
renderPassword :: MonadIO m => String -> m ()
renderPassword letters = liftIO $ putStr $ hideLetters letters

-- | Hide any string replacing its letters with the passwordHiddenChar
hideLetters :: String -> String
hideLetters letters = [passwordHiddenChar | _ <- letters]
