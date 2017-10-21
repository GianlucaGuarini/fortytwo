module FortyTwo.Renderers.Confirm
    (
      renderConfirm
    ) where

-- | Render the helper text
renderConfirm :: IO ()
renderConfirm = putStr " (y/N) "
