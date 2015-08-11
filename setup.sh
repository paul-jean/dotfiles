#!/bin/bash -x

dir=$PWD

rake
ln -sf $dir/bash_profile.work ~/.bash_profile
