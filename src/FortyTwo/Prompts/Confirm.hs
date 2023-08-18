module FortyTwo.Prompts.Confirm (confirm, confirmWithDefault) where

import qualified Data.Text as T

import FortyTwo.Renderers.Confirm (renderConfirm)
import FortyTwo.Renderers.Question (renderQuestion)
import FortyTwo.Utils (clearLines, flush)
import FortyTwo.Constants (emptyString)

-- | Normalize a string transforming it to lowercase and trimming it and getting either n or y
-- >>> normalizeString "Yes"
-- "y"
normalizeString :: String -> String
normalizeString s = take 1 $ T.unpack $ T.strip . T.toLower $ T.pack s

-- | Get a clean user input string
getCleanConfirm :: IO String
getCleanConfirm = do s <- getLine; return $ normalizeString s

-- | Ask a confirm falling back to a default value if no answer will be provided
confirmWithDefault :: String -> Bool -> IO Bool
confirmWithDefault question defaultAnswer = do
  putStrLn emptyString
  renderQuestion question defaultAnswerHumanized emptyString
  renderConfirm defaultAnswer
  flush
  answer <- getCleanConfirm
  clearLines 1
  if answer == "n" || (answer /= "y" && not defaultAnswer) then do
    renderQuestion question emptyString "no"
    return False
  else do
    renderQuestion question emptyString "yes"
    return True
  where
    defaultAnswerHumanized = if defaultAnswer then "yes" else "no"

-- | Ask a confirm question by default it will be true
confirm :: String -> IO Bool
confirm question = confirmWithDefault question False
