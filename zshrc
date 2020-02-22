bindkey -e
#########################
# Zgen plugin manager
#########################
ZSH_THEME=""
fpath=($fpath "/home/skrobul/.zfunctions")

############# ZPLUG start #############
# Check if zplug is installed
if [[ ! -d ~/.zplug ]]; then
  git clone https://github.com/zplug/zplug ~/.zplug
  source ~/.zplug/init.zsh && zplug update --self
fi
source ~/.zplug/init.zsh

# Make sure to use double quotes to prevent shell expansion
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-completions"
#zplug "rupa/z", use:z.sh
zplug "arzzen/calc.plugin.zsh"
zplug "denysdovhan/spaceship-prompt", use:spaceship.zsh, from:github, as:theme



# Install packages that have not been installed yet
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    else
        echo
    fi
fi

zplug load
############# ZPLUG end #############


autoload -U promptinit; promptinit
prompt spaceship
SPACESHIP_CHAR_SYMBOL="❯ "
SPACESHIP_NODE_DEFAULT_VERSION="v10.17.0"
source ~/dotfiles/zsh/spaceship_sections/dockerenv.zsh

SPACESHIP_PROMPT_ORDER=(
    time          # Time stampts section
    user          # Username section
    dir           # Current directory section
    host          # Hostname section
    git           # Git section (git_branch + git_status)
    # hg            # Mercurial section (hg_branch  + hg_status)
    # package       # Package version (local package.json)
    node          # Node.js section
    ruby          # Ruby section
    # elm           # Elm section
    # elixir        # Elixir section
    # xcode         # Xcode section
    # swift         # Swift section
    golang        # Go section
    # php           # PHP section
    # rust          # Rust section
    # haskell       # Haskell Stack section
    # julia         # Julia section
    # docker        # Docker section(docker-compose stuff)
    dockerenv
    # aws           # Amazon Web Services section
    venv          # virtualenv section
    # conda         # conda virtualenv section
    # pyenv         # Pyenv section
    # dotnet        # .NET section
    # ember         # Ember.js section
    # kubecontext   # Kubectl context section
    # terraform     # Terraform workspace section
    exec_time     # Execution time
    line_sep      # Line break
    battery       # Battery level and status
    vi_mode       # Vi-mode indicator
    jobs          # Background jobs indicator
    exit_code     # Exit code section
    char          # Prompt character
)
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



# Store device specific settings like DEFAULT_USER
source ~/.zshrc.local

# Key mappings
bindkey '^[[1;9C' forward-word
bindkey '^[[1;9D' backward-word

PERL_MB_OPT="--install_base \"/Users/marek.skrobacki/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/marek.skrobacki/perl5"; export PERL_MM_OPT;

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='ag -g ""'
alias irc='tmux new-session -s shared "tmux new-window -n irc weechat"'
alias ag='ag --color-path "1;36"'
alias ns-cli="~/devel/nscli/ns_cli.py"
alias nscli="~/devel/nscli/ns_cli.py"
alias weather="curl -4 http://wttr.in/London"
alias push_and_open_pr="git push -u marek && hub pull-request"
alias pbcopy="xclip -selection clip -i"
alias agenda="LC_ALL=en_US.UTF-8 gcalcli agenda"
alias gcal_personal="LC_ALL=en_US.UTF-8 gcalcli --calendar=\"skrobul@skrobul.com\""

timedping()
{
    ping $1 $2 | while read pong; do echo "$(date): $pong"; done
}

timedpingtcp()
{
    while :; do echo -n "$(date): "; tcping -t 1 $1 $2 ; sleep 1; done
}
# Fasd
eval "$(fasd --init posix-alias zsh-hook)"
alias j="fasd_cd -d"
alias jj="fasd -d -i"
#
#bindkey '^[[A' history-beginning-search-backward
#bindkey '^[[B' history-beginning-search-forward

# History
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups # ignore duplication command history list
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history # share command history data
setopt autocd

# Docker exec bug with wrapping
# https://github.com/moby/moby/pull/37172
# https://github.com/moby/moby/issues/35407
alias dexec='docker exec -e COLUMNS="`tput cols`" -e LINES="`tput lines`" -ti $1'
alias docker-deactivate="unset DOCKER_CERT_PATH DOCKER_TLS_VERIFY DOCKER_HOST"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
