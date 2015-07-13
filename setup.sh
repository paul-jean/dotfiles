#!/bin/bash -x

dir=$PWD

rake

ln -sf $dir/bash_profile ~/.bash_profile
