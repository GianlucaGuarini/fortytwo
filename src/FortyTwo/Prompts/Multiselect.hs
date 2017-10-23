{-# LANGUAGE NamedFieldPuns #-}

module FortyTwo.Prompts.Multiselect (multiselect, multiselectWithDefault) where

import FortyTwo.Renderers.Multiselect (renderOptions)
import FortyTwo.Renderers.Question (renderQuestion)
import FortyTwo.Types(Option(..), Options)
import System.Console.ANSI (cursorUpLine, clearFromCursorToScreenEnd)
import FortyTwo.Utils
import Data.Maybe
import FortyTwo.Constants

-- | Loop to let the users select an single option
loop :: Options -> IO [Int]
loop options = do
  noEcho
  renderOptions options
  key <- getKey
  clearLines $ length options
  res <- handleEvent options key
  restoreEcho
  return res

-- | Handle a user event
handleEvent :: Options -> String -> IO [Int]
handleEvent options key
  | key `elem` [keyUp, keyLeft]  = loop $ moveUp options $ getOptionsMeta options
  | key `elem` [keyDown, keyRight]  = loop $ moveDown options $ getOptionsMeta options
  | key == spaceKey = loop $ toggle options $ getOptionsMeta options
  | key == enterKey = return $ getSelecteOptionsIndexes options
  | otherwise = loop options

toggle :: Options -> (Int, Int, Maybe Int) -> Options
toggle options (minVal, maxVal, focusedIndex) = case focusedIndex of
  Just x -> toggleFocusedOption x options
  Nothing -> options

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

-- | Multi Select prompt, falling back to a default list of values if no answer will be provided
-- multiselectWithDefault "What's your favourite color?" ["Red", "Yellow", "Blue"] ["Red", "Blue"]
multiselectWithDefault :: String -> [String] -> [String] -> IO [String]
multiselectWithDefault question options defaultAnswer = do
  putStrLn emptyString
  renderQuestion question (toCommaSeparatedString defaultAnswer) emptyString
  putStrLn emptyString
  hideCursor'
  flush
  noBuffering
  res <- loop $ stringsToOptions options
  restoreBuffering
  showCursor'
  clearLines 1

  if null res then do
    renderQuestion question emptyString (toCommaSeparatedString defaultAnswer)
    return defaultAnswer
  else do
    let answer = filter' (\ i o -> elem i res) options
    renderQuestion question emptyString (toCommaSeparatedString answer)
    return answer

-- | Multi Select prompt
-- multiselect "What's your favourite color?" ["Red", "Yellow", "Blue"]
multiselect :: String -> [String] -> IO [String]
multiselect question options = multiselectWithDefault question options []
