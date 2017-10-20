module FortyTwo.Prompts.Confirm (confirm, confirmWithDefault) where

import qualified Data.Text as T

import System.IO (hFlush, stdout)
import FortyTwo.Renderers.Question (renderQuestion)
import System.Console.ANSI (cursorUpLine, clearFromCursorToScreenEnd)

-- | Normalize a string transforming it to lowercase and trimming it and getting either n or y
normalizeString :: String -> String
normalizeString s = take 1 $ T.unpack $ T.strip . T.toLower $ T.pack s

-- | Get a clean user input string
getCleanConfirm :: IO String
getCleanConfirm = do s <- getLine; return $ normalizeString s

-- | Ask a confirm falling back to a default value if no answer will be provided
-- confirmWithDefault "Do you like music?" True
confirmWithDefault :: String -> Bool -> IO Bool
confirmWithDefault question defaultAnswer = do
  putStrLn ""
  renderQuestion question defaultAnswerHumanized ""
  putStr " (y/N) "
  hFlush stdout
  answer <- getCleanConfirm
  -- move up of 1 line...
  cursorUpLine 1
  -- and clear them
  clearFromCursorToScreenEnd
  if answer == "n" || answer /= "y" && not defaultAnswer then do
    renderQuestion question "" "no"
    return False
  else do
    renderQuestion question "" "yes"
    return True
  where
    defaultAnswerHumanized = if defaultAnswer then "yes" else "no"

-- | Ask a confirm question by default it will be true
-- confirm "Do you like music?"
confirm :: String -> IO Bool
confirm question = confirmWithDefault question True
