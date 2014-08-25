# Path to your oh-my-fish.
set fish_path $HOME/.oh-my-fish

# Theme
set fish_theme bobthefish

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-fish/plugins/*)
# Custom plugins may be added to ~/.oh-my-fish/custom/plugins/
# Example format: set fish_plugins autojump bundler
#set fish_plugins autojump bundler git node rvm
set fish_plugins rvm git bundler node rails

# Path to your custom folder (default path is $FISH/custom)
#set fish_custom $HOME/dotfiles/oh-my-fish

# Load oh-my-fish configuration.
. $fish_path/oh-my-fish.fish

# Docker setup
set -x DOCKER_HOST tcp://192.168.59.103:2375
function docker-enter
  boot2docker ssh '[ -f /var/lib/boot2docker/nsenter ] || docker run --rm -v /var/lib/boot2docker/:/target jpetazzo/nsenter'
  boot2docker ssh -t sudo /var/lib/boot2docker/docker-enter $argv
end


# todo.txt related
alias t="todo.sh"
alias te="subl ~/Dropbox/todo/todo.txt"
set -x TODOTXT_DEFAULT_ACTION ls

# local path
set PATH $PATH /Users/marek.skrobacki/bin/

# other aliases
alias cbast="ssh cbast1.lon3.corp.rackspace.com"


# private stuff...
. $HOME/.config/fish/private.fish
