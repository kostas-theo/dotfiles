HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=10000
export HISTTIMEFORMAT="%d/%m/%y %T"

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

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# This is required to make rancher work
# https://www.everythingcli.org/ranger-image-preview-on-osx-with-iterm2/
export PYTHONPATH=/usr/local/lib/python2.7/site-packages

# Fixing issue described here: https://medium.com/mabar/today-i-learned-fix-go-get-private-repository-return-error-reading-sum-golang-org-lookup-93058a058dd8
export GOPRIVATE='github.com/getndazn'

# prompt
zstyle :prompt:pure:path color cyan
zstyle :prompt:pure:prompt:success color purple
zstyle :prompt:pure:git:stash show yes
prompt pure

# aliases
alias ll='ls -lah'
alias tnl='sshuttle -r kostas.theo@prod-eu-central-1-tunnel-service.daznplatform.com:443 0/0'
alias vscode='code -r .'
alias push-keepass="aws s3api put-object --profile costa --bucket costa-theodorakopoulos-secure --key masterdatabase.kdbx --body ~/masterdatabase.kdbx --server-side-encryption AES256"
alias cls='clear && echo -en "\e[3J"'
alias dao='dazn aws open'
alias ddo='dazn drone open'
alias ddd='dazn drone deploy'
alias python='/usr/local/bin/python3'
alias pip='/usr/local/bin/pip3'
