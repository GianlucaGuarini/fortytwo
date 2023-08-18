module FortyTwo.Renderers.Confirm
    (
      renderConfirm
    ) where

-- | Render the helper text
renderConfirm :: Bool -> IO ()
renderConfirm defaultAnswer = putStr $ " (" ++ msg ++ ") "
  where
    msg | defaultAnswer = "Y/n"
        | otherwise = "y/N"
