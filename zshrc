bindkey -e
export PATH=$PATH:/usr/local/bin
fpath=( "$HOME/dotfiles/zsh/pure" $fpath )
ZGEN_AUTOLOAD_COMPINIT=false
#########################
# Zgen plugin manager
#########################
ZSH_THEME=""
source "${HOME}/.zgen/zgen.zsh"
# if the init scipt doesn't exist
if ! zgen saved; then
  # specify plugins here
  zgen oh-my-zsh
  zgen load zsh-users/zsh-syntax-highlighting
  zgen load zsh-users/zsh-completions src
  # zgen oh-my-zsh plugins/gitfast
  # zgen oh-my-zsh plugins/tmux
  # zgen oh-my-zsh plugins/docker
  # zgen oh-my-zsh plugins/colored-man-pages

  # Theme
  # zgen oh-my-zsh themes/miloshadzic

  # generate the init script from plugins above
  zgen save
fi

autoload -U promptinit; promptinit
prompt pure
#########################
# visual command edit
#########################
export VISUAL=vim
autoload edit-command-line; zle -N edit-command-line
bindkey -M vicmd v edit-command-line
# core configuration
CASE_SENSITIVE="false"

# Uncomment the following line to disable colors in ls.
DISABLE_LS_COLORS="false"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="false"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"


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

export PATH="$PATH:$HOME/.bin:$HOME/bin:$HOME/.rvm/bin"

PERL_MB_OPT="--install_base \"/Users/marek.skrobacki/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/marek.skrobacki/perl5"; export PERL_MM_OPT;

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='ag -g ""'
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
alias irc='tmux new-session -s shared "tmux new-window -n irc weechat"'
alias ag='ag --color-path "1;36"'
alias ns-cli="~/devel/nscli/ns_cli.py"
alias nscli="~/devel/nscli/ns_cli.py"
alias weather="curl -4 http://wttr.in/London"
alias push_and_open_pr="git push -u marek && hub pull-request"
alias pbcopy="xclip -selection clip -i"
alias agenda="gcalcli agenda"
alias gcal_personal="gcalcli --calendar=\"skrobul@skrobul.com\""
# Fasd
#eval "$(fasd --init posix-alias zsh-hook)"
# alias j="fasd_cd -d"
# alias jj="fasd -d -i"
#
bindkey '^[[A' history-beginning-search-backward
bindkey '^[[B' history-beginning-search-forward
