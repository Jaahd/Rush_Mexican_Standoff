#!/bin/sh

#del previous conf
rm -rf $HOME/.vim $HOME/.vimrc

# get the script dir
dir=`pwd`
end=`dirname $0`
if [[ $end != "." ]]; then
	dir=$dir"/"$end
fi

#create tmp dir
mkdir -p $dir/.vim/tmp

#create symlink
cd
ln -s $dir/.vim
ln -s $dir/.vimrc

#vundle install
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

#plugin install
vim +PluginInstall +q +q
