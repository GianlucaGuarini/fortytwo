{-# LANGUAGE NamedFieldPuns #-}

module FortyTwo.Utils where

import System.Console.ANSI (cursorUpLine, clearFromCursorToScreenEnd)
import System.IO (hSetBuffering, hFlush, hSetEcho, hReady, stdin, stdout, BufferMode(..))
import Data.List (findIndex, findIndices, elemIndex, intercalate)
import Control.Monad (when)
import Data.Maybe (fromJust)
import FortyTwo.Types(Option(..), Options)
import FortyTwo.Constants (emptyString)

noBuffering :: IO()
noBuffering = do
  hSetBuffering stdin NoBuffering
  hSetBuffering stdout NoBuffering

restoreBuffering :: IO()
restoreBuffering = do
  hSetBuffering stdin LineBuffering
  hSetBuffering stdout LineBuffering

noEcho :: IO ()
noEcho = hSetEcho stdin False

restoreEcho :: IO ()
restoreEcho = hSetEcho stdin True

clearLines :: Int -> IO()
clearLines lines' = do
  -- move up of 1 line...
  cursorUpLine lines'
  -- and clear them
  clearFromCursorToScreenEnd

-- | Map a collection with an index
map' :: (Int -> a -> b) -> [a] -> [b]
map' f = zipWith f [0..]

-- | Filter a collection with index
filter' :: Eq a => (Int -> a -> Bool) -> [a] -> [a]
filter' f xs = [x | x <- xs, f (fromJust (elemIndex x xs)) x]

getKey = reverse <$> getKey' emptyString
  where
    getKey' chars = do
      char <- getChar
      more <- hReady stdin
      (if more then getKey' else return) (char:chars)

-- | Get useful informations from the options collection, like minVal, maxVal, activeIndex
getOptionsMeta :: Options -> (Int, Int, Maybe Int)
getOptionsMeta options = (0, length options - 1, getFocusedOptionIndex options)

-- | Convert a string array to
stringsToOptions :: [String] -> Options
stringsToOptions options = [
    Option { value = o, isFocused = False, isSelected = False } | o <- options
  ]

-- | Give the focus to a single option in the collection
focusOption :: Int -> Options -> Options
focusOption focusedIndex = map' $ \ i o ->
  Option {
    value = getOptionValue o,
    isSelected = getOptionIsSelected o,
    isFocused = focusedIndex == i
  }
-- | Toggle the isSelected flag for a single option
toggleFocusedOption :: Int -> Options -> Options
toggleFocusedOption focusedIndex = map' $ \ i o ->
  Option {
    value = getOptionValue o,
    isFocused = focusedIndex == i,
    isSelected = if focusedIndex == i then
      not $ getOptionIsSelected o
      else getOptionIsSelected o
  }

-- | Print a list to comma separated
toCommaSeparatedString :: [String] -> String
toCommaSeparatedString = intercalate ", "

-- | Flush the output buffer
flush :: IO()
flush = hFlush stdout

-- | Get the value of any option
getOptionValue :: Option -> String
getOptionValue Option { value } = value

-- | Get the is focused attribute of any option
getOptionIsFocused :: Option -> Bool
getOptionIsFocused Option { isFocused } = isFocused

-- | Get the is selected attribute of any option
getOptionIsSelected :: Option -> Bool
getOptionIsSelected Option { isSelected } = isSelected

-- | Get the index of the option selected
getFocusedOptionIndex :: Options -> Maybe Int
getFocusedOptionIndex = findIndex getOptionIsFocused

-- | Filter the indexes of the options selected
getSelecteOptionsIndexes :: Options -> [Int]
getSelecteOptionsIndexes = findIndices getOptionIsSelected
