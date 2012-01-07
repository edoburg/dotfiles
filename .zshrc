autoload -U compinit
compinit
setopt auto_pushd
setopt auto_cd
setopt correct
setopt cdable_vars

# set aliases
alias ls='ls -GwF '
alias ll='ls -law '
alias la='ls -aw '
alias eng='LANG=C LANGUAGE=C LC_ALL=C'
alias -g lG='| grep '

# set ENV
export PATH=/opt/local/bin:$PATH
export EDITOR=/usr/bin/vim
export PYTHONPATH=/usr/local/lib/python2.7/site-packages:$PYTHONPATH

