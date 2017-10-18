{-# LANGUAGE OverloadedStrings #-}

module FortyTwo
    (
      theAnswer,
      input
    ) where

import System.Console.ANSI

-- | The answer to everything
theAnswer :: Int
theAnswer = 42

-- | Print any message depending on its type
renderMessage :: String -> String -> IO()
renderMessage typ message
  | typ == "question" = do
      setSGR [SetColor Foreground Dull Green]
      putStr "? "
      setSGR [Reset]
      setSGR [SetColor Foreground Dull White]
      putStr message
      setSGR [Reset]
  | typ == "answer" = do
      setSGR [SetColor Foreground Dull Cyan]
      putStr $ " " ++ message
      setSGR [Reset]
  | typ == "default" = do
    setSGR [SetColor Foreground Vivid Yellow]
    putStr $ " (" ++ message ++ ")"
    setSGR [Reset]

-- | Print the question message
renderQuestion :: String -> String -> String -> IO ()
renderQuestion question defaultAnswer answer
  | hasDefaultAnswer && hasAnswer = do
      renderMessage "question" question
      renderMessage "default" defaultAnswer
      renderMessage "answer" answer
  | hasDefaultAnswer = do
      renderMessage "question" question
      renderMessage "default" defaultAnswer
  | hasAnswer = do
      renderMessage "question" question
      renderMessage "answer" answer
  | otherwise = renderMessage "question" question
  where
      hasDefaultAnswer = not $ null defaultAnswer
      hasAnswer = not $ null answer

-- | Simple input question
input :: String -> String -> IO String
input question defaultAnswer = do
  renderQuestion question defaultAnswer ""
  putStrLn ""
  answer <- getLine
  cursorUpLine 2
  clearFromCursorToScreenEnd
  renderQuestion question "" answer
  return answer
