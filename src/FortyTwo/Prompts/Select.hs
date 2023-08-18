{-# LANGUAGE NamedFieldPuns #-}

module FortyTwo.Prompts.Select (select, selectWithDefault) where

import Control.Monad.IO.Class

import System.Console.ANSI (hideCursor, showCursor)
import FortyTwo.Renderers.Select (renderOptions)
import FortyTwo.Renderers.Question (renderQuestion)
import FortyTwo.Types(Options)
import FortyTwo.Utils
import FortyTwo.Constants

-- | Loop to let the users select an single option
loop :: Options -> IO (Maybe Int)
loop options = do
  noEcho
  renderOptions options
  key <- getKey
  clearLines $ getOptionsLines options
  res <- handleEvent options key
  restoreEcho
  return res

-- | Handle a user event
handleEvent :: Options -> String -> IO (Maybe Int)
handleEvent options key
  | key `elem` [upKey, leftKey]  = loop $ moveUp options $ getOptionsMeta options
  | key `elem` [downKey, rightKey]  = loop $ moveDown options $ getOptionsMeta options
  | key `elem` [enterKey, spaceKey] = return $ getFocusedOptionIndex options
  | otherwise = loop options

-- | Handle an arrow up event
moveUp :: Options -> (Int, Int, Maybe Int) -> Options
moveUp options (minVal, maxVal, focusedIndex) = case focusedIndex of
  Just x -> if x == minVal then
             focusOption x options
            else
             focusOption (x - 1) options
  Nothing -> focusOption maxVal options

-- | Handle an arrow down event
moveDown :: Options -> (Int, Int, Maybe Int) -> Options
moveDown options (minVal, maxVal, focusedIndex) = case focusedIndex of
  Just x -> if x == maxVal then
             focusOption x options
            else
             focusOption (x + 1) options
  Nothing -> focusOption minVal options

-- | Select prompt from a list of options falling back to a default value if no answer will be provided
-- selectWithDefault "What's your favourite color?" ["Red", "Yellow", "Blue"] "Red"
selectWithDefault :: MonadIO m => String -> [String] -> String -> m String
selectWithDefault question options defaultAnswer = liftIO $ do
  putStrLn emptyString
  renderQuestion question defaultAnswer emptyString
  putStrLn emptyString
  hideCursor
  flush
  noBuffering
  res <- loop $ stringsToOptions options
  restoreBuffering
  showCursor
  clearLines 1

  case res of
    Just x  -> do
      let answer = (!!) options x
      renderQuestion question emptyString answer
      return answer
    -- If no user input will be provided..
    Nothing -> do
      -- ..let's return the default answer
      renderQuestion question emptyString defaultAnswer
      return defaultAnswer

-- | Select prompt from a list of options
-- select "What's your favourite color?" ["Red", "Yellow", "Blue"]
select :: MonadIO m => String -> [String] -> m String
select question options = selectWithDefault question options emptyString
