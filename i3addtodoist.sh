#!/bin/bash
ROFI_THEME=/home/skrobul/dotfiles/config/rofi/launchers/type-4/style-6.rasi
# Prompt the user for some input using rofi
#content=$(rofi -dmenu -p "New Todo: " -filter "#Inbox " -lines 0 -width 90 -theme "$ROFI_THEME")
content=$(rofi -dmenu -p "New Todo: " -lines 0 -width 90 -theme "$ROFI_THEME")

# Content will be empty if the user cancelled
if [[ ! -z "$content" ]]; then
    todoist quick "$content"
fi
