# `Viole403 Dotfiles 🏡`

## What in this Repo

This repo contains my personal configuration for Linux, Android, and Windows
managed.

Currently this is designed for my **Debian Linux** as server, Debian Linux for my
daily driver desktop, **Android** via Termux, and **Windows**.
_I don't have MacOS yet, but I'm considering that too in this dotfiles._

**Important ⚠:** You need [nerd fonts][nerd-fonts] in your system.
Install the font of your choosing and use that font as monospace font.
Personally, I use `Fira Code` + `Symbols Nerd Font`.

**System Requirements:**

- **Neovim** >= 0.9.0 or **LunarVim**
- **Git**, **Make**, **Python 3**, **Node.js**, **npm**
- **Go** >= 1.21 (for Go LSP and tools)
- **Rust/Cargo** (for code-minimap and Rust LSP)

**Essential CLI Tools** (auto-installed by scripts):

- [`ripgrep`](https://github.com/BurntSushi/ripgrep) - Fast grep for Telescope
- [`fd`](https://github.com/sharkdp/fd) - Fast find for Telescope
- [`lazygit`](https://github.com/jesseduffield/lazygit) - Git UI in terminal
- `curl`, `wget`, `gzip`, `tar`, `unzip` - Download and archive utilities
- `code-minimap` - Code minimap sidebar (via cargo)

Here's the list of what included in this dotfiles:

- [`Neovim`](https://neovim.io) - Modern Vim-based editor with Lua configuration
- [`LunarVim`](https://www.lunarvim.org) - Neovim configuration with IDE features

## Installation

See [INSTALL.md](INSTALL.md) for detailed installation instructions for Linux, WSL, macOS and Windows (PowerShell).

**Quick install** (auto-detects package manager and installs dependencies):

```bash
# Linux/macOS/WSL
bash <(curl -s https://raw.githubusercontent.com/Viole403/dotfiles/main/install.sh)

# Windows (PowerShell)
irm https://raw.githubusercontent.com/Viole403/dotfiles/main/install.ps1 | iex
```

The installer automatically:

- ✅ Validates Neovim >= 0.9.0 and Go >= 1.21 versions
- ✅ Detects your package manager (apt, dnf, pacman, brew, scoop, choco, winget)
- ✅ Installs all required dependencies (git, make, python3, nodejs, golang, rust)
- ✅ Installs essential CLI tools (ripgrep, fd, lazygit, curl, wget, archives)
- ✅ Installs code-minimap via cargo
- ✅ Creates config symlinks for nvim/lvim
- ✅ Optional: Integrates with chezmoi for multi-machine management

## Resources

Here are list of resources for you to get started dive into this kind of project,
and this list is what actually inspired me to get started with it.

- [Awesome dotfiles][awe-dot] - A curated list of dotfiles resources.
- [Bash manual][bash] - Bash documentation to write your own scripts.

## Lets Try 🎶

[MIT License](./license) © Viole403 (Masalief Maulana)

<!-- Variables -->

[awe-dot]: https://github.com/webpro/awesome-dotfiles#readme "Awesome Dotfiles"
[bash]: https://www.gnu.org/software/bash/manual/bash.html "Bash Manual"
[nerd-fonts]: https://www.nerdfonts.com/ "NerdFonts"
