module FortyTwo.Prompts.Input (inputWithDefault, input) where

import System.IO (hFlush, stdout)
import FortyTwo.Renderers.Question (renderQuestion)
import System.Console.ANSI (cursorUpLine, clearFromCursorToScreenEnd)
import FortyTwo.Utils (clearLines)
import FortyTwo.Constants (emptyString)

-- | Ask a simple input question falling back to a default value if no answer will be provided
-- inputWithDefault "What is your name?" "The Dude"
inputWithDefault :: String -> String -> IO String
inputWithDefault question defaultAnswer = do
  putStrLn emptyString
  renderQuestion question defaultAnswer emptyString
  putStr " "
  hFlush stdout
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
input :: String -> IO String
input question = inputWithDefault question emptyString
