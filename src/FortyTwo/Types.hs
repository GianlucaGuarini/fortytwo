module FortyTwo.Types where

-- | UI message types
data Message = Question | DefaultAnswer | Answer deriving (Eq)

-- | Struct needed for rendering the select prompts
data Option = Option {
  isSelected :: Bool,
  isFocused :: Bool,
  value :: String
} deriving (Eq, Show)

type Options = [Option]
