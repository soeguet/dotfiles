# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

alias config='/run/current-system/sw/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'

 export VISUAL=nvim;
 export EDITOR=nvim;
