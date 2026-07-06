#!/usr/bin/env bash

dir="$HOME/dotfiles/nixos/home/rofi/launcher/"
theme='style'

## Run
rofi \
  -show drun \
  -theme ${dir}/${theme}.rasi
