# Prompt

# Returns prefix of $1, clipped by ..., with total length at most $2
function dots()
{
    s=$1
    n=$2
    m=$((n-3))

    if [ ${#s} -gt $n ];
    then
        echo "${s:0:$m}..."
    else
        echo $s
    fi
}

# Returns "(curr-branch-nam...) " or "" otherwise
function git_branch()
{
    branch=$(git symbolic-ref HEAD 2> /dev/null | awk 'BEGIN{FS="/"} {print $NF}')
    if [ "$branch" = "" ];
    then
        echo ""
    else
        echo "($(dots $branch 18)) "
    fi
}

setopt prompt_subst
PROMPT='%F{203}%n:%f %F{038}%.%f %F{035}$(git_branch)%f%F{215}%%%f '


# Aliases

alias ls='ls -Gh'
alias lsl='ls -AGhl'
alias dush='du -sh *'
alias less='less -Nr'

alias viv='vi ~/.vimrc'
alias viz='vi ~/.zshrc'
alias soz='source ~/.zshrc'

alias cds='cd ~/code'

alias python='python3'
alias pip='pip3'


# fzf setup

source /opt/homebrew/opt/fzf/shell/*.zsh # Necessary on Mac I think
export FZF_DEFAULT_OPTS='-m --height 40% --min-height 3'
export FZF_COMPLETION_TRIGGER="'"
