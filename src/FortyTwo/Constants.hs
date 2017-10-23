module FortyTwo.Constants where

-- | Up arrow key identifier
upKey :: String
upKey = "\ESC[A"

-- | Down arrow key identifier
downKey :: String
downKey = "\ESC[B"

-- | Right arrow key identifier
rightKey :: String
rightKey = "\ESC[C"

-- | Left arrow key identifier
leftKey :: String
leftKey = "\ESC[D"

-- | Delete key identifier
delKey :: String
delKey = "\DEL"

-- | Enter key identifier
enterKey :: String
enterKey = "\n"

-- | Space key identifier
spaceKey :: String
spaceKey = " "

-- | Just an empty string to use here and there...
emptyString :: String
emptyString = ""

-- | Char used to highlight a option
focusIcon :: Char
focusIcon = '❯'

-- | Char to identify the options selected
selectedIcon :: Char
selectedIcon = '◉'

-- | Char to identify the options not yet selected
unselectedIcon :: Char
unselectedIcon = '◯'

-- | Char used to hide the password letters
passwordHiddenChar :: Char
passwordHiddenChar = '*'
