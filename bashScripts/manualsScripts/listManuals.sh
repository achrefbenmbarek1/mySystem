#!/bin/sh

selectedPage=$(apropos -s 1 . | cut -d ' ' -f 1 | rofi -dmenu)

if [ -n "$selectedPage" ]; then
    man -Tpdf "$selectedPage" | zathura -
fi


