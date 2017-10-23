module FortyTwo.Prompts.Password (password) where

import FortyTwo.Renderers.Password (getPassword, hideLetters)
import FortyTwo.Renderers.Question (renderQuestion)
import FortyTwo.Utils (clearLines, flush)
import FortyTwo.Constants (emptyString)

-- | Ask a user password
-- password "What your secret password?"
password :: String -> IO String
password question = do
  putStrLn emptyString
  renderQuestion question emptyString emptyString
  putStr " "
  flush
  answer <- getPassword
  clearLines 1
  renderQuestion question emptyString $ hideLetters answer
  return answer
