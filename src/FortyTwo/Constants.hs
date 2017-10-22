module FortyTwo.Constants where

keyUp :: String
keyUp = "\ESC[A"

keyDown :: String
keyDown = "\ESC[B"

keyRight :: String
keyRight = "\ESC[C"

keyLeft :: String
keyLeft = "\ESC[D"

enterKey :: String
enterKey = "\n"

spaceKey :: String
spaceKey = " "

emptyString :: String
emptyString = ""

-- | Char used to highlight a select
selectFocusIcon :: Char
selectFocusIcon = '❯'

-- | Char used to hide the password letters
passwordHiddenChar :: Char
passwordHiddenChar = '*'
