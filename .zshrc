# Path to your oh-my-zsh installation.
hostname=`cat /proc/sys/kernel/hostname`
echo "Welcome Quinn - $hostname"
if [[ $hostname =~ .*mixer.* ]]; then
    export ZSH=/etc/oh-my-zsh
else
    export ZSH=~/.oh-my-zsh
fi

# Set name of the theme to load.
# Look in /etc/oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="af-magic"

# Fixes permission warnings
ZSH_DISABLE_COMPFIX=true

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git systemd tmux zsh-autosuggestions)

# User configuration

# export PATH="/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# Enable the syntax highlihg plugin
source ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# Enable the history auto complete plugin
source ~/.oh-my-zsh/custom/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down



# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
if [ -f ~/.zshrc.local ]; then
    source ~/.zshrc.local
fi

#alias rac='ssh -oForwardAgent=yes qdamere@raccoons.mixer.com'

## Personal Stuff
alias c-naw='ssh -i ~/.ssh/octokey.pem quinn@143.110.227.92'
alias c-nae='ssh -i ~/.ssh/octokey.pem quinn@161.35.138.174'
alias c-euw='ssh -i ~/.ssh/octokey.pem quinn@139.59.151.85'
alias c-ase='ssh -i ~/.ssh/octokey.pem quinn@157.230.36.67'
alias c-lab='ssh -i ~/.ssh/octokey.pem quinn@157.245.209.112'

## ET go home
cd ~

## Directories
alias dr='cd ~/repos'
alias dotf='cd ~/repos/dotfiles'
dotf-pull () {
   ~/repos/dotfiles/update.sh
}
dotf-push () {
   ~/repos/dotfiles/write.sh
}
dotf-status () {
   cd ~/repos/dotfiles/
   git status
}

## Tmux stuff.
alias tm='tmux a -t quinn'
alias tmn='tmux -2 new -s quinn'
alias tmk='tmux kill-session -t quinn'

## JournalCtl Helpers
jc () {
   sudo journalctl -u $1 -f
}

jc1 () {
   sudo journalctl -u $1 --since "1 minute ago"
}

jc5 () {
   sudo journalctl -u $1 --since "5 minutes ago"
}

sc () {
   sudo systemctl status $1
}

sc-rl () {
   sudo systemctl reload $1
}

sc-rt () {
   sudo systemctl restart $1
}

sc-st () {
   sudo systemctl stop $1
}

## Other
root () {
   sudo su root
}

outputp () {
   sudo strace -ewrite -p $1
}

# Find large files
du-lf () {
    sudo du -a / | sort -n -r | head -n 20
}

# Try to launch dockerd if it's not running
RUNNING=`ps aux | grep dockerd | grep -v grep`
if [ -z "$RUNNING" ]; then
    echo "dockerd not running, trying to start"
    sudo dockerd > /dev/null 2>&1 &
    disown
fi
