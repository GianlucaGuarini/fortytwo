module FortyTwo.Prompts.Select (select, selectWithDefault) where

import FortyTwo.Renderers.Select (getOption)
import FortyTwo.Types(Option(..), Options)

stringsToOptions :: [String] -> Options
stringsToOptions opts = [Option { value = o, isFocused = False, isSelected = False } | o <- opts]

selectWithDefault :: String -> [String] -> [String] -> IO [String]
selectWithDefault question options defaultAnswers = do
  putStrLn ""
  res <- getOption $ stringsToOptions options
  return ["foo", "bar"]

select :: String -> [String] -> IO [String]
select question options = selectWithDefault question options []
