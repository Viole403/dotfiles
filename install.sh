#!/usr/bin/env bash
set -euo pipefail

# Enhanced installer for Viole403 dotfiles
# - supports choosing between Neovim or LunarVim (or both)
# - optional chezmoi integration for advanced dotfile management
# - auto-detects and installs dependencies (ripgrep, fd, etc.)
# - backs up existing configs
# - creates symlinks OR chezmoi-managed configs
# Usage: ./install.sh [OPTIONS]

DOTFILES_REPO_DEFAULT="$HOME/dotfiles"
DOTFILES_DIR=""
USE_CHEZMOI="false"
INSTALL_NVIM=""
INSTALL_LVIM=""
NON_INTERACTIVE="false"
SKIP_DEPS="false"

# Color output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_info() { echo -e "${GREEN}[INFO]${NC} $1"; }
print_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
print_error() { echo -e "${RED}[ERROR]${NC} $1"; }
print_step() { echo -e "${BLUE}[STEP]${NC} $1"; }

usage() {
  cat <<EOF
Usage: $0 [OPTIONS]

Options:
  -c, --chezmoi          Use chezmoi for dotfile management
  -n, --nvim             Install Neovim config only
  -l, --lvim             Install LunarVim config only
  -b, --both             Install both Neovim and LunarVim configs (default)
  -y, --yes              Non-interactive mode (use defaults)
  -s, --skip-deps        Skip automatic dependency installation
  -h, --help             Show this help message

Examples:
  $0                     # Interactive mode, auto-install dependencies
  $0 --nvim              # Install only Neovim config with dependencies
  $0 --chezmoi --both    # Use chezmoi to manage both configs
  $0 --skip-deps         # Skip automatic dependency installation
EOF
  exit 0
}

# Parse arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    -c|--chezmoi) USE_CHEZMOI="true"; shift ;;
    -n|--nvim) INSTALL_NVIM="true"; INSTALL_LVIM="false"; shift ;;
    -l|--lvim) INSTALL_LVIM="true"; INSTALL_NVIM="false"; shift ;;
    -b|--both) INSTALL_NVIM="true"; INSTALL_LVIM="true"; shift ;;
    -y|--yes) NON_INTERACTIVE="true"; shift ;;
    -s|--skip-deps) SKIP_DEPS="true"; shift ;;
    -h|--help) usage ;;
    *) print_error "Unknown option: $1"; usage ;;
  esac
done

# Detect dotfiles directory
if [ -d ".git" ] || [ -d "config" ]; then
  DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
else
  DOTFILES_DIR="${DOTFILES_REPO:-$DOTFILES_REPO_DEFAULT}"
  if [ ! -d "$DOTFILES_DIR" ]; then
    print_info "Dotfiles not found at $DOTFILES_DIR — cloning..."
    git clone https://github.com/Viole403/dotfiles.git "$DOTFILES_DIR"
  fi
fi

print_info "Using dotfiles directory: $DOTFILES_DIR"

# Detect package manager and OS
detect_package_manager() {
  if command -v apt-get >/dev/null 2>&1; then
    echo "apt"
  elif command -v dnf >/dev/null 2>&1; then
    echo "dnf"
  elif command -v pacman >/dev/null 2>&1; then
    echo "pacman"
  elif command -v brew >/dev/null 2>&1; then
    echo "brew"
  elif command -v zypper >/dev/null 2>&1; then
    echo "zypper"
  elif command -v apk >/dev/null 2>&1; then
    echo "apk"
  else
    echo "unknown"
  fi
}

