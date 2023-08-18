module FortyTwo.Renderers.Question (renderQuestion, renderMessage) where

import Control.Monad.IO.Class

import FortyTwo.Types (Message(..))
import System.Console.ANSI

-- | Print any message depending on its type
renderMessage :: MonadIO m => Message -> String -> m ()
renderMessage messageType message
  | messageType == Question = liftIO $ do
      setSGR [SetColor Foreground Dull Green]
      putStr "? "
      setSGR [Reset]
      setSGR [SetConsoleIntensity BoldIntensity]
      putStr text
      setSGR [Reset]
  | messageType == Answer = liftIO $ do
      setSGR [SetColor Foreground Dull Cyan]
      putStr $ " " ++ text
      setSGR [Reset]
  | messageType == DefaultAnswer = liftIO $ do
    setSGR [SetConsoleIntensity FaintIntensity]
    putStr $ " (" ++ text ++ ")"
    setSGR [Reset]
  | otherwise =
      liftIO $ putStr text
    where
      text = (unwords . lines) message

-- | Print the question message
renderQuestion :: MonadIO m => String -> String -> String -> m ()
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
