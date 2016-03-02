#!/bin/bash -x

dir=$PWD

ln -sf $dir/bash_profile ~/.bash_profile

ln -sf $dir/vim ~/.vim
ln -sf $dir/vimrc ~/.vimrc
ln -sf $dir/vimrc.local ~/.vimrc.local
ln -sf $dir/vimrc.bundles.local ~/.vimrc.bundles.local
ln -sf $dir/vimrc.bundles ~/.vimrc.bundles

ln -sf $dir/tmux.conf ~/.tmux.conf
ln -sf $dir/tmux.conf.local ~/.tmux.conf.local
