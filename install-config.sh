#!/usr/bin/env bash

git clone --bare git@github.com:mjstewart/config.git $HOME/.cfg
# define config alias locally since the dotfiles aren't installed on the system yet
function config {
   git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $@
}
# create a directory to backup existing dotfiles to
mkdir -p .config-backup
config checkout
if [ $? = 0 ]; then
  echo "Checked out dotfiles from git@github.com:mjstewart/config.git";
  else
    echo "Moving existing dotfiles to ~/.config-backup";
    config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}
fi
# checkout dotfiles from repo
config checkout
config config status.showUntrackedFiles no