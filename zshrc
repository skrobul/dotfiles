bindkey -e
export PATH="$HOME/.local/bin:$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$HOME/.cargo/bin:$PATH"
eval "$(mise activate zsh)"
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
zplug "greymd/docker-zsh-completion"
#zplug "rupa/z", use:z.sh
zplug plugins/taskwarrior, from:oh-my-zsh
#zplug "skrobul/zsh-tmux-auto-title", at:prerelease
zplug 'zsh-users/zsh-autosuggestions'

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
eval "$(starship init zsh)"

#########################
# visual command edit
#########################
export VISUAL=nvim
autoload edit-command-line; zle -N edit-command-line
bindkey -M vicmd v edit-command-line
bindkey '^X^E' edit-command-line
# core configuration
CASE_SENSITIVE="false"

# Uncomment the following line to disable colors in ls.
DISABLE_LS_COLORS="false"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="false"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"




# Key mappings
bindkey '^[[1;9C' forward-word
bindkey '^[[1;9D' backward-word

# [Ctrl-RightArrow] - move forward one word
bindkey '^[[1;5C' forward-word
# [Ctrl-LeftArrow] - move backward one word
bindkey '^[[1;5D' backward-word

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='ag -g ""'
alias ag='ag --color-path "1;36"'
alias weather="curl -4 http://wttr.in/London"
alias push_and_open_pr="git push -u marek && hub pull-request"
alias kd="kitty +kitten diff"
alias t="task"
alias tt="taskwarrior-tui"
alias disablehistory="function zshaddhistory() {  return 1 }"
alias container_healthcheck_inspect="jq '.[0].State.Health + .[0].Config.Healthcheck'"
alias k=kubectl
# alias ironic_conductor_logs="kubectl logs ironic-conductor-0  -f | grep -Evi 'periodic|power state sync|hash rings|shared lock|exclusive lock|heartbeat|ironic.drivers.modules.redfish.management|sensors' | sed -e 's/req-[a-f0-9 -]\+//g' | tspin --config-path ~/.config/tailspin/openstack.toml --disable uuids "
alias strip_colors="sed 's/\x1B\[[0-9;]\{1,\}[A-Za-z]//g'"
alias kubepods_cpu_limits='kubectl get pods --all-namespaces -o custom-columns="NAMESPACE:.metadata.namespace,POD:.metadata.name,CPU_LIMIT:.spec.containers[*].resources.limits.cpu"'


if ! [[ $(uname) == "Darwin" ]]; then
    alias pbcopy="xclip -selection clip -i"
fi

timedping()
{
    ping $1 $2 | while read pong; do echo "$(date): $pong"; done
}

timedpingtcp()
{
    while :; do echo -n "$(date): "; tcping -t 1 $1 $2 ; sleep 1; done
}
# Zoxide instead of fasd
eval "$(zoxide init zsh)"
alias j=z
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

export PATH="$HOME/.local/bin:$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$HOME/.cargo/bin:$PATH"

[[ -f "/home/linuxbrew/.linuxbrew/bin/brew" ]] && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

pg_in_docker() {
    docker exec --user postgres -it "$1" psql "$2"
}
pg_in_docker_by_name() {
    container_id=$(docker ps | grep "$1" | cut -f 1 -d ' ')
    echo "Launching psql in ${container_id}"
    pg_in_docker "$container_id"

}

function change_commit_date() {
    GIT_COMMITTER_DATE="$1" git commit --no-edit --amend -S --date="$1" && \
        git log --format=fuller HEAD~1..HEAD
}

eval "$(direnv hook zsh)"

# tmux auto title - https://github.com/mbenford/zsh-tmux-auto-title#configuration
ZSH_TMUX_AUTO_TITLE_SHORT="true"
#ZSH_TMUX_AUTO_TITLE_SHORT_EXCLUDE="unconfigured"
ZSH_TMUX_AUTO_TITLE_IDLE_TEXT="%pwd"
#
#
pandoc_debug() {
    pandoc -s -t native -f markdown -o - $1
}

# Enable Ctrl+arrow key bindings for word jumping
bindkey '^[[1;5C' forward-word     # Ctrl+right arrow
bindkey '^[[1;5D' backward-word    # Ctrl+left arrow

# poetry completions
fpath+=~/.zfunc
autoload -Uz compinit && compinit
ZSH_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
[[ -d $ZSH_CACHE_DIR/completions ]] || mkdir -p $ZSH_CACHE_DIR/completions  # For kubectl completions
fpath=($ZSH_CACHE_DIR/completions $fpath)

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/marek.skrobacki/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
#
# Store device specific settings like DEFAULT_USER
source ~/.zshrc.local

export ARGOCD_OPTS="--grpc-web"