# Check if command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Install dependencies based on detected package manager
install_dependencies() {
  if [ "$SKIP_DEPS" = "true" ]; then
    print_info "Skipping dependency installation (--skip-deps flag)"
    return 0
  fi

  print_step "Checking and installing dependencies..."

  local pkg_manager=$(detect_package_manager)
  local missing_deps=()

  # Check for essential tools
  command_exists rg || missing_deps+=("ripgrep")
  command_exists fd || missing_deps+=("fd")

  if [ ${#missing_deps[@]} -eq 0 ]; then
    print_info "All essential dependencies are already installed ✓"
    return 0
  fi

  print_warn "Missing dependencies: ${missing_deps[*]}"

  if [ "$NON_INTERACTIVE" = "false" ]; then
    echo
    read -rp "Install missing dependencies automatically? [Y/n]: " install_deps
    if [[ "$install_deps" =~ ^[Nn]$ ]]; then
      print_warn "Skipping dependency installation. Install manually later."
      return 0
    fi
  fi

  print_info "Installing dependencies using $pkg_manager..."

  case $pkg_manager in
    apt)
      print_info "Using apt-get (Ubuntu/Debian)..."
      sudo apt-get update
      for dep in "${missing_deps[@]}"; do
        case $dep in
          ripgrep) sudo apt-get install -y ripgrep ;;
          fd) sudo apt-get install -y fd-find ;;
        esac
      done
      # Create fd symlink if needed on Debian/Ubuntu
      if command_exists fdfind && ! command_exists fd; then
        mkdir -p "$HOME/.local/bin"
        ln -sf "$(command -v fdfind)" "$HOME/.local/bin/fd"
        export PATH="$HOME/.local/bin:$PATH"
        print_info "Created fd symlink from fdfind"
      fi
      ;;
    dnf)
      print_info "Using dnf (Fedora)..."
      for dep in "${missing_deps[@]}"; do
        case $dep in
          ripgrep) sudo dnf install -y ripgrep ;;
          fd) sudo dnf install -y fd-find ;;
        esac
      done
      ;;
    pacman)
      print_info "Using pacman (Arch Linux)..."
      for dep in "${missing_deps[@]}"; do
        case $dep in
          ripgrep) sudo pacman -S --noconfirm ripgrep ;;
          fd) sudo pacman -S --noconfirm fd ;;
        esac
      done
      ;;
    brew)
      print_info "Using Homebrew (macOS)..."
      for dep in "${missing_deps[@]}"; do
        case $dep in
          ripgrep) brew install ripgrep ;;
          fd) brew install fd ;;
        esac
      done
      ;;
    zypper)
      print_info "Using zypper (openSUSE)..."
      for dep in "${missing_deps[@]}"; do
        case $dep in
          ripgrep) sudo zypper install -y ripgrep ;;
          fd) sudo zypper install -y fd ;;
        esac
      done
      ;;
    apk)
      print_info "Using apk (Alpine Linux)..."
      for dep in "${missing_deps[@]}"; do
        case $dep in
          ripgrep) sudo apk add ripgrep ;;
          fd) sudo apk add fd ;;
        esac
      done
      ;;
    *)
      print_error "Unknown package manager. Please install manually:"
      print_error "  - ripgrep: https://github.com/BurntSushi/ripgrep"
      print_error "  - fd: https://github.com/sharkdp/fd"
      return 1
      ;;
  esac

  print_info "Dependencies installed successfully ✓"
}

# Install optional dependencies
install_optional_deps() {
  if [ "$SKIP_DEPS" = "true" ]; then
    return 0
  fi

  local pkg_manager=$(detect_package_manager)

  # Check for optional tools
  if ! command_exists pip3 && [ "$NON_INTERACTIVE" = "false" ]; then
    echo
    read -rp "Install Python pip for pynvim? [y/N]: " install_pip
    if [[ "$install_pip" =~ ^[Yy]$ ]]; then
      case $pkg_manager in
        apt) sudo apt-get install -y python3-pip ;;
        dnf) sudo dnf install -y python3-pip ;;
        pacman) sudo pacman -S --noconfirm python-pip ;;
        brew) brew install python ;;
      esac
    fi
  fi

  # Install pynvim if pip exists
  if command_exists pip3 && [ "$NON_INTERACTIVE" = "false" ]; then
    read -rp "Install pynvim (Python support for Neovim)? [y/N]: " install_pynvim
    if [[ "$install_pynvim" =~ ^[Yy]$ ]]; then
      pip3 install --user pynvim
      print_info "pynvim installed ✓"
    fi
  fi
}

