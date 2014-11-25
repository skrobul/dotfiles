# Installation

```
ruby <(curl -fsS https://raw.githubusercontent.com/Homebrew/install/master/install)
brew install rcm
cd ~ ; git clone git@github.com:skrobul/dotfiles.git
env RCRC=$HOME/dotfiles/rcrc rcup -v
```

## Cask
```
brew tap caskroom/cask
brew install brew-cask
brew bundle dotfiles/Brewfile
```
