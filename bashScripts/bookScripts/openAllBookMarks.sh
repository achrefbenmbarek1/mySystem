#!/bin/bash

bookmarkFile="$HOME/.local/bookmarkFile"

booksList=$(cat $bookmarkFile)

# Split the content of booksList into an array using newline as delimiter
IFS=$'\n' read -d '' -r -a bookArray <<< "$booksList"

for chosenBook in "${bookArray[@]}"; do
    if [ -n "$chosenBook" ]; then
        zathura "$chosenBook" & disown
    fi
done
