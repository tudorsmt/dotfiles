# ZSH Theme emulating the Fish shell's default prompt.

_fishy_collapsed_wd() {
  echo $(pwd | perl -pe '
   BEGIN {
      binmode STDIN,  ":encoding(UTF-8)";
      binmode STDOUT, ":encoding(UTF-8)";
   }; s|^$ENV{HOME}|~|g; s|/([^/.])[^/]*(?=/)|/$1|g; s|/\.([^/])[^/]*(?=/)|/.$1|g
')
}

local user_color='green'; [ $UID -eq 0 ] && user_color='red'
local ret_status="%(?:%{$fg_bold[green]%}✔ :%{$fg_bold[red]%}✘ )%{$reset_color%}"
local exit_code="%{$fg_bold[red]%}%(?..%?)%{$reset_color%}"
local prompt_char="%{$fg_bold[$user_color]%}%(!.#. $)%{$reset_color%}"
local clock="%F{$fg_bold[243]}[%*]%f%{$reset_color%}"

PROMPT='${ret_status}${exit_code} %{$fg_bold[blue]%}%n@%m %{$fg[$user_color]%}$(_fishy_collapsed_wd)\
$(git_prompt_info)$(git_prompt_status)
${clock}${prompt_char} '
PROMPT2='%{$fg[red]%}\ %{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg_bold[white]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN=""

ZSH_THEME_GIT_PROMPT_ADDED="%{$fg_bold[green]%} +"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg_bold[blue]%} !"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg_bold[red]%} -"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg_bold[magenta]%} >"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg_bold[yellow]%} #"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_bold[cyan]%} ?"
