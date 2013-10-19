# zshrc

############################################################
# basic #{{{1

umask 022
limit coredumpsize 0
stty erase '^h'

# make directory for cdd, completion cache, ...
_zsh_user_config_dir="${HOME}/.zsh"
if [[ ! -d ${_zsh_user_config_dir} ]]; then
    mkdir -p ${_zsh_user_config_dir}
fi

autoload -Uz add-zsh-hook

# use zsh-completions
# Additional completion definitions for Zsh
# http://github.com/zsh-users/zsh-completions
# Install
#   % cd ~/.zsh/
#   % git clone git://github.com/zsh-users/zsh-completions.git
#   % rm -f ~/.zcompdump; compinit   # clear cache
#
# NOTE: set fpath before compinit
if [[ -d "$HOME/.zsh/zsh-completions/src" ]]; then
    fpath=("$HOME/.zsh/zsh-completions/src" $fpath)
fi

# load user completion files
fpath=(~/etc/config/zsh/functions/*(N-/) $fpath)

autoload -Uz compinit
compinit

############################################################
# environment variables #{{{1

export LANG=ja_JP.UTF-8
export EDITOR=vim
export TERM=xterm-256color
export PAGER=less
# --SILENT : terminal bell is not rung
export LESS='--tabs=4 --no-init --LONG-PROMPT --ignore-case --SILENT'
export GREP_OPTIONS='--color=auto'
export MAIL=/var/mail/$USERNAME
#export PS4 for bash
export PS4='-> $LINENO: '

if [[ -d "/usr/share/zsh/help/" ]]; then
    export HELPDIR=/usr/share/zsh/help/
fi

# ls color #{{{2
if which dircolors >/dev/null 2>&1 ;then
    # export LS_COLORS
    eval $(dircolors -b)
    #not use bold
    if which perl >/dev/null 2>&1 ;then
        LS_COLORS=$(echo $LS_COLORS | LANG=C perl -pe 's/(?<= [=;] ) 01 (?= [;:] )/00/xg')
    fi
else
    # dircolors is not found
    export LS_COLORS='di=00;34:ln=00;36:so=00;35:ex=00;32:bd=40;33;00:cd=40;33;00:su=37;41:sg=30;43:tw=30;42:ow=34;42'
fi
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}


############################################################
# key bind #{{{1

bindkey -e

bindkey '^V' vi-quoted-insert
bindkey "^[u" undo
bindkey "^[r" redo
# not accept-line, but insert newline
bindkey '^J' self-insert-unmeta
bindkey '^R' history-incremental-pattern-search-backward

# like insert-last-word,
# except that non-words are ignored
autoload -Uz smart-insert-last-word
zle -N insert-last-word smart-insert-last-word
#   include words that is at least two characters long
zstyle :insert-last-word match '*([^[:space:]][[:alpha:]/\\]|[[:alpha:]/\\][^[:space:]])*'
bindkey '^]' insert-last-word

# like delete-char-or-list, except that list-expand is used
function _delete-char-or-list-expand() {
    if [[ -z "${RBUFFER}" ]]; then
        # the cursor is at the end of the line
        zle list-expand
    else
        zle delete-char
    fi
}
zle -N _delete-char-or-list-expand
bindkey '^D' _delete-char-or-list-expand

# kill backward one word,
# where a word is defined as a series of non-blank characters
function _kill-backward-blank-word() {
    zle set-mark-command
    zle vi-backward-blank-word
    zle kill-region
}
zle -N _kill-backward-blank-word
bindkey '^Y' _kill-backward-blank-word

# history-search-end:
# This implements functions like history-beginning-search-{back,for}ward,
# but takes the cursor to the end of the line after moving in the
# history, like history-search-{back,for}ward.
autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
bindkey "^O" history-beginning-search-backward-end

# quote previous word in single or double quote
autoload -Uz modify-current-argument
_quote-previous-word-in-single() {
    modify-current-argument '${(qq)${(Q)ARG}}'
    zle vi-forward-blank-word
}
zle -N _quote-previous-word-in-single
bindkey '^[s' _quote-previous-word-in-single

_quote-previous-word-in-double() {
    modify-current-argument '${(qqq)${(Q)ARG}}'
    zle vi-forward-blank-word
}
zle -N _quote-previous-word-in-double
bindkey '^[d' _quote-previous-word-in-double

# quote URL
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

# Edit the command line using your visual editor
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^Xe' edit-command-line
bindkey '^X^E' edit-command-line


############################################################
# default configuration #{{{1

#set PROMPT
autoload -Uz colors
colors

if [[ -z "${REMOTEHOST}${SSH_CONNECTION}" ]]; then
    #local shell
    PROMPT="%U%{${fg[red]}%}[%n@%m]%{${reset_color}%}%u(%j) %~
%# "
else
    #remote shell
    PROMPT="%U%{${fg[blue]}%}[%n@%m]%{${reset_color}%}%u(%j) %~
%# "
fi

# set RPROMPT in vcs_info
RPROMPT=""

# show vcs information #{{{2
# see man zshcontrib(1)
# GATHERING INFORMATION FROM VERSION CONTROL SYSTEMS
autoload -Uz vcs_info

# message format
#   $vcs_info_msg_0_ : main message
#   $vcs_info_msg_1_ : warning message
#   $vcs_info_msg_2_ : error message
zstyle ':vcs_info:*' max-exports 3

zstyle ':vcs_info:*' enable git svn hg bzr
zstyle ':vcs_info:*' formats '(%s)-[%b]'
# %m is expanded to empty string
zstyle ':vcs_info:*' actionformats '(%s)-[%b]' '%m' '<!%a>'
zstyle ':vcs_info:(svn|bzr):*' branchformat '%b:r%r'
zstyle ':vcs_info:bzr:*' use-simple true


autoload -Uz is-at-least
if is-at-least 4.3.10; then
    zstyle ':vcs_info:git:*' formats '(%s)-[%b]' '%c%u %m'
    zstyle ':vcs_info:git:*' actionformats '(%s)-[%b]' '%c%u %m' '<!%a>'
    zstyle ':vcs_info:git:*' check-for-changes true
    zstyle ':vcs_info:git:*' stagedstr "+"    # %c
    zstyle ':vcs_info:git:*' unstagedstr "-"  # %u
fi

# hooks
if is-at-least 4.3.11; then
    zstyle ':vcs_info:git+set-message:*' hooks \
                                            git-hook-begin \
                                            git-untracked \
                                            git-push-status \
                                            git-nomerge-branch \
                                            git-stash-count


    function +vi-git-hook-begin() {
        if [[ $(command git rev-parse --is-inside-work-tree 2> /dev/null) != 'true' ]]; then
            # if not in git work tree
            # some git command (e.g. git status --porcelain) causes fatal error.
            # so break and don't change message
            return 1
        fi

        return 0
    }
    
    # git: show marker '?' if there are untracked files in repository
    # set unstaged string(%u) in second format
    function +vi-git-untracked() {
        if [[ "$1" != "1" ]]; then
            return 0
        fi

        local untracked_line=${${(@f)"$(command git status --porcelain 2> /dev/null)"}[(r)\?\? *]}
        if [ "$untracked_line" != "" ]; then
            # unstaged (%u)
            hook_com[unstaged]+='?'
        fi
    }

    # git: Show pN when your local branch is ahead-of remote HEAD.
    # set misc string(%m) in second format
    function +vi-git-push-status() {
        if [[ "$1" != "1" ]]; then
            return 0
        fi

        if [[ "${hook_com[branch]}" != "master" ]]; then
            # do nothing if NOT in master branch
            return 0
        fi

        # not push
        local -a head_lines
        ahead_lines=( ${(@f)"$(command git rev-list origin/master..master 2>/dev/null)"} )
        local ahead=${#ahead_lines}
        if [[ "$ahead_lines[*]" != "" && "$ahead" -gt 0 ]]; then
            # misc (%m)
            hook_com[misc]+="(p${ahead})"
        fi
    }

    # git: Show marker (mN) if current branch isn't merged to master.
    # set misc string(%m) in second format
    function +vi-git-nomerge-branch() {
        if [[ "$1" != "1" ]]; then
            return 0
        fi

        if [[ "${hook_com[branch]}" == "master" ]]; then
            # do nothing in master branch
            return 0
        fi

        local -a nomerged_lines
        nomerged_lines=( ${(@f)"$(command git rev-list master..${hook_com[branch]} 2>/dev/null)"} )
        local nomerged=${#nomerged_lines}
        if [[ "$nomerged_lines[*]" != "" && "$nomerged" -gt 0 ]] ; then
            hook_com[misc]+="(m${nomerged})"
        fi
    }

    # git: Show stash count.
    # set misc string(%m) in second format
    function +vi-git-stash-count() {
        if [[ "$1" != "1" ]]; then
            return 0
        fi

        local -a stash_lines
        stash_lines=( ${(@f)"$(command git stash list 2>/dev/null)"} )
        stash=${#stash_lines}
        if [[ "$stash_lines[*]" != "" && "${stash}" -gt 0 ]]; then
            # misc (%m)
            hook_com[misc]+=":S${stash}"
        fi
    }

fi

function _update_vcs_info_msg() {
    local -a messages
    local prompt
    
    LANG=en_US.UTF-8 vcs_info

    if [[ -z ${vcs_info_msg_0_} ]]; then
        # nothing from vcs_info
        prompt=""
    else
        # vcs_info found something
        # require 'autoload -Uz colors'
        [[ -n "$vcs_info_msg_0_" ]] && messages+=( "%F{green}${vcs_info_msg_0_}%f" )
        [[ -n "$vcs_info_msg_1_" ]] && messages+=( "%F{yellow}${vcs_info_msg_1_}%f" )
        [[ -n "$vcs_info_msg_2_" ]] && messages+=( "%F{red}${vcs_info_msg_2_}%f" )
    
        prompt="${(j: :)messages}"
    fi

    RPROMPT="$prompt"
}
add-zsh-hook precmd _update_vcs_info_msg
# }}}2

#history configuration
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
setopt share_history
setopt hist_ignore_all_dups
setopt hist_save_nodups
#remove the history (fc -l) command from the history list
setopt hist_no_store
setopt hist_ignore_space
setopt hist_reduce_blanks
# do not add unnecessary command line to history
_history_ignore() {
    local line=${1%%$'\n'}
    local cmd=${line%% *}

    [[ ${#line} -ge 5
        && ${cmd} != "rm"
        && ${cmd} != (l|l[sal])
        && ${cmd} != (c|cd)
        && ${cmd} != (m|man)
    ]]
}
add-zsh-hook zshaddhistory _history_ignore


# completion #{{{2

# match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ignore current directory
# .. : only when the word on the line contains the substring '../'
zstyle ':completion:*' ignore-parents parent pwd ..

zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

setopt auto_menu
setopt extended_glob
#expand argument after = to filename
setopt magic_equal_subst
setopt print_eight_bit
setopt mail_warning
# remove right prompt from display when accepting a command line.
setopt transient_rprompt

zstyle ':completion:*:default' menu select=1
if [[ -d ${_zsh_user_config_dir}/cache ]]; then
    zstyle ':completion:*' use-cache yes
    zstyle ':completion:*' cache-path ${_zsh_user_config_dir}/cache
fi

# grouping cd completions
zstyle ':completion:*:cd:*' group-name ''
zstyle ':completion:*:cd:*:descriptions' format '%B%U# %d%u%b'
# }}}2


#cd
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
cdpath=(${HOME} ${HOME}/work)

# set characters which are considered word characters
# see man zshcontrib(1)
# bash-style word functions
autoload -Uz select-word-style
select-word-style default
# only these characters are not considered word characters
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

# run-help
# delete alias
alias run-help >/dev/null 2>&1 && unalias run-help
autoload -Uz run-help
autoload -Uz run-help-git
autoload -Uz run-help-svn

#etc
#allow comments in interactive shell
setopt interactive_comments
setopt rm_star_silent
setopt no_prompt_cr

setopt auto_remove_slash

#disable flow control
setopt no_flow_control

#not exit on EOF
setopt ignore_eof

#never ever beep ever
setopt no_beep


############################################################
# utility functions #{{{1

function alc() {
    if [ -n "$1" ]; then
        w3m "http://eow.alc.co.jp/${1}/UTF-8/?ref=sa" | sed '1,36d' | less
    else
        echo 'usage: alc word'
    fi
}

function presentation() {
    PROMPT="[%1d] %# "
    RPROMPT=""
}

function body() {
    if [[ $# -eq 0 || "$1" == "-h" || "$1" == "--help" ]] ; then
        echo "usage: $0 START,END [FILE]"
        return
    fi

    local exp="${1}"
    shift
    sed -n -e "${exp}p" $@
}

# search zsh document
function zman() {
    PAGER="less -g -s '+/^       "$1"'" man zshall
}

# cd to git repository root directory
# http://d.hatena.ne.jp/hitode909/20100211/1265879271
function cdu() {
    cd ./$(git rev-parse --show-cdup)
    if [ $# = 1 ]; then
        cd $1
    fi
}

function pwd-clip() {
    local copyToClipboard

    if which pbcopy >/dev/null 2>&1 ; then
        # Mac
        copyToClipboard='pbcopy'
    elif which xsel >/dev/null 2>&1 ; then
        # Linux
        copyToClipboard='xsel --input --clipboard'
    elif which putclip >/dev/null 2>&1 ; then
        # Cygwin
        copyToClipboard='putclip'
    else
        copyToClipboard='cat'
    fi

    # ${=VAR} enables SH_WORD_SPLIT option
    # so ${=VAR] is splited in words, for example "a" "b" "c"
    echo -n $PWD | ${=copyToClipboard}
}

function scouter() {
    sed -e '/^\s*$/d' -e '/^\s*#/d' ${ZDOTDIR:-$HOME}/.zshrc | wc -l
}

function 256colortest() {
    local code
    for code in {0..255}; do
        echo -e "\e[38;05;${code}m $code: Test"
    done
}

function zsh-without-rcfiles-in-screen() {
    # RCS option :
    #   If this option is unset, source /etc/zsh/zshenv
    #   but any other startup files will not be.
    # +o :
    #  unset RCS option
    screen zsh +o RCS
}


############################################################
# aliases #{{{1

#list
alias ls='ls -F --color=auto'
alias l='ls'
alias la='ls -a'
alias ll='ls -lh'
alias ld='ls -d'
alias l1='ls -1d'
alias lt='tree -F'

#file operation
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias mkdir='mkdir -p'

#cd
alias c='cd'
alias c-='cd -'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

#vi
alias vi='vim'
alias v='vim'
alias vir='vim -R'
alias vr='vim -R'
alias winvi='vim -c "edit ++fileformat=dos ++enc=cp932"'
alias eucvi='vim -c "edit ++enc=euc-jp"'
alias gm='gvim'

#grep
alias gf='grep --with-filename --line-number'
alias gr='grep --with-filename --line-number --recursive --exclude-dir=.svn'

#history
#-n option suppresses command numbers
function my_history_func() {
    local number=${1:-10}
    builtin history -n -${number}
}

alias history='builtin history 1'
alias his='builtin history -n 1'
alias h=my_history_func

#enable alias to sudo command argument
alias sudo='sudo '

#etc
alias g='git'
alias s='svn'
alias dirs='dirs -p'
alias ln='ln -s'
alias jb='jobs -l'
alias sc=screen
alias m='man'
alias eman="LANG=C man"
alias em="LANG=C man"
alias di='diff -u'
alias rlocate='locate --regex'
alias ema='emacs -nw'
alias mkzip='zip -q -r'
alias pc=pwd-clip
alias sc=scala
alias scc=scalac
alias csc=scalac

autoload -Uz zmv
alias zmv='noglob zmv -n -W'
alias dozmv='noglob zmv -W'

function make_date_dir_and_cd() {
    local date_dir=$(date '+%Y-%m-%d')
    if [ ! -d "$date_dir" ]; then
        mkdir "$date_dir" || return
    fi
    cd "$date_dir"
}
alias ddir='make_date_dir_and_cd'

alias svngrep='find . -type d -name .svn -prune -o -type f -print0 \
  | xargs -0 grep --with-filename --line-number'

#global aliases
alias -g L='| less'
alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'
alias -g V='| vim -R -'
alias -g U=' --help | head'
alias -g P=' --help | less'
alias -g N='> /dev/null'
alias -g W='| w3m -T text/html'

if which pbcopy >/dev/null 2>&1 ; then
    # Mac
    alias -g C='| pbcopy'
elif which xsel >/dev/null 2>&1 ; then
    # Linux
    alias -g C='| xsel --input --clipboard'
elif which putclip >/dev/null 2>&1 ; then
    # Cygwin
    alias -g C='| putclip'
fi


# for plugins #{{{1
# note :
# () { ... } defines anonymous function and it is executed immediately

# cdd
() {
    local cdd_script_path=~/etc/config/zsh/cdd
    if [[ -f $cdd_script_path ]]; then
        source $cdd_script_path
        touch $CDD_FILE
        add-zsh-hook chpwd _cdd_chpwd
    fi
}

# z
# https://github.com/rupa/z
() {
    local rupa_z_script_path=~/etc/config/zsh/z.sh
    if [[ -f $rupa_z_script_path ]]; then
        source $rupa_z_script_path
        function _rupa_z_chpwd() {
            _z --add "$(pwd -P)"
        }
        add-zsh-hook chpwd _rupa_z_chpwd
    fi
}

if [[ -f ~/.zshrc_dev ]]; then
    source ~/.zshrc_dev
fi

# source local rcfile
if [[ -f ~/.zshrc_local ]]; then
    source ~/.zshrc_local
fi

unset _zsh_user_config_dir

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# vim:set ft=zsh ts=4 sw=4 sts=0 foldmethod=marker:
