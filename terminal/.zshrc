# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

if [[ $PATH =~ "$HOME/bin" ]] && ! [ -d "$HOME/bin" ]; then
    export PATH=$HOME/bin:$PATH
fi

export TODAY="$(date +"%Y%m%d")"

# Path to your oh-my-zsh installation.
export ZSH=/home/tudor/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes

# ZSH_THEME="robbyrussell"
ZSH_THEME="fishy_tdr"
# ZSH_THEME="fishy"

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
DISABLE_AUTO_TITLE="true"

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
plugins=(
    command-not-found
    direnv
    docker 
    git
    vagrant
    zsh-autosuggestions
    zsh-syntax-highlighting
)

# Install brew autocomplete
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

source $ZSH/oh-my-zsh.sh

# If you type foo, and it isn't a command, and it is a directory in your
# cdpath, go there
setopt AUTO_CD

# Zsh has a nice feature where it can tell you whether the previous command did
# or didn't have a trailing newline. You can customize what gets printed in this case.
# This will print a red block instead of inverted % (or inverted # when you are root).
PROMPT_EOL_MARK='%K{red} '

### History settings
HISTSIZE=10000000
SAVEHIST=10000000
# Share history between all sessions
# setopt SHARE_HISTORY
# Expire duplicate entries first when trimming history.
setopt HIST_EXPIRE_DUPS_FIRST
# Allow multiple terminal sessions to all append to one zsh command history
setopt APPEND_HISTORY
# # Add comamnds as they are typed, don't wait until shell exit
setopt INC_APPEND_HISTORY
# # Do not write events to history that are duplicates of previous events
setopt HIST_IGNORE_DUPS
# # When searching history don't display results already cycled through twice
setopt HIST_FIND_NO_DUPS
# # Remove extra blanks from each command line being added to history
setopt HIST_REDUCE_BLANKS
# # Include more information about when the command was executed, etc
setopt EXTENDED_HISTORY
#Ignore the following when recording history
HISTORY_IGNORE="(ls|pwd|exit|ll|history)"

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

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
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

export WORKON_HOME=~/work/python-virtualenvs
if [ -f /usr/share/virtualenvwrapper/virtualenvwrapper.sh ]; then
    source /usr/share/virtualenvwrapper/virtualenvwrapper.sh
fi

if [ -f ~/.local/bin/virtualenvwrapper.sh ]; then
    source ~/.local/bin/virtualenvwrapper.sh
fi

if ! [[ $PATH =~ "$HOME/Android/Sdk/platform-tools" ]] && [ -d ~/Android/Sdk/platform-tools ]; then
    export PATH=$PATH:~/Android/Sdk/platform-tools
fi

export ANDROID_HOME=~/Android/Sdk

if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

if [ -z "${ZPROFILE_LOADED-}" ]; then
    source ~/.zprofile
fi

if [ -f ~/.oh-my-zsh/custom/functions/helpers ]; then
    source ~/.oh-my-zsh/custom/functions/helpers
fi
# disable the grv alias to use https://github.com/rgburke/grv
unalias grv

eval `keychain --eval ~/.ssh/*_rsa ~/.ssh/*id_ed25519`

# start TMUX if it's not running
if [ -z "${TMUX}" ]; then tmux new; fi

fpath=(~/.oh-my-zsh/custom/functions $fpath)

which thefuck 2>&1 > /dev/null && eval $(thefuck --alias)

command -v moar 2>&1 > /dev/null && export PAGER=moar


# kubernetes / k9s
if [ -f ~/.autocomplete.k9s.zsh ]; then
	source ~/.autocomplete.k9s.zsh;
fi

export KUBECONFIG="$HOME/.kube/config$(for file in $HOME/.kube/generated/*; do echo -n ":$file"; done)"

################
# useful aliases
################
# alias that can be used to pipe stuff into the clipboard
# eg: echo AAAAA | toclipboard
alias toclipboard="xclip -selection clipboard"

# create a virtualenvironment in the .env folder with python 3
alias qvenv="virtualenv -p python3 .env"
# activate the python virtual environment
alias activate="source .env/bin/activate"
alias unlu="sudo apt update && apt list --upgradeable"

# The git cola snap doesn't install the "cola" binary
alias cola="git-cola"

# micro editor
alias mi="micro"

alias b="byobu"
alias ns="notify-send"
alias lg="lazygit"
alias hm="home-manager"

#####################
# custom key bindings
#####################

# Shamelessly stolen from https://gitlab.com/GaugeK/dots/blob/master/etc/zsh/.zshrc
bindkey '^E' end-of-line              # Ctrl-E
bindkey '^[[P' delete-char            # Delete
bindkey '^[[4~' end-of-line           # End
bindkey '^[[3~' delete-char           # Delete
bindkey '^A' beginning-of-line        # Ctrl-A
bindkey '^[[1;5C' forward-word        # Ctrl-RightArrow
bindkey '^[[1;5D' backward-word       # Ctrl-LeftArrow
bindkey '^[[H' beginning-of-line      # Home
bindkey '^?' backward-delete-char     # Backspace
bindkey '^[[5~' up-line-or-history    # PageUp
bindkey '^[[6~' down-line-or-history  # PageDown
bindkey '^[[Z' reverse-menu-complete  # Shift-Tab


# Bring back verbose docker build!
#v https://docs.docker.com/build/building/variables/#buildkit_progress
export BUILDKIT_PROGRESS=plain

### Home Manager integrations
source ${HOME}/.nix-profile/etc/profile.d/hm-session-vars.sh
eval "$(uv generate-shell-completion zsh)"

### Start terminal multiplexer
if [ -z "${TMUX}" ]; then tmux new; fi
