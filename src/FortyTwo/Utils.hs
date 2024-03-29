{-# LANGUAGE NamedFieldPuns, OverloadedStrings #-}

module FortyTwo.Utils where

import Control.Monad.IO.Class

import System.Console.ANSI (cursorUpLine, clearFromCursorToScreenEnd)
import System.IO (hSetBuffering, hFlush, hSetEcho, hReady, stdin, stdout, BufferMode(..))
import Data.List (findIndex, findIndices, elemIndex, intercalate)
import Control.Applicative ((<$>))
import Data.Maybe (fromJust)
import FortyTwo.Types(Option(..), Options)
import FortyTwo.Constants (emptyString)

-- | Disable the stdin stdout output buffering
noBuffering :: MonadIO m => m ()
noBuffering = liftIO $ do
  hSetBuffering stdin NoBuffering
  hSetBuffering stdout NoBuffering

-- | Enaable the stdin stdout buffering
restoreBuffering :: MonadIO m => m ()
restoreBuffering = liftIO $ do
  hSetBuffering stdin LineBuffering
  hSetBuffering stdout LineBuffering

-- | Avoid echoing the user input
noEcho :: MonadIO m => m ()
noEcho = liftIO $ hSetEcho stdin False

-- | Restore the user input echos
restoreEcho :: MonadIO m => m ()
restoreEcho = liftIO $ hSetEcho stdin True

-- | Clear terminal lines from the current cursor position
clearLines :: MonadIO m => Int -> m ()
clearLines l = liftIO $ do
  -- move up of some lines...
  cursorUpLine l
  -- and clear them
  clearFromCursorToScreenEnd

-- | Map a collection with an index
map' :: (Int -> a -> b) -> [a] -> [b]
map' f = zipWith f [0..]

-- | Filter a collection with index
filter' :: Eq a => (Int -> a -> Bool) -> [a] -> [a]
filter' f xs = [x | x <- xs, f (fromJust (elemIndex x xs)) x]

-- | Get the value of any keyboard press
getKey :: IO String
getKey = reverse <$> getKey' emptyString
  where
    getKey' chars = do
      char <- getChar
      more <- hReady stdin
      (if more then getKey' else return) (char:chars)

-- | Flush the output buffer
flush :: IO()
flush = hFlush stdout

-- | Get useful informations from the options collection, like minVal, maxVal, activeIndex
getOptionsMeta :: Options -> (Int, Int, Maybe Int)
getOptionsMeta options = (0, length options - 1, getFocusedOptionIndex options)

-- | Get the amount of breaking lines needed to display all the options
getOptionsLines :: Options -> Int
getOptionsLines = sum . map (length . lines . getOptionValue)

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

-- | Normalise the select/multiselect multi lines adding the spaces to format them properly
addBreakingLinesSpacing :: String -> String -> String
addBreakingLinesSpacing separator value =
  if null multiLines then
    value
  else
    firstLine ++ "\n" ++ unlines (take (length normalisedLines - 1) normalisedLines) ++ last normalisedLines
  where
    values = lines value
    firstLine = head values
    multiLines = tail values
    normalisedLines = map (\text -> separator ++ text) multiLines

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
