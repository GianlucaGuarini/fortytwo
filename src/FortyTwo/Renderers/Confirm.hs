module FortyTwo.Renderers.Confirm
    (
      renderConfirm
    ) where

import Control.Monad.IO.Class

-- | Render the helper text
renderConfirm :: MonadIO m => Bool -> m ()
renderConfirm defaultAnswer = liftIO $ putStr $ " (" ++ msg ++ ") "
  where
    msg | defaultAnswer = "Y/n"
        | otherwise = "y/N"
