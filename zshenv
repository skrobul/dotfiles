#if [ -n "$DESKTOP_SESSION" ];then
#    eval $(gnome-keyring-daemon --start)
#    export SSH_AUTH_SOCK
#fi

export PATH="$PATH:$HOME/.bin:$HOME/bin:/usr/local/bin"
export PATH=$PATH:node_modules/.bin/

#eval $(ssh-agent -s)
#ssh-add ~/.ssh/work_rsa
THOR_MERGE="nvim -d"

if [ -e /home/skrobul/.nix-profile/etc/profile.d/nix.sh ]; then . /home/skrobul/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
