<#
.SYNOPSIS
Enhanced installer for Viole403 dotfiles on Windows (PowerShell)

.DESCRIPTION
Installs Neovim and/or LunarVim configurations with optional chezmoi support.
Auto-detects and installs dependencies (ripgrep, fd) using available package managers.
Supports backup, symlinks (junctions), and chezmoi-managed dotfiles.

.PARAMETER Chezmoi
Use chezmoi for dotfile management

.PARAMETER Nvim
Install Neovim config only

.PARAMETER Lvim
Install LunarVim config only

.PARAMETER Both
Install both Neovim and LunarVim configs (default)

.PARAMETER Yes
Non-interactive mode (use defaults)

.PARAMETER SkipDeps
Skip automatic dependency installation

.EXAMPLE
PS> .\install.ps1
Interactive mode with auto dependency installation

.EXAMPLE
PS> .\install.ps1 -Nvim
Install only Neovim config with dependencies

.EXAMPLE
PS> .\install.ps1 -Chezmoi -Both
Use chezmoi to manage both configs

.EXAMPLE
PS> .\install.ps1 -SkipDeps
Skip automatic dependency installation
#>

[CmdletBinding()]
param(
    [Parameter()]
    [switch]$Chezmoi,

    [Parameter()]
    [switch]$Nvim,

    [Parameter()]
    [switch]$Lvim,

    [Parameter()]
    [switch]$Both,

    [Parameter()]
    [switch]$Yes,

    [Parameter()]
    [switch]$SkipDeps
)

$ErrorActionPreference = "Stop"

# Color functions
function Write-Info { param([string]$Message) Write-Host "[INFO] $Message" -ForegroundColor Green }
function Write-Warn { param([string]$Message) Write-Host "[WARN] $Message" -ForegroundColor Yellow }
function Write-Error { param([string]$Message) Write-Host "[ERROR] $Message" -ForegroundColor Red }
function Write-Step { param([string]$Message) Write-Host "[STEP] $Message" -ForegroundColor Cyan }

# Detect available package manager
function Get-PackageManager {
    if (Get-Command scoop -ErrorAction SilentlyContinue) {
        return "scoop"
    } elseif (Get-Command choco -ErrorAction SilentlyContinue) {
        return "choco"
    } elseif (Get-Command winget -ErrorAction SilentlyContinue) {
        return "winget"
    } else {
        return "none"
    }
}

# Check if command exists
function Test-CommandExists {
    param([string]$Command)
    return [bool](Get-Command $Command -ErrorAction SilentlyContinue)
}

# Version comparison helper
function Test-VersionGreaterOrEqual {
    param([string]$Version1, [string]$Version2)
    return [version]$Version1 -ge [version]$Version2
}

# Check Neovim version
function Test-NeovimVersion {
    if (-not (Test-CommandExists "nvim")) {
        return $false
    }
    try {
        $nvimVersion = (nvim --version | Select-Object -First 1) -replace 'NVIM v([0-9.]+).*', '$1'
        if (Test-VersionGreaterOrEqual $nvimVersion "0.9.0") {
            Write-Info "Neovim $nvimVersion ✓ (>= 0.9.0 required)"
            return $true
        } else {
            Write-Error "Neovim $nvimVersion found, but >= 0.9.0 is required"
            return $false
        }
    } catch {
        return $false
    }
}

# Check Go version
function Test-GoVersion {
    if (-not (Test-CommandExists "go")) {
        return $false
    }
    try {
        $goVersion = (go version) -replace 'go version go([0-9.]+).*', '$1'
        if (Test-VersionGreaterOrEqual $goVersion "1.21.0") {
            Write-Info "Go $goVersion ✓ (>= 1.21 required)"
            return $true
        } else {
            Write-Warn "Go $goVersion found, but >= 1.21 is recommended"
            return $false
        }
    } catch {
        return $false
    }
}

# Check Python version
function Test-PythonVersion {
    if (-not (Test-CommandExists "python")) {
        return $false
    }
    try {
        $pythonVersion = (python --version 2>&1) -replace 'Python ([0-9.]+).*', '$1'
        Write-Info "Python $pythonVersion ✓"
        return $true
    } catch {
        return $false
    }
}

