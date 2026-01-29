# Dotfiles

Personal configuration files managed with GNU Stow.

## Setup

```bash
# Clone repo
git clone <your-repo-url> ~/dotfiles
cd ~/dotfiles

# Install configs (pick what you need)
stow zsh
stow git
stow tmux
stow iterm2
```

## Packages

- `zsh` - Zsh configuration with Antigen
- `git` - Git configuration
- `tmux` - Tmux configuration
- `iterm2` - iTerm2 settings
- `asciinema` - Asciinema recording configuration

## Usage

```bash
stow <package>     # Install package
stow -D <package>  # Remove package
stow -R <package>  # Reinstall package
```
