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
      putStr text
      setSGR [Reset]
  | messageType == Answer = do
      setSGR [SetColor Foreground Dull Cyan]
      putStr $ " " ++ text
      setSGR [Reset]
  | messageType == DefaultAnswer = do
    setSGR [SetConsoleIntensity FaintIntensity]
    putStr $ " (" ++ text ++ ")"
    setSGR [Reset]
  | otherwise =
      putStr text
    where
      text = (unwords . lines) message

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
