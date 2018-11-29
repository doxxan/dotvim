#!/bin/zsh

set -o vi

export EDITOR='nvim'
export BROWSER=firefox
export GOPATH=$HOME/Go
export PATH=$PATH:$GOPATH/bin

PWD=`dirname $0`

# Functions
source "$PWD/functions/aur.sh"
source "$PWD/functions/aws.sh"
source "$PWD/functions/creds.sh"

alias vis="TERM=rxvt-256color vis"

# Passwords
alias sesame="eval \$(op signin my)"

# Configs
alias ez="nvim $HOME/.zshrc"
alias ezi="nvim $HOMe/Projects/dotrc/zsh/init.sh"
alias sz="source $HOME/.zshrc"
alias ei="nvim $HOME/.config/i3/config"
alias eis="nvim $HOME/.config/i3status/config"
alias er="nvim $HOME/.config/ranger/rc.conf"

# Navigation
alias gd="cd $HOME/Downloads"
alias gc="cd $HOME/.config"
alias gci="cd $HOME/.config/i3"
alias gtg="cd $GOPATH/src/github.com"
alias gtgs="cd $GOPATH/src/github.com/Sydsvenskan"
alias gtgp="cd $GOPATH/src/github.com/perlw"
alias gp="cd $HOME/Projects"
alias gw="cd $HOME/Work"
alias gs="cd /storage"

# Go
alias gg="go get -v -u"

# Misc
alias wttr="curl wttr.in/Malmö"

# Work
alias ca="consul agent -server -data-dir . -bootstrap -advertise 127.0.0.1 -rejoin -ui"
alias cg="cgateway proxy --omit jobinternalreport --omit apiproxy-80"
alias cgp="cgateway proxy --production --omit jobinternalreport --omit apiproxy-80"
