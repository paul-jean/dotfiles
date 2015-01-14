#!/bin/bash -x

dir=$PWD

rake
ln -sf $dir/vimrc ~/.vimrc
ln -sf $dir/vimrc.local ~/.vimrc.local
ln -sf $dir/tmux.conf.local ~/.tmux.conf.local
ln -sf $dir/vimrc.bundles.local ~/.vimrc.bundles.local
ln -sf $dir/bash_profile ~/.bash_profile
