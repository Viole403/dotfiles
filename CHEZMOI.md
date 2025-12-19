# Chezmoi Integration Guide

This file explains how to use this dotfiles repo with [chezmoi](https://www.chezmoi.io/) (v2.0+) for advanced dotfile management across multiple machines.

## Why Chezmoi?

Chezmoi helps manage dotfiles across diverse machines by:

- **Templating**: Different configs per machine (e.g., work vs. personal)
- **Encryption**: Secure storage of secrets
- **Cross-platform**: Works on Linux, macOS, Windows, WSL
- **Version control**: Git-based with easy sync
- **External files**: Manage files outside your home directory

### Version Requirement

This repository requires **chezmoi v2.0.0 or higher**. The `.chezmoiversion` file in the repo root enforces this requirement - chezmoi will refuse to run if your version is too old.

## Quick Start with Chezmoi

### First-time Setup

```bash
# Install chezmoi (latest version)
sh -c "$(curl -fsLS get.chezmoi.io)"

# Verify installation (recommended v2.0+)
chezmoi --version

# Initialize with this repo
chezmoi init https://github.com/Viole403/dotfiles.git

# Preview what will change
chezmoi diff

# Apply the changes
chezmoi apply -v
```

### Using the Template

This repo includes `.chezmoi.toml.tmpl` which will prompt you to choose:

- Which editor to install (nvim, lvim, or both)
- Your email address (for git config, etc.)

The template automatically adapts to your choices.

## Daily Workflow

### Editing Files

```bash
# Edit a file with chezmoi
chezmoi edit ~/.config/nvim/init.lua

# See what changed
chezmoi diff

# Apply the changes
chezmoi apply

# Or edit + apply in one go
chezmoi edit --apply ~/.config/nvim/init.lua
```

### Adding New Files

```bash
# Add a new config file to be managed
chezmoi add ~/.config/nvim/lua/plugins/new-plugin.lua

# Add a directory recursively
chezmoi add --recursive ~/.config/alacritty
```

### Syncing Changes

```bash
# Pull latest changes from the repo and apply
chezmoi update

# Push your local changes
chezmoi cd
git add .
git commit -m "Update nvim config"
git push
exit  # or Ctrl+D to return to your home directory
```

## Advanced Features

### Templates

Use Go templates in your config files to adapt to different machines:

**Example**: `.config/nvim/lua/core/options.lua.tmpl`

```lua
-- Machine-specific font size
{{- if eq .chezmoi.hostname "work-laptop" }}
vim.opt.guifont = "FiraCode Nerd Font:h14"
{{- else }}
vim.opt.guifont = "FiraCode Nerd Font:h12"
{{- end }}

-- OS-specific clipboard
{{- if eq .chezmoi.os "darwin" }}
vim.opt.clipboard = "unnamedplus"
{{- else if eq .chezmoi.os "windows" }}
vim.opt.clipboard = "unnamed"
{{- end }}
```

### Only Install Specific Configs

Edit `.chezmoi.toml.tmpl` or your generated `~/.config/chezmoi/chezmoi.toml`:

```toml
[data]
    install_nvim = true
    install_lvim = false  # Don't install LunarVim
```

Then use conditionals in file names:

- `{{ if .install_nvim }}dot_config/nvim/...{{ end }}`

### External Files

Manage external git repos or downloads with `.chezmoiexternal.toml`:

```toml
[".config/nvim/pack/vendor/start/packer.nvim"]
    type = "archive"
    url = "https://github.com/wbthomason/packer.nvim/archive/master.tar.gz"
    stripComponents = 1
    refreshPeriod = "168h"
```

### Secrets Management

```bash
# Store secrets encrypted
chezmoi age encrypt --output ~/.local/share/chezmoi/encrypted_api_key.age

# Use in templates
{{ include ".encrypted_api_key.age" | decrypt }}
```

## Platform-Specific Notes

### Windows

Chezmoi works on Windows with PowerShell:

```powershell
# Install chezmoi
iex "&{$(irm 'https://get.chezmoi.io/ps1')}"

# Initialize and apply
chezmoi init --apply https://github.com/Viole403/dotfiles.git
```

Config locations on Windows:

- Chezmoi config: `%LOCALAPPDATA%\chezmoi\chezmoi.toml`
- Source dir: `%USERPROFILE%\.local\share\chezmoi`

### WSL

Chezmoi can share configs between Windows and WSL:

```bash
# In WSL, use Windows chezmoi source
export CHEZMOI_SOURCE_DIR="/mnt/c/Users/$USER/.local/share/chezmoi"
chezmoi apply
```

## Troubleshooting

### See what chezmoi would do

```bash
chezmoi diff
chezmoi apply --dry-run --verbose
```

### Reset a file

```bash
# Remove from chezmoi management
chezmoi forget ~/.config/nvim/init.lua

# Re-add it
chezmoi add ~/.config/nvim/init.lua
```

### Verify state

```bash
# Check which files chezmoi manages
chezmoi managed

# Verify everything is in sync
chezmoi verify
```

### Debug

```bash
# Run with debug output
chezmoi --verbose apply

# Execute template to see output
chezmoi execute-template '{{ .chezmoi.os }}'
```

## Migration from Symlinks

If you're currently using symlinks:

```bash
# Add with --follow to track the file content, not the symlink
chezmoi add --follow ~/.config/nvim

# Apply to replace symlink with actual files
chezmoi apply
```

## Useful Commands Reference

```bash
# Status of managed files
chezmoi status

# Show source directory
chezmoi source-path

# Open source directory
chezmoi cd

# Show target directory (your home)
echo $HOME

# Archive all dotfiles (for backup or migration)
chezmoi archive --output=dotfiles.tar.gz

# Remove chezmoi and keep files
chezmoi purge --binary=false

# Remove everything
chezmoi purge
```

## Resources

- [Chezmoi Documentation](https://www.chezmoi.io/)
- [Chezmoi User Guide](https://www.chezmoi.io/user-guide/)
- [Template Functions](https://www.chezmoi.io/reference/templates/)
- [Example Repos](https://www.chezmoi.io/links/dotfile-repos/)

## Contributing

When adding new configs to this repo with chezmoi support:

1. Add the file to chezmoi: `chezmoi add ~/.config/newapp/config`
2. If it needs templating, rename with `.tmpl`: `chezmoi cd && mv dot_config/newapp/config dot_config/newapp/config.tmpl`
3. Add template logic if needed
4. Test with `chezmoi apply --dry-run`
5. Commit and push from source dir: `chezmoi cd && git add . && git commit && git push`
