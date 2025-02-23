# 🚀 Neovim Development Environment Installer

This project provides an automated installation and configuration of a development environment centered around Neovim. The installer supports multiple operating systems and sets up a complete development environment with necessary tools and configurations.

## 💻 Supported Operating Systems

- 🍎 macOS
- 🏔️ Alpine Linux
- 🐧 Debian/Ubuntu
- 🎯 Arch Linux

## 📦 What Gets Installed

- 📝 Neovim (version 0.10.0 or higher)
- 📊 Git
- 🖥️ Tmux
- 🐚 Zsh with Oh My Zsh
- 🛠️ Various development tools (ripgrep, nodejs, npm, go, rust)
- 🔧 Language servers and development tools:
  - intelephense (PHP)
  - pyright (Python)
  - bash-language-server
  - typescript-language-server
  - gopls (Go)

## 🔨 Installation

```bash
sudo ./install.sh
```

## ❓ Help System
The installer includes three help scripts that can be accessed through aliases:

- `ah` - Shows available aliases for git, docker, docker-compose, and symfony
- `nh` - Displays Neovim shortcuts and commands
- `th` - Lists Tmux keyboard shortcuts and commands

## ⚙️ Neovim Configuration
The Neovim setup includes a modern IDE-like configuration with the following features:

### 🔌 Core Plugins
- lazy.nvim - Plugin manager
- mason.nvim - LSP and DAP package manager
- neo-tree.nvim - File explorer
- telescope.nvim - Fuzzy finder
- lualine.nvim - Status line
- nvim-treesitter - Syntax highlighting
- nvim-lspconfig - LSP configuration
- nvim-cmp - Completion engine
- null-ls.nvim - Formatting and diagnostics
- lazygit.nvim - Git integration

### 🎨 Theme
onedark.nvim - Modern theme with good syntax highlighting

### ✨ Additional Features
- LSP support for multiple languages
- Integrated terminal
- File tree navigation
- Fuzzy finding
- Git integration
- Code completion
- Syntax highlighting
- Code formatting
- Diagnostic tools

## 📁 Configuration Files
All configuration files are symlinked from the repository to their respective locations:

- Neovim: ~/.config/nvim
- Tmux: ~/.config/tmux/tmux.conf
- Zsh: ~/.zshrc

## ⚙️ Additional Settings

### 🐚 Setting Zsh as Default Shell

#### 🐧 macOS/Linux
Using chsh (automatically done by installer):
```bash
chsh -s $(which zsh)
```

#### 🪟 Windows Terminal
Modify settings.json and add:
```json
{
    "defaultProfile": "{...}",
    "profiles": {
        "defaults": {
            "shell": "zsh"
        }
    }
}
```

#### ⚡ VSCode
add to settings.json:
```json
{
    "terminal.integrated.defaultProfile.linux": "zsh",
    "terminal.integrated.defaultProfile.osx": "zsh",
    "terminal.integrated.defaultProfile.windows": "zsh"
}
```

### 🖥️ Setting up Tmux Auto-Start

#### 🐧 macOS/Linux
Add to your ~/.zshrc (already included in our configuration):
```bash
# Auto-start tmux
if [ -z "$TMUX" ]; then
    tmux attach -t default || tmux new -s default
fi
```

#### 🪟 Windows Terminal
Modify settings.json and add:
```json
{
    "profiles": {
        "defaults": {
            "commandline": "tmux attach -t default || tmux new -s default"
        }
    }
}
```
#### ⚡ VSCode
add to settings.json:
```json
{
    "terminal.integrated.profiles.linux": {
        "tmux": {
            "source": "tmux",
            "commandline": "tmux attach -t default || tmux new -s default"
        }
    },
    "terminal.integrated.profiles.osx": {
        "tmux": {
            "source": "tmux",
            "commandline": "tmux attach -t default || tmux new -s default"
        }
    },
    "terminal.integrated.profiles.windows": {
        "tmux": {
            "source": "tmux",
            "commandline": "tmux attach -t default || tmux new -s default"
        }
    }
}
```

## 🧪 Testing

The installer can be tested in different Linux distributions using Docker containers.

### Supported Test Environments
- Alpine Linux
- Debian
- Arch Linux
- Ubuntu
- Kali Linux
- Manjaro
- macOS (experimental)

### Running Tests

Test all environments:
```bash
docker-compose up --build
```

Test specific environment:
```bash
docker-compose up --build <environment>
### e.g.:
docker-compose up --build test-alpine    # Test on Alpine
```

## 🙏 Acknowledgments

This configuration was inspired by the following YouTube channels:

- 🎥 [TypeCraft](https://www.youtube.com/@typecraft_dev) - For their excellent Neovim configuration tutorials and tips
- 🎥 [Dreams of Code](https://www.youtube.com/@dreamsofcode) - For their comprehensive guides on setting up Neovim as a modern IDE

Thank you to these content creators for sharing their knowledge and helping the Neovim community! ✨

## 🤝 Contributing
Contributions are welcome! If you find any issues or have suggestions for improvements, please open an issue or submit a pull request.
