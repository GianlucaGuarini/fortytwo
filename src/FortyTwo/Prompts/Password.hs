module FortyTwo.Prompts.Password
    (
      password
    ) where

import System.IO (hFlush, stdout)
import FortyTwo.Renderers.Password (getPassword, hideLetters)
import FortyTwo.Renderers.Question (renderQuestion)
import System.Console.ANSI (cursorUpLine, clearFromCursorToScreenEnd)

-- | Ask a user password
-- password "What your secret password?"
password :: String -> IO String
password question = do
  putStrLn ""
  renderQuestion question "" ""
  putStr " "
  hFlush stdout
  answer <- getPassword
  -- move up of 1 line...
  cursorUpLine 1
  -- and clear them
  clearFromCursorToScreenEnd
  renderQuestion question "" $ hideLetters answer
  return answer
