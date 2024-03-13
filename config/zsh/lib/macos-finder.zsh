#!/usr/bin/env zsh

function refreshfinder {
	osascript -e 'tell application "Finder" to tell front window to update every item'
}
