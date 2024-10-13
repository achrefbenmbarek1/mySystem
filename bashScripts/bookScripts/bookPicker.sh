#!/bin/bash

searchDirectory="$HOME/Document/sharedArchUbuntu/books/cs books/software engineering books/"
bookmarkFile="$HOME/.local/bookmarkFile"

function add_bookmark() {
    selected_book="$searchDirectory$chosenBook"
    echo "$selected_book" >> "$bookmarkFile"
}

booksList=$(find "$searchDirectory" -type f -printf "%P\n")

chosenBook=$(echo "$booksList" | rofi -dmenu -i -p "Select a book")

if [ -n "$chosenBook" ]; then
  rofiResult=$(echo -e "Open\nBookmark" | rofi -dmenu -i -p "Choose action for '$chosenBook'")
  case "$rofiResult" in
      "Open")
          fullChosenBook="$searchDirectory$chosenBook"
          zathura "$fullChosenBook" & disown
          ;;
      "Bookmark")
          add_bookmark
          ;;
  esac
  # python3 .local/pythonToolsGui/customDialogBook.py $chosenBook &
fi

