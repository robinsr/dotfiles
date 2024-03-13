function my-term-color() {
  # Alizarin Crimson*
  red=(224, 49, 49)

  # Mango Tango*
  orange=(230, 119, 0)

  # Lightning Yellow*
  yellow=(252, 196, 25)

  # Chateau Green*
  green=(55, 178, 77)

  # Java*
  teal=(34, 184, 207)

  # Royal Blue*
  blue=(66, 99, 235)

  # Amethyst*
  magenta=(174, 62, 201)

  local rbg
  
  [[ $1 = 'red' ]] && iterm2_tab_color $red
  [[ $1 = 'orange' ]] && iterm2_tab_color $orange
  [[ $1 = 'yellow' ]] && iterm2_tab_color $yellow
  [[ $1 = 'green' ]] && iterm2_tab_color $green
  [[ $1 = 'teal' ]] && iterm2_tab_color $teal
  [[ $1 = 'blue' ]] && iterm2_tab_color $blue
  [[ $1 = 'magenta' ]] && iterm2_tab_color $magenta
  [[ -z $1 ]] && iterm2_tab_color $orange
}