# Interactive prompts if not specified
if [ "$NON_INTERACTIVE" = "false" ]; then
  if [ -z "$INSTALL_NVIM" ] && [ -z "$INSTALL_LVIM" ]; then
    echo
    echo "Which editor configuration do you want to install?"
    echo "  1) Neovim only"
    echo "  2) LunarVim only"
    echo "  3) Both (default)"
    read -rp "Choice [1-3]: " choice
    case $choice in
      1) INSTALL_NVIM="true"; INSTALL_LVIM="false" ;;
      2) INSTALL_NVIM="false"; INSTALL_LVIM="true" ;;
      *) INSTALL_NVIM="true"; INSTALL_LVIM="true" ;;
    esac
  fi

  if [ "$USE_CHEZMOI" = "false" ]; then
    echo
    read -rp "Use chezmoi for dotfile management? [y/N]: " use_chezmoi_input
    if [[ "$use_chezmoi_input" =~ ^[Yy]$ ]]; then
      USE_CHEZMOI="true"
    fi
  fi
else
  # Non-interactive defaults
  [ -z "$INSTALL_NVIM" ] && INSTALL_NVIM="true"
  [ -z "$INSTALL_LVIM" ] && INSTALL_LVIM="true"
fi

# Install dependencies before proceeding
install_dependencies
install_optional_deps

backup_and_link() {
  local target="$1"
  local src="$2"

  if [ -e "$target" ] && [ ! -L "$target" ]; then
    print_warn "Backing up existing $target -> ${target}.backup"
    mv "$target" "${target}.backup"
  elif [ -L "$target" ]; then
    print_info "Removing existing symlink $target"
    rm -f "$target"
  fi

  mkdir -p "$(dirname "$target")"
  ln -sfn "$src" "$target"
  print_info "Linked $target -> $src"
}

install_with_symlinks() {
  echo
  print_info "Installing with symlinks..."

  if [ "$INSTALL_NVIM" = "true" ]; then
    backup_and_link "$HOME/.config/nvim" "$DOTFILES_DIR/config/nvim"
  fi

  if [ "$INSTALL_LVIM" = "true" ]; then
    backup_and_link "$HOME/.config/lvim" "$DOTFILES_DIR/config/lvim"
  fi
}

install_with_chezmoi() {
  echo
  print_info "Installing with chezmoi..."

  # Check if chezmoi is installed
  if ! command -v chezmoi >/dev/null 2>&1; then
    print_info "Installing chezmoi..."
    sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$HOME/.local/bin"
    export PATH="$HOME/.local/bin:$PATH"
  fi

  # Initialize chezmoi if not already initialized
  if [ ! -d "$HOME/.local/share/chezmoi" ]; then
    print_info "Initializing chezmoi with dotfiles repo..."
    chezmoi init --apply "https://github.com/Viole403/dotfiles.git"
  else
    print_info "Chezmoi already initialized"
  fi

  # Add configs to chezmoi
  if [ "$INSTALL_NVIM" = "true" ] && [ -d "$DOTFILES_DIR/config/nvim" ]; then
    print_info "Adding Neovim config to chezmoi..."
    chezmoi add --follow "$HOME/.config/nvim" 2>/dev/null || true
  fi

  if [ "$INSTALL_LVIM" = "true" ] && [ -d "$DOTFILES_DIR/config/lvim" ]; then
    print_info "Adding LunarVim config to chezmoi..."
    chezmoi add --follow "$HOME/.config/lvim" 2>/dev/null || true
  fi

  print_info "Applying chezmoi configuration..."
  chezmoi apply
}

if [ "$USE_CHEZMOI" = "true" ]; then
  install_with_chezmoi
else
  install_with_symlinks
fi

echo
print_info "Installation complete!"
echo

# Verify installations
if command_exists rg && command_exists fd; then
  print_info "✓ ripgrep and fd are installed"
else
  print_warn "Some dependencies may be missing. Verify with:"
  echo "  rg --version"
  echo "  fd --version"
fi

echo
echo "Next steps:"
if [ "$INSTALL_NVIM" = "true" ]; then
  echo "  • Open Neovim and run :Lazy sync (or your plugin manager's sync command)"
fi
if [ "$INSTALL_LVIM" = "true" ]; then
  echo "  • Open LunarVim: lvim"
fi
if [ "$USE_CHEZMOI" = "true" ]; then
  echo "  • Manage with chezmoi: chezmoi edit ~/.config/nvim/init.lua"
  echo "  • Apply changes: chezmoi apply"
fi
echo
echo "For more details, see: https://github.com/Viole403/dotfiles/blob/main/INSTALL.md"
