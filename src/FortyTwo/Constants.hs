module FortyTwo.Constants where

upKey :: String
upKey = "\ESC[A"

downKey :: String
downKey = "\ESC[B"

rightKey :: String
rightKey = "\ESC[C"

leftKey :: String
leftKey = "\ESC[D"

delKey :: String
delKey = "\DEL"

enterKey :: String
enterKey = "\n"

spaceKey :: String
spaceKey = " "

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
