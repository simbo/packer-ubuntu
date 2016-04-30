# custom prompt
PROMPT='%{%F{green}%}%n%{%f%}%{%F{white}%}@%{%f%}%{%F{cyan}%}%m%{%f%} %B%{%F{magenta}%}%~%{%f%}%b $(git_super_status)
 %B%{%F{cyan}%}➜%{%f%}%b '
RPROMPT=''

# aliases
alias ls="ls -h --color"                    # add colors for filetype and human-readable sizes
alias ll="ls -lv --group-directories-first" # list directories first
alias lm="ll |more"                         # pipe through `more`
alias lr="ll -R"                            # recursive ls
alias la="ll -A"                            # show hidden files

cd /vagrant