# Check Node version
function Test-NodeVersion {
    if (-not (Test-CommandExists "node")) {
        return $false
    }
    try {
        $nodeVersion = (node --version) -replace 'v([0-9.]+).*', '$1'
        if (Test-VersionGreaterOrEqual $nodeVersion "14.0.0") {
            Write-Info "Node $nodeVersion ✓ (>= 14.0 required)"
            return $true
        } else {
            Write-Warn "Node $nodeVersion found, but >= 14.0 is required"
            return $false
        }
    } catch {
        return $false
    }
}

# Check PHP version
function Test-PhpVersion {
    if (-not (Test-CommandExists "php")) {
        return $false
    }
    try {
        $phpVersion = (php --version | Select-Object -First 1) -replace 'PHP ([0-9.]+).*', '$1'
        Write-Info "PHP $phpVersion ✓"
        return $true
    } catch {
        return $false
    }
}

# Install dependencies
function Install-Dependencies {
    if ($SkipDeps) {
        Write-Info "Skipping dependency installation (SkipDeps flag)"
        return
    }

    Write-Step "Checking and installing dependencies..."

    $pkgManager = Get-PackageManager
    $missingDeps = @()
    $failedVersionChecks = @()

    # Check for essential tools with version requirements
    if (-not (Test-NeovimVersion)) {
        $missingDeps += "neovim"
        $failedVersionChecks += "neovim>=0.9.0"
    }

    if (-not (Test-GoVersion)) {
        $missingDeps += "golang"
        $failedVersionChecks += "golang>=1.21"
    }

    if (-not (Test-PythonVersion)) {
        $missingDeps += "python"
    }

    if (-not (Test-NodeVersion)) {
        $missingDeps += "nodejs"
        $failedVersionChecks += "nodejs>=14.0"
    }

    if (-not (Test-PhpVersion)) {
        $missingDeps += "php"
    }

    # Check for core development tools
    if (-not (Test-CommandExists "git")) { $missingDeps += "git" }
    if (-not (Test-CommandExists "make")) { $missingDeps += "make" }
    if (-not (Test-CommandExists "pip")) { $missingDeps += "pip" }
    if (-not (Test-CommandExists "npm")) { $missingDeps += "npm" }
    if (-not (Test-CommandExists "cargo")) { $missingDeps += "cargo" }
    if (-not (Test-CommandExists "composer")) { $missingDeps += "composer" }
    if (-not (Test-CommandExists "luarocks")) { $missingDeps += "luarocks" }

    # Check for essential CLI tools
    if (-not (Test-CommandExists "rg")) { $missingDeps += "ripgrep" }
    if (-not (Test-CommandExists "fd")) { $missingDeps += "fd" }
    if (-not (Test-CommandExists "lazygit")) { $missingDeps += "lazygit" }
    if (-not (Test-CommandExists "curl")) { $missingDeps += "curl" }
    if (-not (Test-CommandExists "wget")) { $missingDeps += "wget" }
    if (-not (Test-CommandExists "gzip")) { $missingDeps += "gzip" }
    if (-not (Test-CommandExists "tar")) { $missingDeps += "tar" }
    if (-not (Test-CommandExists "7z")) { $missingDeps += "7zip" }

    if ($missingDeps.Count -eq 0) {
        Write-Info "All essential dependencies are already installed ✓"
        # Auto-install code-minimap if cargo is available
        if ((Test-CommandExists "cargo") -and -not (Test-CommandExists "code-minimap")) {
            Write-Info "Installing code-minimap..."
            cargo install --locked code-minimap
            Write-Info "code-minimap installed ✓"
        }
        return
    }

    Write-Warn "Missing dependencies: $($missingDeps -join ', ')"
    if ($failedVersionChecks.Count -gt 0) {
        Write-Warn "Version requirements not met: $($failedVersionChecks -join ', ')"
    }

    if ($pkgManager -eq "none") {
        Write-Error "No package manager detected (scoop/chocolatey/winget)."
        Write-Host "Please install one:"
        Write-Host "  • Scoop (recommended): https://scoop.sh"
        Write-Host "  • Chocolatey: https://chocolatey.org"
        Write-Host "  • Winget (built-in Windows 10/11)"
        Write-Host ""
        Write-Host "Or install manually:"
        Write-Host "  • Neovim >= 0.9.0: https://neovim.io"
        Write-Host "  • Git: https://git-scm.com"
        Write-Host "  • Python 3: https://python.org"
        Write-Host "  • Node.js: https://nodejs.org"
        Write-Host "  • Go >= 1.21: https://go.dev"
        Write-Host "  • Rust/Cargo: https://rustup.rs"
        Write-Host "  • ripgrep: https://github.com/BurntSushi/ripgrep/releases"
        Write-Host "  • fd: https://github.com/sharkdp/fd/releases"
        Write-Host "  • lazygit: https://github.com/jesseduffield/lazygit/releases"
        return
    }

    if (-not $Yes) {
        $install = Read-Host "Install missing dependencies using $pkgManager? [Y/n]"
        if ($install -match "^[Nn]$") {
            Write-Warn "Skipping dependency installation. Install manually later."
            return
        }
    }

    Write-Info "Installing dependencies using $pkgManager..."

    switch ($pkgManager) {
        "scoop" {
            foreach ($dep in $missingDeps) {
                switch ($dep) {
                    "neovim" { scoop install neovim }
                    "git" { scoop install git }
                    "make" { scoop install make }
                    "python" { scoop install python }
                    "pip" { Write-Info "pip comes with Python" }
                    "nodejs" { scoop install nodejs }
                    "npm" { Write-Info "npm comes with Node.js" }
                    "golang" { scoop install go }
                    "cargo" { scoop install rust }
                    "ripgrep" { scoop install ripgrep }
                    "fd" { scoop install fd }
                    "lazygit" { scoop install lazygit }
                    "curl" { scoop install curl }
                    "wget" { scoop install wget }
                    "gzip" { scoop install gzip }
                    "tar" { scoop install tar }
                    "7zip" { scoop install 7zip }
                }
            }
        }
        "choco" {
            foreach ($dep in $missingDeps) {
                switch ($dep) {
                    "neovim" { choco install neovim -y }
                    "git" { choco install git -y }
                    "make" { choco install make -y }
                    "python" { choco install python -y }
                    "pip" { Write-Info "pip comes with Python" }
                    "nodejs" { choco install nodejs -y }
                    "npm" { Write-Info "npm comes with Node.js" }
                    "golang" { choco install golang -y }
                    "cargo" { choco install rust -y }
                    "ripgrep" { choco install ripgrep -y }
                    "fd" { choco install fd -y }
                    "lazygit" { choco install lazygit -y }
                    "curl" { choco install curl -y }
                    "wget" { choco install wget -y }
                    "gzip" { choco install gzip -y }
                    "tar" { choco install tar -y }
                    "7zip" { choco install 7zip -y }
                }
            }
        }
        "winget" {
            foreach ($dep in $missingDeps) {
                switch ($dep) {
                    "neovim" { winget install Neovim.Neovim --silent }
                    "git" { winget install Git.Git --silent }
                    "make" { winget install GnuWin32.Make --silent }
                    "python" { winget install Python.Python.3.11 --silent }
                    "pip" { Write-Info "pip comes with Python" }
                    "nodejs" { winget install OpenJS.NodeJS --silent }
                    "npm" { Write-Info "npm comes with Node.js" }
                    "golang" { winget install GoLang.Go --silent }
                    "cargo" { winget install Rustlang.Rust.MSVC --silent }
                    "ripgrep" { winget install BurntSushi.ripgrep.MSVC --silent }
                    "fd" { winget install sharkdp.fd --silent }
                    "lazygit" { winget install JesseDuffield.lazygit --silent }
                    "curl" { Write-Info "curl is built into Windows 10+" }
                    "wget" { winget install JernejSimoncic.Wget --silent }
                    "gzip" { Write-Info "Use 7zip for compression" }
                    "tar" { Write-Info "tar is built into Windows 10+" }
                    "7zip" { winget install 7zip.7zip --silent }
                }
            }
        }
    }

    Write-Info "Dependencies installed successfully ✓"

    # Refresh PATH
    $env:PATH = [System.Environment]::GetEnvironmentVariable("PATH", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("PATH", "User")

    # Auto-install code-minimap if cargo is available
    if ((Test-CommandExists "cargo") -and -not (Test-CommandExists "code-minimap")) {
        Write-Info "Installing code-minimap..."
        cargo install --locked code-minimap
        Write-Info "code-minimap installed ✓"
    }

    # Auto-install tree-sitter-cli if cargo is available
    if ((Test-CommandExists "cargo") -and -not (Test-CommandExists "tree-sitter")) {
        Write-Info "Installing tree-sitter-cli..."
        cargo install --locked tree-sitter-cli
        Write-Info "tree-sitter-cli installed ✓"
    } elseif ((Test-CommandExists "npm") -and -not (Test-CommandExists "tree-sitter")) {
        Write-Info "Installing tree-sitter-cli via npm..."
        npm install -g tree-sitter-cli
        Write-Info "tree-sitter-cli installed ✓"
    }

    # Install formatter tools (none-ls requirements)
    Write-Step "Installing formatter tools for none-ls..."

    # prettierd (JS/TS/Astro/React/Next/Bun)
    if ((Test-CommandExists "npm") -and -not (Test-CommandExists "prettierd")) {
        Write-Info "Installing prettierd..."
        npm install -g @fsouza/prettierd
    }

    # gofumpt and goimports (Go)
    if (Test-CommandExists "go") {
        if (-not (Get-Command gofumpt -ErrorAction SilentlyContinue)) {
            Write-Info "Installing gofumpt..."
            go install mvdan.cc/gofumpt@latest
        }
        if (-not (Get-Command goimports -ErrorAction SilentlyContinue)) {
            Write-Info "Installing goimports..."
            go install golang.org/x/tools/cmd/goimports@latest
        }
    }

    # black (Python)
    if ((Test-CommandExists "pip") -and -not (Get-Command black -ErrorAction SilentlyContinue)) {
        Write-Info "Installing black..."
        pip install --user black
    }

    # php-cs-fixer (PHP)
    if ((Test-CommandExists "composer") -and -not (Get-Command php-cs-fixer -ErrorAction SilentlyContinue)) {
        Write-Info "Installing php-cs-fixer..."
        composer global require friendsofphp/php-cs-fixer
    }

    Write-Info "Formatter tools installation complete ✓"
}

# Detect dotfiles directory
$DotfilesDir = if (Test-Path ".git" -Or Test-Path "config") {
    $PSScriptRoot
} else {
    $env:USERPROFILE + "\dotfiles"
    if (-not (Test-Path $DotfilesDir)) {
        Write-Info "Dotfiles not found at $DotfilesDir — cloning..."
        git clone https://github.com/Viole403/dotfiles.git $DotfilesDir
    }
    $DotfilesDir
}

Write-Info "Using dotfiles directory: $DotfilesDir"

# Install dependencies first
Install-Dependencies

# Interactive prompts
$InstallNvim = $false
$InstallLvim = $false

if ($Both) {
    $InstallNvim = $true
    $InstallLvim = $true
} elseif ($Nvim) {
    $InstallNvim = $true
} elseif ($Lvim) {
    $InstallLvim = $true
} elseif (-not $Yes) {
    Write-Host ""
    Write-Host "Which editor configuration do you want to install?"
    Write-Host "  1) Neovim only"
    Write-Host "  2) LunarVim only"
    Write-Host "  3) Both (default)"
    $choice = Read-Host "Choice [1-3]"
    switch ($choice) {
        "1" { $InstallNvim = $true }
        "2" { $InstallLvim = $true }
        default { $InstallNvim = $true; $InstallLvim = $true }
    }
} else {
    # Non-interactive defaults
    $InstallNvim = $true
    $InstallLvim = $true
}

if (-not $Chezmoi -and -not $Yes) {
    Write-Host ""
    $useChezmoi = Read-Host "Use chezmoi for dotfile management? [y/N]"
    if ($useChezmoi -match "^[Yy]$") {
        $Chezmoi = $true
    }
}

function Backup-And-Link {
    param(
        [string]$Target,
        [string]$Source
    )

    if (Test-Path $Target) {
        if ((Get-Item $Target).LinkType -eq "Junction" -or (Get-Item $Target).Attributes -band [System.IO.FileAttributes]::ReparsePoint) {
            Write-Info "Removing existing junction/symlink: $Target"
            cmd /c rmdir $Target 2>$null
            Remove-Item $Target -Force -ErrorAction SilentlyContinue
        } else {
            Write-Warn "Backing up existing $Target -> ${Target}.backup"
            Move-Item $Target "${Target}.backup" -Force
        }
    }

    $ParentDir = Split-Path $Target -Parent
    if (-not (Test-Path $ParentDir)) {
        New-Item -ItemType Directory -Path $ParentDir -Force | Out-Null
    }

    # Use junction (works without admin privileges)
    Write-Info "Creating junction: $Target -> $Source"
    cmd /c mklink /J "$Target" "$Source" | Out-Null
    if ($LASTEXITCODE -ne 0) {
        Write-Error "Failed to create junction for $Target"
    }
}

function Install-WithSymlinks {
    Write-Host ""
    Write-Info "Installing with junctions (Windows symlinks)..."

    $localAppData = $env:LOCALAPPDATA

    if ($InstallNvim) {
        $nvimTarget = "$localAppData\nvim"
        $nvimSource = "$DotfilesDir\config\nvim"
        Backup-And-Link -Target $nvimTarget -Source $nvimSource
    }

    if ($InstallLvim) {
        $lvimTarget = "$localAppData\lvim"
        $lvimSource = "$DotfilesDir\config\lvim"
        Backup-And-Link -Target $lvimTarget -Source $lvimSource
    }
}

function Install-WithChezmoi {
    Write-Host ""
    Write-Info "Installing with chezmoi..."

    # Check if chezmoi is installed
    $chezmoiPath = Get-Command chezmoi -ErrorAction SilentlyContinue
    if (-not $chezmoiPath) {
        Write-Info "Installing chezmoi..."
        $BinDir = "$env:USERPROFILE\.local\bin"
        if (-not (Test-Path $BinDir)) {
            New-Item -ItemType Directory -Path $BinDir -Force | Out-Null
        }

        # Download and install chezmoi
        Invoke-WebRequest -Uri "https://get.chezmoi.io/ps1" -UseBasicParsing | Invoke-Expression
        $env:PATH = "$BinDir;$env:PATH"
    }

    # Initialize chezmoi if not already initialized
    $chezmoiSourceDir = "$env:USERPROFILE\.local\share\chezmoi"
    if (-not (Test-Path $chezmoiSourceDir)) {
        Write-Info "Initializing chezmoi with dotfiles repo..."
        chezmoi init --apply "https://github.com/Viole403/dotfiles.git"
    } else {
        Write-Info "Chezmoi already initialized"
    }

    # Add configs to chezmoi
    $localAppData = $env:LOCALAPPDATA

    if ($InstallNvim -and (Test-Path "$DotfilesDir\config\nvim")) {
        Write-Info "Adding Neovim config to chezmoi..."
        chezmoi add --follow "$localAppData\nvim" 2>$null
    }

    if ($InstallLvim -and (Test-Path "$DotfilesDir\config\lvim")) {
        Write-Info "Adding LunarVim config to chezmoi..."
        chezmoi add --follow "$localAppData\lvim" 2>$null
    }

    Write-Info "Applying chezmoi configuration..."
    chezmoi apply
}

# Main installation
if ($Chezmoi) {
    Install-WithChezmoi
} else {
    Install-WithSymlinks
}

Write-Host ""
Write-Info "Installation complete!"
Write-Host ""

# Verify installations
$rgInstalled = Test-CommandExists "rg"
$fdInstalled = Test-CommandExists "fd"

if ($rgInstalled -and $fdInstalled) {
    Write-Info "✓ ripgrep and fd are installed"
} else {
    Write-Warn "Some dependencies may be missing. Verify with:"
    if (-not $rgInstalled) { Write-Host "  rg --version" }
    if (-not $fdInstalled) { Write-Host "  fd --version" }
}

Write-Host ""
Write-Host "Next steps:"
if ($InstallNvim) {
    Write-Host "  • Open Neovim and run :Lazy sync (or your plugin manager's sync command)"
}
if ($InstallLvim) {
    Write-Host "  • Open LunarVim: lvim"
}
if ($Chezmoi) {
    Write-Host "  • Manage with chezmoi: chezmoi edit $env:LOCALAPPDATA\nvim\init.lua"
    Write-Host "  • Apply changes: chezmoi apply"
}
Write-Host ""
Write-Host "For more details, see: https://github.com/Viole403/dotfiles/blob/main/INSTALL.md"
