#!/bin/bash


# Loosely based on https://github.com/thoughtbot/laptop/blob/master/mac
check_xcode_installed() {
    if ! gcc -v > /dev/null ; then
        fancy_echo "XCODE is not installed, but it is required to compile VIM"
        exit 1
    fi
}
fancy_echo() {
  printf "\n%b\n" "$1"
}

append_to_zshrc() {
  local text="$1" zshrc
  local skip_new_line="$2"

  if [[ -w "$HOME/.zshrc.local" ]]; then
    zshrc="$HOME/.zshrc.local"
  else
    zshrc="$HOME/.zshrc"
  fi

  if ! grep -Fqs "$text" "$zshrc"; then
    if (( skip_new_line )); then
      printf "%s\n" "$text" >> "$zshrc"
    else
      printf "\n%s\n" "$text" >> "$zshrc"
    fi
  fi
}

trap 'ret=$?; test $ret -ne 0 && printf "failed\n\n" >&2; exit $ret' EXIT

set -e

if [[ ! -d "$HOME/.bin/" ]]; then
  mkdir "$HOME/.bin"
fi

if [[ ! -f "$HOME/.zshrc" ]]; then
  touch "$HOME/.zshrc"
fi

check_xcode_installed

append_to_zshrc 'export PATH="$HOME/.bin:$PATH"'

if [[ "$SHELL" != */zsh ]]; then
  fancy_echo "Changing your shell to zsh ..."
    chsh -s $(which zsh)
fi

brew_install_or_upgrade() {
  if brew_is_installed "$1"; then
    if brew_is_upgradable "$1"; then
      brew upgrade "$@"
    fi
  else
    brew install "$@"
  fi
}

brew_is_installed() {
  local name="$(brew_expand_alias "$1")"

  brew list -1 | grep -Fqx "$name"
}

brew_is_upgradable() {
  local name="$(brew_expand_alias "$1")"

  brew outdated --quiet "$name" >/dev/null
  [[ $? -ne 0 ]]
}

brew_expand_alias() {
  brew info "$1" 2>/dev/null | head -1 | awk '{gsub(/:/, ""); print $1}'
}

brew_launchctl_restart() {
  local name="$(brew_expand_alias "$1")"
  local domain="homebrew.mxcl.$name"
  local plist="$domain.plist"

  mkdir -p "$HOME/Library/LaunchAgents"
  ln -sfv "/usr/local/opt/$name/$plist" "$HOME/Library/LaunchAgents"

  if launchctl list | grep -q "$domain"; then
    launchctl unload "$HOME/Library/LaunchAgents/$plist" >/dev/null
  fi
  launchctl load "$HOME/Library/LaunchAgents/$plist" >/dev/null
}

brew_cask_install() {
    fancy_echo "Installing CASK: $1"
    brew install $@
}

if ! command -v brew >/dev/null; then
  fancy_echo "Installing Homebrew, a good OS X package manager ..."
    ruby <(curl -fsS https://raw.githubusercontent.com/Homebrew/install/master/install)

    append_to_zshrc '# recommended by brew doctor'
    append_to_zshrc 'export PATH="/usr/local/bin:$PATH"' 1
    export PATH="/usr/local/bin:$PATH"
else
  fancy_echo "Homebrew already installed. Skipping ..."
fi

fancy_echo "Updating Homebrew formulas ..."
brew update



if ! command -v rcup >/dev/null; then
  fancy_echo "Installing rcm, to manage your dotfiles ..."
    brew tap thoughtbot/formulae
    brew_install_or_upgrade 'rcm'
else
  fancy_echo "rcm already installed. Skipping ..."
fi

# Config files
env RCRC=$HOME/dotfiles/rcrc rcup -v

# Cask
brew tap caskroom/cask
brew tap caskroom/fonts
brew_install_or_upgrade brew-cask

CASKS_TO_INSTALL=(
alfred
#caffeine
flux
virtualbox
vagrant
google-chrome
iterm2
sequel-pro
dash
adium
lightpaper
slack
vlc
the-unarchiver
dropbox
box-sync
spotify
evernote
seil
macfusion
disk-inventory-x
macfusion
boot2docker
calibre
cord
keepassx
rescuetime
skitch
java
skype
teamviewer
font-source-code-pro
font-dejavu-sans-mono-for-powerline
font-inconsolata-for-powerline
font-inconsolata-dz-for-powerline
font-sauce-code-powerline
quicklook-csv
quicklook-json
qlmarkdown
)
#karabiner - needs 10.9, disabling for now
CASKS_TO_LINK=(alfred)

for cask in $CASKS_TO_INSTALL; do
    fancy_echo "Installing cask $cask"
     brew cask install $cask
done
for cask in $CASKS_TO_LINK; do
    fancy_echo "Linking cask $cask"
    #brew cask $cask link
done
# Brews...

# custom taps

brew tap thoughtbot/formulae

# brews
brew_install_or_upgrade rcm
brew_install_or_upgrade reattach-to-user-namespace
brew_install_or_upgrade tmux
# brew_install_or_upgrade encfs - conflicts with macfusion binary
brew_install_or_upgrade fleetctl
brew_install_or_upgrade irssi
brew_install_or_upgrade git
brew_install_or_upgrade nmap
brew_install_or_upgrade xz
brew_install_or_upgrade brew-cask
brew_install_or_upgrade node
brew link node
brew_install_or_upgrade postgresql
brew_install_or_upgrade imagemagick
brew_install_or_upgrade cowsay
brew_install_or_upgrade hub
brew_install_or_upgrade gh
brew_install_or_upgrade tig
brew_install_or_upgrade gpg
brew_install_or_upgrade pow
brew link pow
# brew_install_or_upgrade figlet
brew_install_or_upgrade tree

# bugfixes
brew_install_or_upgrade openssl
brew link -f openssl
# Remove outdated versions from the cellar
brew cleanup

# Create empty local files
touch ~/.zshrc.local
touch ~/.gitconfig.local
# Install rvm
gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3
\curl -sSL https://get.rvm.io | bash -s stable --ruby
