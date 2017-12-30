module FortyTwo.Renderers.Question (renderQuestion, renderMessage) where

import FortyTwo.Types (Message(..))
import System.Console.ANSI

-- | Print any message depending on its type
renderMessage :: Message -> String -> IO()
renderMessage messageType message
  | messageType == Question = do
      setSGR [SetColor Foreground Dull Green]
      putStr "? "
      setSGR [Reset]
      setSGR [SetConsoleIntensity BoldIntensity]
      putStr message
      setSGR [Reset]
  | messageType == Answer = do
      setSGR [SetColor Foreground Dull Cyan]
      putStr $ " " ++ message
      setSGR [Reset]
  | messageType == DefaultAnswer = do
    setSGR [SetConsoleIntensity FaintIntensity]
    putStr $ " (" ++ message ++ ")"
    setSGR [Reset]
  | otherwise =
      putStr message

-- | Print the question message
renderQuestion :: String -> String -> String -> IO ()
renderQuestion question defaultAnswer answer
  | hasDefaultAnswer && hasAnswer = do
      renderMessage Question question
      renderMessage DefaultAnswer defaultAnswer
      renderMessage Answer answer
  | hasDefaultAnswer = do
      renderMessage Question question
      renderMessage DefaultAnswer defaultAnswer
  | hasAnswer = do
      renderMessage Question question
      renderMessage Answer answer
  | otherwise = renderMessage Question question
  where
      hasDefaultAnswer = not $ null defaultAnswer
      hasAnswer = not $ null answer
