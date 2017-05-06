#!/bin/bash	

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)"

echo 'export PATH="/home/mike/.linuxbrew/bin:$PATH"' >>~/.zshrc
echo 'export MANPATH="/home/mike/.linuxbrew/share/man:$MANPATH"' >>~/.zshrc
echo 'export INFOPATH="/home/mike/.linuxbrew/share/info:$INFOPATH"' >>~/.zshrc


brew install hello
