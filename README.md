# The Black Lodge ZSH Theme

A Twin Peaks-inspired ZSH theme that also makes text appear backwards, just like in the Black Lodge. Features full git status integration and a toggle to return to normal reality.

## Features

- Text appears backwards (toggleable)
- Twin Peaks inspired color scheme:
  - Black Lodge Red for warnings and root user
  - Laura Blue for regular users and ahead status
  - Pearl Lakes Green for clean status
  - Audrey Red for modified files
  - Log Lady Brown for separators
  - Coffee Brown for stashed changes
  - Owl Cave Grey for untracked files
  - Dark Woods for special directories
- Comprehensive git status indicators
- Ability to toggle reversed text on/off

## Prerequisites

- ZSH shell
- Oh My Zsh
- A terminal that supports 256 colors

## Installation

1. Download the theme:
   ```bash
   curl -o ~/.oh-my-zsh/custom/themes/black-lodge.zsh-theme https://raw.githubusercontent.com/alloydwhitlock/black-lodge/main/black-lodge.zsh-theme
   ```

2. Edit your `~/.zshrc`:
   ```bash
   ZSH_THEME="black-lodge"
   ```

3. (Optional) Set default reverse text state:
   ```bash
   export BLACK_LODGE_REVERSE=true  # or false
   ```

4. Reload your ZSH configuration:
   ```bash
   source ~/.zshrc
   ```

## Usage

### Git Status Indicators

The theme shows various git status indicators:
- `✓` - Clean repository
- `✗` - Dirty repository
- `+` - Added files
- `!` - Modified files
- `-` - Deleted files
- `>` - Renamed files
- `≠` - Unmerged files
- `?` - Untracked files
- `$` - Stashed changes
- `↑` - Ahead of remote
- `↓` - Behind remote

### Toggling Reversed Text

There are three ways to toggle the reversed text:

1. **Keyboard Shortcut**:
   - Press `Ctrl+B` to toggle reverse text on/off (may not work in tmux)
   - A message will confirm the change

2. **Command Aliases**:
   ```bash
   reverse_on   # Enable reversed text
   reverse_off  # Disable reversed text
   ```

3. **Environment Variable**:
   ```bash
   export BLACK_LODGE_REVERSE=true   # Enable
   export BLACK_LODGE_REVERSE=false  # Disable
   ```

## Customization

### Changing Colors

The theme uses 256-color codes. You can modify the colors by changing the values in the theme file:

```bash
BLACK_LODGE_RED="196"      # The Red Waiting Room
LAURA_BLUE="39"           # Laura's Jacket
DARK_WOODS="22"           # The Woods
LOG_LADY_BROWN="130"      # Log Lady's Log
COFFEE_BROWN="94"         # Agent Cooper's Coffee
OWL_CAVE_GREY="240"      # The Owl Cave in Ghostwood
AUDREY_RED="160"         # Audrey's Lipstick
PEARL_LAKES_GREEN="29"   # Pearl Lakes
```

### Changing Key Bindings

To change the toggle keyboard shortcut, modify the `bindkey` line in the theme:

```bash
bindkey '^B' toggle_black_lodge  # Change '^B' to your preferred key
```

## Troubleshooting

1. **Text not appearing backwards?**
   - Check if `BLACK_LODGE_REVERSE` is set to `true`
   - Try using the `reverse_on` command

2. **Colors not displaying correctly?**
   - Ensure your terminal supports 256 colors
   - Try running `echo $TERM` to verify terminal type

3. **Git status not showing?**
   - Ensure you have git installed
   - Verify you're in a git repository

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- Inspired by Twin Peaks and the Black Lodge
- Based originally on the Clean theme for Oh My Zsh
- Special thanks to Dale Cooper for the damn fine coffee


## Copyright Notice
Twin Peaks™ and all associated characters, names, and related indicia are trademarks of Twin Peaks Productions, Inc. and Lynch/Frost Productions. This theme is a fan creation and is not affiliated with, endorsed, sponsored, or specifically approved by Twin Peaks Productions, Inc., Lynch/Frost Productions, or their affiliates.

## Author

Adam Whitlock

---

"Through the darkness of future past, the magician longs to see, one chants out between two worlds, fire walk with me."

