# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=10000
setopt appendhistory autocd
unsetopt beep extendedglob nomatch notify
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '~.zshrc'

autoload -Uz compinit
compinit -d ~/.cache/zsh/zcompdump-$ZSH_VERSION
# End of lines added by compinstall

###############################################################
# Starting here with dotfiles tracking method described at https://www.atlassian.com/git/tutorials/dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
##############################################################
