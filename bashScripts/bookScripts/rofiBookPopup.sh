#!/bin/bash

chosenBook="$1"
searchDirectory="$2"

rofiResult=$(echo -e "Open\nBookmark" | rofi -dmenu -i -p "Open or Bookmark '$chosenBook'" -lines 2 -location 1 -width 20 -padding 20)
    case "$rofiResult" in
        "Open")
            fullChosenBook="$searchDirectory$chosenBook"
            zathura "$fullChosenBook" & disown
            ;;
        "Bookmark")
            add_bookmark
            ;;
    esac

