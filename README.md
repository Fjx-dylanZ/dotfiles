# My Dotfiles

This repository contains my personal dotfiles for customizing my macOS development environment. The main tools I use are:

- **Yabai**: A tiling window manager for macOS
- **skhd**: A simple hotkey daemon for macOS
- **sketchybar**: A highly customizable macOS status bar

## Installation

1. Clone this repository to your home directory:
   ```
   git clone https://github.com/yourusername/dotfiles.git ~/.dotfiles
   ```

2. Install the required dependencies:
   - Yabai: Follow the installation instructions from the [Yabai GitHub repository](https://github.com/koekeishiya/yabai#installation).
   - skhd: Install using Homebrew: `brew install koekeishiya/formulae/skhd`
   - sketchybar: Install using Homebrew: `brew install FelixKratz/formulae/sketchybar`

3. Create symbolic links for the configuration files:
   ```
   ln -s ~/.dotfiles/yabai/yabairc ~/.yabairc
   ln -s ~/.dotfiles/skhd/skhdrc ~/.skhdrc
   ln -s ~/.dotfiles/sketchybar/sketchybarrc ~/.config/sketchybar/sketchybarrc
   ```

4. Restart the services:
   ```
   brew services restart yabai
   brew services restart skhd
   brew services restart sketchybar
   ```

## Features

- Custom keybindings for window management using skhd
- Customized status bar with sketchybar
- Custom scripts for enhanced window management and space switching
- Opacity settings for active and inactive windows
- Rule-based window management for specific applications

## Custom Scripts

The `skhdrc` configuration file includes several custom scripts to enhance window management and space switching functionality. Here's a brief overview of the main scripts used:

- `open_iterm.scpt`: Opens a new iTerm2 window using AppleScript.
- `focus-between-floats.sh`: Focuses on the next floating window in a cyclic manner.
- `hide-all-floats.sh`: Hides all floating windows in the current space or unhides them if they are already hidden.
- `notch-fullscreen.sh`: Toggles a window between fullscreen and normal mode while utilizing the notch area of the screen, using firda for code injection.
- ...

These scripts are located in the `CustomScripts/` directory and are triggered using the keybindings defined in the `skhdrc` file.

## Customization

Feel free to explore the configuration files and customize them to suit your needs:

- `yabai/yabairc`: Yabai configuration file
- `skhd/skhdrc`: skhd configuration file
- `sketchybar/sketchybarrc`: sketchybar configuration file
- `CustomScripts/`: Custom scripts for window management and space switching

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more information.

## Acknowledgements

- [Yabai](https://github.com/koekeishiya/yabai) - A tiling window manager for macOS
- [skhd](https://github.com/koekeishiya/skhd) - Simple hotkey daemon for macOS
- [sketchybar](https://github.com/FelixKratz/SketchyBar) - A highly customizable macOS status bar
- [frida fullscreen script](https://notes.alinpanaitiu.com/Fullscreen%20apps%20above%20the%20MacBook%20notch)
