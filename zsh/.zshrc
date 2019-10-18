# Plugins
# -------

source ~/.zplug/init.zsh

zplug "agkozak/zsh-z"
zplug "plugins/shrink-path", from:oh-my-zsh
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting"

# zsh completions
zplug "zsh-users/zsh-completions"
zstyle ':completion:*' menu select
autoload -Uz compinit && compinit

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load

# fzf
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

# Key bindings
# ------------

bindkey '^A' beginning-of-line
bindkey '^E' end-of-line

## use Ctrl-left-arrow and Ctrl-right-arrow for jumping to word-beginnings
bindkey '^[Oc' forward-word
bindkey '^[Od' backward-word


# Options
# -------

# allow changing dirs without typing cd
setopt auto_cd
# append a trailing '/' to all directory names resulting from filename generation (globbing).
setopt mark_dirs

HISTFILE=~/.history
HISTSIZE=10000
SAVEHIST=10000
# append history list to the history file; this is the default but we make sure
# because it's required for share_history.
setopt appendhistory
setopt sharehistory
setopt incappendhistory
# save each command's beginning timestamp and the duration to the history file
setopt extended_history
setopt histignorealldups

# display PID when suspending processes as well
setopt longlistjobs

# avoid "beep"ing
setopt nobeep

autoload -Uz colors

# customize git info
# see: https://github.com/zsh-users/zsh/blob/master/Misc/vcs_info-examples
autoload -Uz vcs_info
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' get-revision true
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git*' formats "on %U%b%%u%u%c %m %F{8}(%12.12i)%f"
zstyle ':vcs_info:git*' actionformats "on %F{yellow}%a%f %U%b%%u%u%c %m %F{8}(%12.12i)%f"

zstyle ':vcs_info:*' unstagedstr '+'
zstyle ':vcs_info:*' stagedstr '!'

zstyle ':vcs_info:git*+set-message:*' hooks git-untracked git-st
+vi-git-untracked(){
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
        git status --porcelain | grep '??' &> /dev/null ; then
        hook_com[staged]+='?'
    fi
}

function +vi-git-st() {
    local ahead behind
    local -a gitstatus

    ahead=$(git rev-list ${hook_com[branch]}@{upstream}..HEAD 2>/dev/null | wc -l | tr -d '[:space:]')
    (( $ahead )) && gitstatus+=( "+${ahead}" )

    behind=$(git rev-list HEAD..${hook_com[branch]}@{upstream} 2>/dev/null | wc -l | tr -d '[:space:]')
    (( $behind )) && gitstatus+=( "-${behind}" )

    hook_com[misc]+=${(j:/:)gitstatus}
}


# Prompt
# ------

PROMPT='%F{magenta}%n%f at %F{blue}%m%f in %F{cyan}$(shrink_path -f)%f ${vcs_info_msg_0_}
$ '
precmd() {
    vcs_info
    print
}
setopt prompt_subst
RPROMPT=''


# Aliases
# -------

alias ls='ls --color=auto'
alias l='ls -lh'
alias ll='l'
alias la='l -a'

alias grep='grep --color'

alias dud='du -d 1 -h'
alias duf='du -sh *'

# quick access to the ~/.zshrc file
alias zshrc='${=EDITOR} ~/.zshrc'

# remove duplicated lines from a file. Usage: nodup foo.txt
alias nodup='awk '\''!seen[$0]++'\'''

# rm current directory
alias rmcdir='cd ..; rmdir $OLDPWD || cd $OLDPWD'


# Misc.
# -----

# Make zsh know about hosts already accessed by SSH
zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'


# Path
# ----

test -r "$HOME/bin" && export PATH=$HOME/bin:$PATH
test -r "$HOME/.rbenv" && eval "$(rbenv init -)"
