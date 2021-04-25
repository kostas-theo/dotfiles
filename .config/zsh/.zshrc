HISTFILE=~/.histfile
HISTSIZE=1000
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

# This is required to make rancher work
# https://www.everythingcli.org/ranger-image-preview-on-osx-with-iterm2/
export PYTHONPATH=/usr/local/lib/python2.7/site-packages

# Fixing issue described here: https://medium.com/mabar/today-i-learned-fix-go-get-private-repository-return-error-reading-sum-golang-org-lookup-93058a058dd8
export GOPRIVATE='github.com/getndazn'

# aliases
# unalias gls || true
alias ls='gls --color=auto --group-directories-first'
alias ll='ls -lah'
alias vscode='code -r .'
alias push-keepass="aws s3api put-object --bucket costa-theodorakopoulos-secure --key masterdatabase.kdbx --body ~/.keepass/masterdatabase.kdbx --server-side-encryption AES256"
alias pull-keepass="aws s3 cp s3://costa-theodorakopoulos-secure/masterdatabase.kdbx ~/.keepass/masterdatabase.kdbx"
alias cls='clear && echo -en "\e[3J"'
alias weather='curl wttr.in/Haarlem?format="%l+weather:\n+\n%c:+%C:+%t\nRain:+%p\nSunset:+%s\n\n\n"\&m'
alias weatherfc='curl wttr.in/Haarlem\?m'
alias python='/usr/local/bin/python3'
alias pip='/usr/local/bin/pip3'
alias vim='nvim'
alias tree='tree --dirsfirst'
[[ ${OSTYPE} == "darwin"* ]] && alias date='gdate'
alias k='kubectl'
alias helm2="/usr/local/Cellar/helm@2/2.17.0/bin/helm"
alias tiller="/usr/local/Cellar/helm@2/2.17.0/bin/tiller"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc' ]; then . '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc' ]; then . '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'; fi

# using direnv
eval "$(direnv hook zsh)"

export HELM_HOME=${XDG_CONFIG_HOME:-HOME/.config}/helm
export AWS_CONFIG_FILE=${XDG_CONFIG_HOME:-HOME/.config}/aws
export PULUMI_HOME=${XDG_CONFIG_HOME:-HOME/.config}/pulumi
# export KUBECONFIG=${XDG_CONFIG_HOME:-HOME/.config}/kube

# manual installation and config of zsh-syntax-highlighting and zsh-history-substring-search
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

[[ -n "${key[Up]}"   ]] && bindkey -- "${key[Up]}"   up-line-or-beginning-search
[[ -n "${key[Down]}" ]] && bindkey -- "${key[Down]}" down-line-or-beginning-search

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/local/share/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
set HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE
setopt HIST_IGNORE_ALL_DUPS
