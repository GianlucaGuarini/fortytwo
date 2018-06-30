# fortytwo

_Interactive terminal prompt_

[![Build Status][travis-image]][travis-url]
[![MIT License][license-image]][license-url]

![fortytwo](https://github.com/GianlucaGuarini/fortytwo/raw/develop/fortytwo.jpg)

## Installation

```sh
cabal install fortytwo
```

## Demo

![Demo](https://github.com/GianlucaGuarini/fortytwo/raw/develop/demo.gif)

## API

### Prompts

#### Input
Ask a simple question requiring the user to type any string. It returns always a `String`

```hs
import FortyTwo (input)

main :: IO String
main = input "What's your name?"
```

`inputWithDefault` will let you define a fallback answer if no answer will be provided
```hs
import FortyTwo (inputWithDefault)

main :: IO String
main = inputWithDefault "What's your name?" "Undefined"
```

#### Confirm
Confirm prompt returning a boolean either `True` or `False`. If no answer will be provided it will return `False`

```hs
import FortyTwo (confirm)

main :: IO Bool
main = confirm "Are you old enough to see this?"
```

`confirmWithDefault` will let you define a fallback answer if no answer will be provided
```hs
import FortyTwo (confirmWithDefault)

main :: IO Bool
main = confirmWithDefault "Are you old enough to see this?" True
```

#### Password
Password prompt hiding the values typed by the user. It will always return a `String`

```hs
import FortyTwo (password)

main :: IO String
main = password "What's your secret password?"
```

#### Select
Select prompt letting users decide between one of many possible answers. It will always return a `String`

```hs
import FortyTwo (select)

main :: IO String
main = select
         "What's your favourite color?"
         ["Red", "Yellow", "Blue"]
```

`selectWithDefault` will let you define a fallback answer if no answer will be provided
```hs
import FortyTwo (selectWithDefault)

main :: IO String
main = selectWithDefault
         "What's your favourite color?"
         ["Red", "Yellow", "Blue"]
         "Red"
```

#### Multiselect
Multiselect prompt letting users decide between multiple possible choices. It will always return a collection `[String]`

```hs
import FortyTwo (multiselect)

main :: IO [String]
main = multiselect
         "What are your favourite films?"
         ["Titanic", "Matrix", "The Gladiator"]
```

`multiselectWithDefault` will let you define a fallback answer if no answer will be provided
```hs
import FortyTwo (multiselectWithDefault)

main :: IO [String]
main = multiselectWithDefault
         "What are your favourite films?"
         ["Titanic", "Matrix", "The Gladiator"]
         ["The Gladiator"]
```

# Inspiration

This script is heavily inspired by [survey (golang)](https://github.com/AlecAivazis/survey)

[travis-image]:https://img.shields.io/travis/GianlucaGuarini/fortytwo.svg?style=flat-square
[travis-url]:https://travis-ci.org/GianlucaGuarini/fortytwo

[license-image]:http://img.shields.io/badge/license-MIT-000000.svg?style=flat-square
[license-url]:LICENSE
