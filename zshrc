bindkey -e
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

source ~/dotfiles/antigen/antigen.zsh

#antigen config
antigen use oh-my-zsh

# List of bundles to install
antigen bundles <<EOBUNDLES
     git
     zsh-users/zsh-syntax-highlighting
      zsh-users/zsh-completions src
     rails
     ruby
     rvm
     tmux
     docker
     colored-man
     Tarrasch/zsh-bd
     autojump
EOBUNDLES

# Theme
ZSH_POWERLINE_SHOW_IP=false
ZSH_POWERLINE_SHOW_USER=false
# antigen theme skrobul/oh-my-zsh-solarized-powerline-theme solarized-powerline
antigen theme muse

# apply
antigen apply

# core configuration
CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
DISABLE_LS_COLORS="false"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

#
# Plugins configuration
#
ZSH_TMUX_AUTOSTART=true
ZSH_TMUX_AUTOSTART_ONCE=false
ZSH_TMUX_ITERM2=false
ZSH_TMUX_AUTOQUIT=false


# Store device specific settings like DEFAULT_USER
source ~/.zshrc.local
source ~/.rvm/scripts/rvm

# Key mappings
bindkey '^[[1;9C' forward-word
bindkey '^[[1;9D' backward-word

export PATH="$HOME/.bin:$PATH"
if [ -s ~/.rvm/scripts/rvm ] ; then source ~/.rvm/scripts/rvm ; fi

# base16
BASE16_SHELL="$HOME/.config/base16-shell/base16-bright.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL
