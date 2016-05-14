local return_code="%(?..%{$fg[red]%}%? %{$reset_color%})"

PROMPT='%{$fg[green]%}{ %c } \
%{$fg[red]%}$(  git rev-parse --abbrev-ref HEAD 2> /dev/null || echo ""  )%{$reset_color%} \
%{$fg[blue]%}%(!.#.»)%{$reset_color%} '

PROMPT2='%{$fg[blue]%}\ %{$reset_color%}'

RPS1='%{$fg[green]%}%~%{$reset_color%} ${return_code} '

ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}:: %{$fg[yellow]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX=")%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}*%{$fg[yellow]%}"
