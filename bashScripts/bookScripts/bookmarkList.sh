#!/bin/bash

bookmarkFile="$HOME/.local/bookmarkFile"

booksList=$(cat $bookmarkFile)

chosenBook=$(echo "$booksList" | rofi -dmenu -i -p "Select a bookmark")

function removeBookmark() {
  lineNumber=$(grep -n "$chosenBook" "$bookmarkFile" | head -n 1 | cut -d':' -f1)
  [ -n "$lineNumber" ] && sed -i "${lineNumber}d" "$bookmarkFile"
}

if [ -n "$chosenBook" ]; then
  rofiResult=$(echo -e "Open\nRemove" | rofi -dmenu -i -p "Choose action for '$chosenBook'")
  case "$rofiResult" in
      "Open")
          zathura "$chosenBook" & disown
          ;;
      "Remove")
          removeBookmark
          ;;
  esac
fi

