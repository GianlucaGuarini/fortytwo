module FortyTwo.Prompts.Input
    (
      inputWithDefault,
      input
    ) where

import FortyTwo.Renderers.Question (renderQuestion)
import System.Console.ANSI (cursorUpLine, clearFromCursorToScreenEnd)

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
  renderQuestion question "" answer
  return answer

-- | Simple input question
input :: String -> IO String
input question = inputWithDefault question ""
