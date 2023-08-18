module FortyTwo.Prompts.Input (inputWithDefault, input) where

import Control.Monad.IO.Class

import FortyTwo.Renderers.Question (renderQuestion)
import FortyTwo.Utils (clearLines, flush)
import FortyTwo.Constants (emptyString)

-- | Ask a simple input question falling back to a default value if no answer will be provided
-- inputWithDefault "What is your name?" "The Dude"
inputWithDefault :: MonadIO m => String -> String -> m String
inputWithDefault question defaultAnswer = liftIO $ do
  putStrLn emptyString
  renderQuestion question defaultAnswer emptyString
  putStr " "
  flush
  answer <- getLine
  clearLines 1
  -- return the default answer if no answer was given
  if null answer then do
    renderQuestion question emptyString defaultAnswer
    return defaultAnswer
  else do
    renderQuestion question emptyString answer
    return answer

-- | Simple input question
-- input "What is your name?"
input :: MonadIO m => String -> m String
input question = inputWithDefault question emptyString
