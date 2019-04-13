#!/bin/bash

DOTPATH=~/dotfiles

for f in .??*
do
    ln -snfv "$DOTPATH/$f" "$HOME"/"$f"
done
