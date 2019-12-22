#!/bin/bash

echo "Installing EMACS 26"

sudo add-apt-repository ppa:kelleyk/emacs
sudo apt update
sudo apt install emacs26 -y

echo "Installing EMACS pkgs"
emacs26 --script install-packages.el

## To formmat sql queries
sudo gem install anbt-sql-formatter -y

mv dotemacs ~/.emacs
mkdir ~/.emacs.d
mv lisp/ ~/.emacs.d/
