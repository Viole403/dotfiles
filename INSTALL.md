# Installation Guide

This file explains how to install and enable the configuration contained in this repository for Neovim (`nvim`) and LunarVim (`lvim`) on Linux, WSL, macOS and Windows.

You can choose between:

- **Quick install** (symlinks) - Fast and simple
- **Chezmoi** (recommended for multiple machines) - Advanced dotfile management with templating, encryption, and cross-machine sync

## Prerequisites

### Required

- **Git** - Version control
- **Neovim** (>= 0.9.0) - The editor. For LunarVim: <https://www.lunarvim.org>
- **Make** - Build automation tool
- **Nerd Font** - Icons in statusline/tree. See <https://www.nerdfonts.com/>

### Core Development Tools (Auto-installed by scripts)

- **Python 3** + `pip` - For Python LSP and plugins
- **Node.js** + `npm` - For LSP servers (tsserver, etc.)
- **Go** (>= 1.21) - For Go LSP and tools
- **Rust/Cargo** - For Rust LSP and tools like `code-minimap`

### Essential CLI Tools (Auto-installed by scripts)

- **`ripgrep`** - Fast grep (required for `:Telescope live_grep`)
- **`fd`** - Fast find (improves `:Telescope find_files`)
- **`lazygit`** - Git UI inside Neovim
- **`curl`** / **`wget`** - Download tools
- **`gzip`** / **`tar`** / **`unzip`** / **`7zip`** - Archive utilities
- **`code-minimap`** - Code minimap sidebar (via cargo)

### Optional

- **Chezmoi** (>= 2.0) - For advanced dotfile management (auto-installed by scripts)
- **Tree-sitter CLI** - For advanced syntax highlighting (auto-managed by plugins)

## Installing Dependencies

> **💡 Tip**: The install scripts ([install.sh](install.sh) / [install.ps1](install.ps1)) automatically detect, validate, and install all required dependencies for you, including version checks for Neovim (>= 0.9.0) and Go (>= 1.21). This section is for manual installation only.

### Automated Installation

The provided installation scripts automatically:

- ✅ Check for Neovim >= 0.9.0 and Go >= 1.21
- ✅ Detect your package manager (apt, dnf, pacman, brew, scoop, choco, winget)
- ✅ Install missing core tools: git, make, python3, pip, nodejs, npm, golang, rust/cargo
- ✅ Install essential CLI tools: ripgrep, fd, lazygit, curl, wget, gzip, tar, unzip
- ✅ Install code-minimap via cargo
- ✅ Create symlinks or use chezmoi for dotfile management

### Manual Installation (Linux)

**Ubuntu/Debian**:

```bash
# Core development tools
sudo apt install git make neovim python3 python3-pip nodejs npm golang cargo

# Essential CLI tools
sudo apt install ripgrep fd-find lazygit curl wget gzip tar unzip

# Install code-minimap
cargo install --locked code-minimap
```

**Arch Linux**:

```bash
# Core development tools
sudo pacman -S git make neovim python python-pip nodejs npm go rust

# Essential CLI tools
sudo pacman -S ripgrep fd lazygit curl wget gzip tar unzip

# Install code-minimap
cargo install --locked code-minimap
```

**Fedora**:

```bash
# Core development tools
sudo dnf install git make neovim python3 python3-pip nodejs npm golang cargo

# Essential CLI tools
sudo dnf install ripgrep fd-find curl wget gzip tar unzip
sudo dnf copr enable atim/lazygit -y && sudo dnf install lazygit

# Install code-minimap
cargo install --locked code-minimap
```

### Manual Installation (macOS)

```bash
# Using Homebrew (install from https://brew.sh)
# Core development tools
brew install git make neovim python3 node go rust

# Essential CLI tools
brew install ripgrep fd lazygit curl wget gzip gnu-tar unzip

# Install code-minimap
cargo install --locked code-minimap
```

### Manual Installation (Windows)

