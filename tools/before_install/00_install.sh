#!/bin/sh

mv ~/.gitconfig ~/.gitconfig.$(date +%Y%m%d_%H%M%S)
cp ../../.gitconfig_sample ~/.gitconfig

./01_setup_name.sh
