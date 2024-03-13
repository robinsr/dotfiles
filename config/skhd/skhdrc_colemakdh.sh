# FOR REFERENCE
#   - WINDOW = an application window
#   - SPACE = a macOS Space; sequential desktops arranged horizontally
#   - DISPLAY = laptop screen or external monitor

# General Hotkey Patterns
#
# - Changing focus: shift + alt + [key]
# - Moving window:  shift + alt + ctrl + [key]
#
# - within a SPACE: J and K
# - across a SPACE: H and L
# - across a SCREEN: O and p 
#
# Directions:
#
#             North 
#              (w)
#               ↑
#   West/prev ← • →  East/next
#    (a,h,o)    ↓     (d,l,p)
#              (s)
#             South
#
# Key Mapping (regular (lowercase) => COLEMAK-DH (uppercase)
# qQ, wW, eF, rP, tB, yJ, uL, iU, oY, p;
# aA, sR, dS, fT, gG, hM, jN, kE, lI, ;O
# zZ, xC, cD, vV, bZ, nK, mH


# Within a space - change window focus
shift + alt - n : ya_cycle_focus_cw
shift + alt - e : ya_cycle_focus_ccw

# Within a space - rotate window positions
shift + alt + ctrl - n : ya_cycle_pos_cw
shift + alt + ctrl - e : ya_cycle_pos_ccw

# Within a space - rotate layout clockwise
shift + alt - p : yabai -m space --rotate 90

# Within a space - maximize active window
shift + alt - h : yabai -m window --toggle zoom_fullscreen

# Within a space - cycle the layout type
shift + alt - space : ya_cycle_layout

# Within a space - balance out tree of windows (resize to occupy same area)
shift + alt - f : yabai -m space --balance

# ----------

# Across a space - throw window
shift + ctrl + alt - m : ya_throw_prev_space
shift + ctrl + alt - i : ya_throw_next_space

# Across a space - move focus (disable shortcut in system prefs)
shift + alt - m : yabai -m space --focus prev
shift + alt - i : yabai -m space --focus next
ctrl - right : yabai -m space --focus next
ctrl - left : yabai -m space --focus prev

# ----------

# Across screens - change screen focus
shift + alt - y: yabai -m display --focus west
shift + alt - 0x29: yabai -m display --focus east

# Across screens - throw window
# shift + ctrl + alt - o: ya_throw_next_display
shift + ctrl + alt - y: yabai -m window --display west; yabai -m window --focus $(yabai -m query --windows --window recent | jq '.id')
# shift + ctrl + alt - p: ya_throw_prev_display
shift + ctrl + alt - 0x29: yabai -m window --display east; yabai -m window --focus $(yabai -m query --windows --window recent | jq '.id')


# flip along y_axis
# shift + alt - y : yabai -m space --mirror y_axis

# flip along x_axis
# shift + alt - x : yabai -m space --mirror x_axis

# toggle window float
# shift + alt - t : yabai -m window --toggle float --grid 4:4:1:1:2:2

# ----------

# swap windows
shift + ctrl - r : yabai -m window --swap south
shift + ctrl - w : yabai -m window --swap north
shift + ctrl - a : yabai -m window --swap west
shift + ctrl - s : yabai -m window --swap east

# move window and split
ctrl + alt - r : yabai -m window --warp south
ctrl + alt - w : yabai -m window --warp north
ctrl + alt - a : yabai -m window --warp west
ctrl + alt - s : yabai -m window --warp east