**Using Scoop** (recommended - <https://scoop.sh>):

```powershell
# Core development tools
scoop install git make neovim python nodejs golang rust

# Essential CLI tools
scoop install ripgrep fd lazygit curl wget gzip tar 7zip

# Install code-minimap
cargo install --locked code-minimap
```

**Using Chocolatey** (<https://chocolatey.org>):

```powershell
# Core development tools
choco install git make neovim python nodejs golang rust -y

# Essential CLI tools
choco install ripgrep fd lazygit curl wget gzip tar 7zip -y

# Install code-minimap
cargo install --locked code-minimap
```

**Using winget** (built-in Windows 10/11):

```powershell
# Core development tools
winget install Git.Git Neovim.Neovim GnuWin32.Make Python.Python.3.11 OpenJS.NodeJS GoLang.Go Rustlang.Rust.MSVC --silent

# Essential CLI tools
winget install BurntSushi.ripgrep.MSVC sharkdp.fd JesseDuffield.lazygit JernejSimoncic.Wget 7zip.7zip --silent

# Install code-minimap (curl and tar are built into Windows 10+)
cargo install --locked code-minimap
```

## Quick Install Methods

### Linux / macOS / WSL (Bash)

**Interactive install** (auto-detects package manager and installs dependencies):

```bash
bash <(curl -s https://raw.githubusercontent.com/Viole403/dotfiles/main/install.sh)
```

**Direct options**:

```bash
# Clone and run
git clone https://github.com/Viole403/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Install both nvim and lvim (auto-installs ripgrep, fd)
./install.sh --both

# Install only Neovim
./install.sh --nvim

# Install only LunarVim
./install.sh --lvim

# Use chezmoi (recommended for multiple machines)
./install.sh --chezmoi --both

# Non-interactive mode (auto-installs everything)
./install.sh --chezmoi --both --yes

# Skip automatic dependency installation
./install.sh --both --skip-deps
```

> **✨ Auto-Installation**: The installer automatically detects your package manager (apt, dnf, pacman, brew, zypper, apk) and installs ripgrep and fd if missing!

### Windows (PowerShell) - Quick Install

**Interactive install** (auto-detects package manager and installs dependencies):

```powershell
irm https://raw.githubusercontent.com/Viole403/dotfiles/main/install.ps1 | iex
```

**Direct options**:

```powershell
# Clone and run
git clone https://github.com/Viole403/dotfiles.git $env:USERPROFILE\dotfiles
cd $env:USERPROFILE\dotfiles

# Install both nvim and lvim (auto-installs ripgrep, fd)
.\install.ps1 -Both

# Install only Neovim
.\install.ps1 -Nvim

# Install only LunarVim
.\install.ps1 -Lvim

# Use chezmoi
.\install.ps1 -Chezmoi -Both

# Non-interactive mode (auto-installs everything)
.\install.ps1 -Chezmoi -Both -Yes

# Skip automatic dependency installation
.\install.ps1 -Both -SkipDeps
```

> **✨ Auto-Installation**: The installer automatically detects your package manager (Scoop, Chocolatey, or winget) and installs ripgrep and fd if missing!

---

## Using Chezmoi (Advanced)

[Chezmoi](https://github.com/twpayne/chezmoi) is a powerful dotfile manager that helps manage dotfiles across multiple diverse machines securely with features like:

- **Templating** - Different configs per machine
- **Encryption** - Secure secrets management
- **Cross-machine sync** - Keep dotfiles in sync
- **Conflict resolution** - Handle external modifications

> **Note**: This repo requires chezmoi v2.0.0 or higher (enforced via `.chezmoiversion` file).

### Install with Chezmoi

The install scripts support chezmoi integration with the `--chezmoi` flag. Alternatively, manual setup:

**Linux/macOS**:

```bash
# Install chezmoi (latest version)
sh -c "$(curl -fsLS get.chezmoi.io)"

# Verify installation
chezmoi --version

# Initialize with your dotfiles repo
chezmoi init https://github.com/Viole403/dotfiles.git

# Preview changes
chezmoi diff

# Apply changes
chezmoi apply -v
```

**Windows**:

```powershell
# Install chezmoi (latest version)
iex "&{$(irm 'https://get.chezmoi.io/ps1')}"

# Verify installation
chezmoi --version

# Initialize and apply
chezmoi init --apply https://github.com/Viole403/dotfiles.git
```

### Chezmoi Daily Workflow

```bash
# Edit a config file
chezmoi edit ~/.config/nvim/init.lua

# See what would change
chezmoi diff

# Apply changes
chezmoi apply

# Add new file to be managed
chezmoi add ~/.config/nvim/lua/new-plugin.lua

# Pull latest from repo and apply
chezmoi update

# Commit and push changes
chezmoi cd
git add .
git commit -m "Update nvim config"
git push
```

### Managing Nvim/Lvim with Chezmoi

After initializing chezmoi, add your configs:

```bash
# Add nvim config (if not already tracked)
chezmoi add --follow ~/.config/nvim

# Add lvim config
chezmoi add --follow ~/.config/lvim

# Apply configurations
chezmoi apply
```

---

## Manual Installation (Without Scripts)

### Linux / macOS / WSL

1. Clone the repo:

```bash
git clone https://github.com/Viole403/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

1. Backup existing configs and create symlinks:

```bash
# Backup
mv ~/.config/nvim ~/.config/nvim.backup 2>/dev/null || true
mv ~/.config/lvim ~/.config/lvim.backup 2>/dev/null || true

# Create symlinks
mkdir -p ~/.config
ln -s ~/dotfiles/config/nvim ~/.config/nvim
ln -s ~/dotfiles/config/lvim ~/.config/lvim
```

1. Install plugin dependencies:

```bash
# Python support
pip3 install --user pynvim

# Node tooling (optional)
npm install -g tree-sitter-cli
```

1. Open editor and sync plugins:

```bash
# For Neovim - open and run your plugin manager's sync
nvim
# Inside nvim: :Lazy sync (or :PackerSync, :PlugInstall, etc.)

# For LunarVim
lvim
```

### Windows (PowerShell)

**Option A** - Use WSL and follow Linux/WSL steps above (recommended).

**Option B** - Native Windows:

1. Clone the repo:

```powershell
git clone https://github.com/Viole403/dotfiles.git $env:USERPROFILE\dotfiles
cd $env:USERPROFILE\dotfiles
```

1. Create junctions (works without admin):

```powershell
# Backup and create junction for Neovim
$nvim = "$env:LOCALAPPDATA\nvim"
if (Test-Path $nvim) { Rename-Item $nvim "$nvim.backup" }
cmd /c mklink /J "$nvim" "$env:USERPROFILE\dotfiles\config\nvim"

# For LunarVim
$lvim = "$env:LOCALAPPDATA\lvim"
if (Test-Path $lvim) { Rename-Item $lvim "$lvim.backup" }
cmd /c mklink /J "$lvim" "$env:USERPROFILE\dotfiles\config\lvim"
```

1. Install requirements:

```powershell
# Using Scoop (recommended)
scoop install ripgrep fd neovim

# Or using Chocolatey
choco install ripgrep fd neovim
```

Also install: Python, Node/NPM, and Nerd Fonts.

1. Open editor and sync plugins (same as Linux above).

---

## Verification

Test your installation:

```bash
# Check Neovim
nvim --version
nvim +checkhealth

# Check LunarVim
lvim --version

# Check dependencies
rg --version
fd --version

# If using chezmoi
chezmoi --version
```

Open your editor and confirm plugins are loaded and icons display correctly.

---

## Troubleshooting

### Telescope errors: "rg" or "fd" not found

If Telescope shows errors about missing `rg` or `fd`:

```bash
# Verify they're installed
which rg fd
rg --version
fd --version

# Install if missing (see "Installing Dependencies" section above)
```

**Ubuntu/Debian note**: `fd` may be installed as `fdfind`. Create a symlink:

```bash
mkdir -p ~/.local/bin
ln -s $(which fdfind) ~/.local/bin/fd
export PATH="$HOME/.local/bin:$PATH"  # Add to ~/.bashrc or ~/.zshrc
```

### Plugins not loading

- Run sync command interactively: `:Lazy sync` (nvim) or `:PackerSync`
- Check `:checkhealth` for missing dependencies

### Icons/glyphs missing

- Install a Nerd Font: <https://www.nerdfonts.com/>
- Configure your terminal to use the Nerd Font

### Chezmoi conflicts

```bash
# See what changed
chezmoi diff

# Force re-apply
chezmoi apply --force

# Reset a specific file
chezmoi forget ~/.config/nvim/init.lua
chezmoi add ~/.config/nvim/init.lua
```

### Symlink issues (Linux/macOS)

```bash
# Check if symlink is correct
ls -la ~/.config/nvim

# Recreate symlink
rm ~/.config/nvim
ln -s ~/dotfiles/config/nvim ~/.config/nvim
```

### Junction issues (Windows)

```powershell
# Check junction
cmd /c dir "$env:LOCALAPPDATA\nvim" /AL

# Recreate junction
cmd /c rmdir "$env:LOCALAPPDATA\nvim"
cmd /c mklink /J "$env:LOCALAPPDATA\nvim" "$env:USERPROFILE\dotfiles\config\nvim"
```

---

## Customization

### With Symlinks

Edit files directly in the dotfiles repo:

```bash
cd ~/dotfiles/config/nvim
# Edit files, commit changes
git add .
git commit -m "Update config"
git push
```

### With Chezmoi

Use chezmoi commands:

```bash
# Edit managed files
chezmoi edit ~/.config/nvim/init.lua

# Apply and commit
chezmoi apply
chezmoi cd
git add .
git commit -m "Update config"
git push
```

---

## Uninstalling

### Remove Symlinks

```bash
rm ~/.config/nvim ~/.config/lvim
# Restore backups if needed
mv ~/.config/nvim.backup ~/.config/nvim
```

### Remove Chezmoi

```bash
# Remove chezmoi and all managed files
chezmoi purge

# Or just remove chezmoi but keep files
rm -rf ~/.local/share/chezmoi
```

---

## Additional Resources

- [Neovim Documentation](https://neovim.io/doc/)
- [LunarVim Documentation](https://www.lunarvim.org/docs)
- [Chezmoi User Guide](https://www.chezmoi.io/user-guide/setup/)
- [Chezmoi Quick Start](https://www.chezmoi.io/quick-start/)

---

## Feedback

If something is unclear or fails on your platform, [open an issue](https://github.com/Viole403/dotfiles/issues) with:

- OS and version
- Neovim/LunarVim version
- Steps you followed
- Error messages
