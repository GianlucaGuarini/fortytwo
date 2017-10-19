module FortyTwo.Prompts.Confirm
    (
      confirm
    ) where

import qualified Data.Text as T

import FortyTwo.Renderers.Question (renderQuestion)
import System.Console.ANSI (cursorUpLine, clearFromCursorToScreenEnd)

-- | Normalize a string transforming it to lowercase and trimming it
normalizeString :: String -> String
normalizeString s = T.unpack $ T.strip . T.toLower $ T.pack s

-- | Get a clean user input string
getCleanConfirm :: IO String
getCleanConfirm = do s <- getChar; return $ normalizeString [s]

-- | Ask a confirm question by default it will be true
-- confirm "Do you like music?"
confirm :: String -> IO Bool
confirm question = do
  putStrLn ""
  renderQuestion question "y/N" ""
  putStrLn ""
  answer <- getCleanConfirm
  -- move up of 2 lines...
  cursorUpLine 2
  -- and clear them
  clearFromCursorToScreenEnd
  if answer == "n" then do
    renderQuestion question "" "no"
    return False
  else do
    renderQuestion question "" "yes"
    return True
