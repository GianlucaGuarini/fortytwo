module FortyTwo.Prompts.Password (password) where

import System.IO (hFlush, stdout)
import FortyTwo.Renderers.Password (getPassword, hideLetters)
import FortyTwo.Renderers.Question (renderQuestion)
import System.Console.ANSI (cursorUpLine, clearFromCursorToScreenEnd)
import FortyTwo.Utils (clearLines)
import FortyTwo.Constants (emptyString)

-- | Ask a user password
-- password "What your secret password?"
password :: String -> IO String
password question = do
  putStrLn emptyString
  renderQuestion question emptyString emptyString
  putStr " "
  hFlush stdout
  answer <- getPassword
  clearLines 1
  renderQuestion question emptyString $ hideLetters answer
  return answer
