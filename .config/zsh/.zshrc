SAVEHIST=10000
export HISTTIMEFORMAT="%d/%m/%y %T"

export LESSHISTFILE=${XDG_CACHE_HOME:-HOME/.cache}/.lesshst

setopt appendhistory autocd
unsetopt beep extendedglob nomatch notify
bindkey -e
zstyle :compinstall filename '~.zshrc'

export PATH=$PATH:/usr/local/bin
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$HOME/go/bin
export PATH=$PATH:/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin
export PATH=$PATH:/Library/TeX/Distributions/Programs/texbin/

# dotfiles tracking method described at https://www.atlassian.com/git/tutorials/dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# prompt see here for good structuring: https://gist.github.com/mseri/8026965
# todo: move all of this into a separate file
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr "%F{74}◼%f"
# zstyle ':vcs_info:*' stagedstr "%F{136}●%f"
zstyle ':vcs_info:*' stagedstr "%F{114}✚%f"
zstyle ':vcs_info:git:*' formats '%m%c%u %F{240}%b%f '
precmd() {
    vcs_info
}
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
+vi-git-untracked(){
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
        git status --porcelain | grep '??' &> /dev/null ; then
        hook_com[staged]+='%F{217}✱%f '
    fi
}
setopt prompt_subst

PROMPT='%B%F{152}%1~%f%b > '
RPROMPT='${vcs_info_msg_0_}%(?..%B%F{1}%?%f%b)'

# Fixing issue described here: https://medium.com/mabar/today-i-learned-fix-go-get-private-repository-return-error-reading-sum-golang-org-lookup-93058a058dd8
export GOPRIVATE='github.com/getndazn'

if [ "$(uname)" == "Darwin" ]; then
    alias ls='gls --color=auto --group-directories-first'
    alias sed='gsed'
    alias cls='clear && echo -en "\e[3J"'
    alias date='gdate'
    alias gcloud=/usr/local/google-cloud-sdk/bin/gcloud
    if [ ! -d $ZDOTDIR/functions ]; then
        mkdir $ZDOTDIR/functions
    fi

    if [ ! -f $ZDOTDIR/functions/zsh-history-substring-search.zsh ]; then
        if [ ! -f /usr/local/share/zsh-history-substring-search/zsh-history-substring-search.zsh ]; then
            echo "zsh-history-substring-search function not installed. Run brew install zsh-history-substring-search"
        else
            ln -s /usr/local/share/zsh-history-substring-search/zsh-history-substring-search.zsh $ZDOTDIR/functions/zsh-history-substring-search.zsh
        fi
    fi

    if [ ! -f $ZDOTDIR/functions/zsh-syntax-highlighting.zsh ]; then
        if [ ! -f /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
            echo "zsh-syntax-highlighting function not installed. Run brew install zsh-syntax-highlighting"
        else
            ln -s /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh $ZDOTDIR/functions/zsh-syntax-highlighting.zsh
        fi
    fi

    source $ZDOTDIR/functions/zsh-history-substring-search.zsh
    source $ZDOTDIR/functions/zsh-syntax-highlighting.zsh

    if [ ! -f ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim ]; then
        echo "plug.vim file not found, installing now..."
        curl -fLo "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim" --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    fi
elif [ "$(uname)" == "Linux" ]; then
    alias ls='ls --color=auto --group-directories-first'
    export GNUPGHOME=${XDG_CONFIG_HOME:-$HOME/.config}/gnupg/
    source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    export URXVT_PERL_LIB=/usr/lib/urxvt/perl/
fi

# aliases
alias ll='ls -lah'
alias push-keepass="aws s3api put-object --bucket costa-theodorakopoulos-secure --key masterdatabase.kdbx --body ~/.keepass/masterdatabase.kdbx --server-side-encryption AES256"
alias pull-keepass="aws s3 cp s3://costa-theodorakopoulos-secure/masterdatabase.kdbx ~/.keepass/masterdatabase.kdbx"
alias python='/usr/local/bin/python3'
alias pip='/usr/local/bin/pip3'
alias vim='nvim'
alias tree='tree --dirsfirst'
alias k='kubectl'

export HELM_HOME=${XDG_CONFIG_HOME:-HOME/.config}/helm
export AWS_CONFIG_FILE=${XDG_CONFIG_HOME:-HOME/.config}/aws
export PULUMI_HOME=${XDG_CONFIG_HOME:-HOME/.config}/pulumi
export USE_GKE_GCLOUD_AUTH_PLUGIN=True
export BEETSDIR=/Volumes/music/beets/

[[ -n "${key[Up]}"   ]] && bindkey -- "${key[Up]}"   up-line-or-beginning-search
[[ -n "${key[Down]}" ]] && bindkey -- "${key[Down]}" down-line-or-beginning-search

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
set HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE
setopt HIST_IGNORE_ALL_DUPS

[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh ] && source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/usr/local/google-cloud-sdk/path.zsh.inc' ]; then . '/usr/local/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/usr/local/google-cloud-sdk/completion.zsh.inc' ]; then . '/usr/local/google-cloud-sdk/completion.zsh.inc'; fi
