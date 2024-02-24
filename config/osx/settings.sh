#!/bin/zsh

readOSXDefaults () {
  NSGD=('KeyRepeat' 'InitialKeyRepeat')
  AACC=('KeyRepeatDelay' 'KeyRepeatInterval')

  for i in $NSGD; do
    echo "NSGlobalDomain $i = $(defaults read NSGlobalDomain $i)"
  done

  for i in $AACC; do
    echo "com.apple.Accessibility $i = $(defaults read com.apple.Accessibility $i)"
  done
}


writeOSXDefaults () {
  defaults write NSGlobalDomain KeyRepeat -int 2;
  defaults write NSGlobalDomain InitialKeyRepeat -int 20;

  defaults write com.apple.Accessibility KeyRepeatDelay -float 0.25;
  defaults write com.apple.Accessibility KeyRepeatInterval -float 0.05;

  defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false;
  # Unset ApplePressAndHoldEnabled to set a per-app value. Easier to just set to false
  # defaults delete -g ApplePressAndHoldEnabled
}



