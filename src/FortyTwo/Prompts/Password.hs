module FortyTwo.Prompts.Password (password) where

import System.Console.ANSI (cursorBackward, clearFromCursorToScreenEnd, setCursorColumn, clearFromCursorToLineEnd)
import Control.Monad (unless)
import FortyTwo.Renderers.Password (renderPassword, hideLetters)
import FortyTwo.Renderers.Question (renderQuestion)
import FortyTwo.Constants (emptyString, enterKey, delKey)
import FortyTwo.Utils

-- | Ask a user password
-- password "What your secret password?"
password :: String -> IO String
password question = do
  putStrLn emptyString
  renderQuestion question emptyString emptyString
  putStr " "
  flush
  noBuffering
  answer <- loop emptyString
  restoreBuffering
  -- for the password prompt we need to clear the prompt a bit differently
  setCursorColumn 0
  clearFromCursorToLineEnd
  renderQuestion question emptyString $ hideLetters answer
  return answer

-- | Loop to let the users select an single option
loop :: String -> IO String
loop pass = do
  noEcho
  renderPassword pass
  key <- getKey

  -- Cancel part of the password avoiding to cancel the question as well
  -- the password and the question are located on the same line
  unless (null pass) $ do
    cursorBackward $ length pass
    clearFromCursorToScreenEnd

  -- Try to filter the control keys
  res <- handleEvent pass (if length key > 1 then emptyString else key)
  restoreEcho
  return res

-- | Handle a user event
handleEvent :: String -> String -> IO String
handleEvent pass key
  | key == enterKey = return pass
  | key == delKey =
    if null pass then return loop emptyString pass
    else return loop emptyString (init pass)
  | otherwise = loop $ pass ++ key
