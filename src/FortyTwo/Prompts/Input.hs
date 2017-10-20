module FortyTwo.Prompts.Input
    (
      inputWithDefault,
      input
    ) where

import FortyTwo.Renderers.Question (renderQuestion)
import System.Console.ANSI (cursorUpLine, clearFromCursorToScreenEnd)

-- | Ask a simple input question falling back to a default value if no answer will be provided
-- inputWithDefault "What is your name?" "The Dude"
inputWithDefault :: String -> String -> IO String
inputWithDefault question defaultAnswer = do
  putStrLn ""
  renderQuestion question defaultAnswer ""
  putStrLn ""
  answer <- getLine
  -- move up of 2 lines...
  cursorUpLine 2
  -- and clear them
  clearFromCursorToScreenEnd
  -- return the default answer if no answer was given
  if null answer then do
    renderQuestion question "" defaultAnswer
    return defaultAnswer
  else do
    renderQuestion question "" answer
    return answer

-- | Simple input question
-- input "What is your name?"
input :: String -> IO String
input question = inputWithDefault question ""
