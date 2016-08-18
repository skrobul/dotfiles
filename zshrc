zmodload zsh/zprof
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
EOBUNDLES

# Theme
ZSH_POWERLINE_SHOW_IP=false
ZSH_POWERLINE_SHOW_USER=false
. ~/dotfiles/zsh/prompt.zsh


# apply
antigen apply
autoload -Uz compinit
export VISUAL=vim
autoload edit-command-line; zle -N edit-command-line
bindkey -M vicmd v edit-command-line
# core configuration
CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
DISABLE_LS_COLORS="false"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

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

# Key mappings
bindkey '^[[1;9C' forward-word
bindkey '^[[1;9D' backward-word

export PATH="$HOME/.bin:$PATH"
if [ -s ~/.rvm/scripts/rvm ] ; then source ~/.rvm/scripts/rvm ; fi

# # base16
# BASE16_SHELL="$HOME/.config/base16-shell/base16-ocean.dark.sh"
# [[ -s $BASE16_SHELL ]] && source $BASE16_SHELL


# Shared tmux widnow
alias irc='tmux new-session -s shared "tmux new-window -n irc weechat"'

# ssh() {
#   tmux rename-window "$*"
#   command ssh "$@"
#   tmux rename-window "zsh (exited ssh)"
#   tmux set automatic-rename on > /dev/null 2>&1
# }

alias ag='ag --color-path "1;36"'

# Netsec aliases
alias ns-cli="~/devel/nscli/ns_cli.py"
alias nscli="~/devel/nscli/ns_cli.py"

PERL_MB_OPT="--install_base \"/Users/marek.skrobacki/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/marek.skrobacki/perl5"; export PERL_MM_OPT;

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='ag -g ""'
alias weather="curl -4 http://wttr.in/London"
alias t="task"

