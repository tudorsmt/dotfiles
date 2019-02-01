# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

if [ -d "$HOME/bin" ]; then
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
plugins=(git zsh-syntax-highlighting vagrant zsh-completions command-not-found docker tmux)

source $ZSH/oh-my-zsh.sh

# If you type foo, and it isn't a command, and it is a directory in your
# cdpath, go there
setopt AUTO_CD


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

if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

if [ -f ~/.oh-my-zsh/custom/functions/helpers ]; then
    source ~/.oh-my-zsh/custom/functions/helpers
fi
# disable the grv alias to use https://github.com/rgburke/grv
unalias grv

eval `keychain --eval ~/.ssh/*_rsa`

# start TMUX if it's not running
if [ -z "${TMUX}" ]; then tmux new; fi

fpath=(~/.oh-my-zsh/custom/functions $fpath)

eval $(thefuck --alias)
