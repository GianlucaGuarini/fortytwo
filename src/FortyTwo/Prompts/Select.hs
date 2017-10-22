{-# LANGUAGE NamedFieldPuns #-}

module FortyTwo.Prompts.Select (
  select,
  selectWithDefault,
  stringsToOptions,
  updateOptions,
  getOptionValue,
  getOptionIsFocused,
  getSelectedOptionIndex,
  getOptionsMeta
  )
where

import FortyTwo.Renderers.Select (renderOptions)
import FortyTwo.Renderers.Question (renderQuestion)
import System.Console.ANSI (cursorUpLine, clearFromCursorToScreenEnd)
import FortyTwo.Types(Option(..), Options)
import System.IO (hFlush, stdout)
import FortyTwo.Utils (clearLines, noEcho, restoreEcho, noBuffering, restoreBuffering, getKey)
import Data.Maybe
import Data.List
import FortyTwo.Constants

-- | Convert a string array to
stringsToOptions :: [String] -> Options
stringsToOptions options = [
    Option { value = o, isFocused = False, isSelected = False } | o <- options
  ]

updateOptions :: Int -> Options -> Options
updateOptions focusedIndex options = [
    Option { value = getOptionValue $ (!!) options i, isFocused = focusedIndex == i, isSelected = False } |
    i <- [0..(length options - 1)]
  ]

-- | Get the value of any option
getOptionValue :: Option -> String
getOptionValue Option { value } = value

-- | Get the is focused attribute of any option
getOptionIsFocused :: Option -> Bool
getOptionIsFocused Option { isFocused } = isFocused

-- | Get the index of the option selected
getSelectedOptionIndex :: Options -> Maybe Int
getSelectedOptionIndex = findIndex getOptionIsFocused

-- | Loop to let the users select an single option
loop :: Options -> IO (Maybe Int)
loop options = do
  noEcho
  renderOptions options
  key <- getKey
  clearLines $ length options
  res <- handleEvent options key
  restoreEcho
  return res

-- | Handle a user event
handleEvent :: Options -> String -> IO (Maybe Int)
handleEvent options key
  | key `elem` [keyUp, keyLeft]  = loop $ moveUp options $ getOptionsMeta options
  | key `elem` [keyDown, keyRight]  = loop $ moveDown options $ getOptionsMeta options
  | key `elem` [enterKey, spaceKey] = return $ getSelectedOptionIndex options
  | otherwise = loop options

-- | Handle an arrow up event
moveUp :: Options -> (Int, Int, Maybe Int) -> Options
moveUp options (minVal, maxVal, selectedIndex) = case selectedIndex of
  Just x -> if x == minVal then
             updateOptions x options
            else
             updateOptions (x - 1) options
  Nothing -> updateOptions maxVal options

-- | Handle an arrow down event
moveDown :: Options -> (Int, Int, Maybe Int) -> Options
moveDown options (minVal, maxVal, selectedIndex) = case selectedIndex of
  Just x -> if x == maxVal then
             updateOptions x options
            else
             updateOptions (x + 1) options
  Nothing -> updateOptions minVal options

-- | Get useful informations from the options collection, like minVal, maxVal, activeIndex
getOptionsMeta :: Options -> (Int, Int, Maybe Int)
getOptionsMeta options = (0, length options - 1, getSelectedOptionIndex options)

-- | Select prompt from a list of options falling back to a default value if no answer will be provided
-- selectWithDefault "What's your favourite color?" ["Red", "Yellow", "Blue"] "Red"
selectWithDefault :: String -> [String] -> String -> IO String
selectWithDefault question options defaultAnswer = do
  putStrLn emptyString
  renderQuestion question defaultAnswer emptyString
  putStrLn emptyString
  hFlush stdout
  noBuffering
  res <- loop $ stringsToOptions options
  restoreBuffering
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
select :: String -> [String] -> IO String
select question options = selectWithDefault question options []
