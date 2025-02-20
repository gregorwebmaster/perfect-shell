#!/bin/sh

# Color definitions
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

# System packages
SYSTEM_PACKAGES="git curl wget mc zsh ripgrep node go rust tmux neovim"

echo -e "${BLUE}Installing system packages...${NC}"
for package in $SYSTEM_PACKAGES; do
    if ! command -v "$package" >/dev/null 2>&1; then
        echo "Installing $package..."
        brew list "$package" >/dev/null 2>&1 || brew install "$package"
    else
        echo "$package already installed"
    fi
done

# NPM packages
echo -e "${BLUE}Installing npm packages...${NC}"
NPM_PACKAGES="intelephense pyright bash-language-server typescript-language-server vscode-langservers-extracted"
for package in $NPM_PACKAGES; do
    npm list -g --depth=0 | grep -q "$package" || npm install -g "$package"
done

# Go packages
echo -e "${BLUE}Installing Go packages...${NC}"
GO_PACKAGES="golang.org/x/tools/gopls@latest"
for package in $GO_PACKAGES; do
    go install "$package"
done

# Install Oh My Zsh
echo -e "${BLUE}Installing Oh My Zsh...${NC}"
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

if [ "$SHELL" != "$(which zsh)" ]; then
    chsh -s "$(which zsh)"
fi

# Setup config files
echo -e "${BLUE}Setting up configuration files...${NC}"
mkdir -p "$HOME/.config/tmux"

# Save config files to a temporary file
cat > /tmp/config_files << EOF
nvim:$HOME/.config/nvim
zsh:$HOME/.zshrc
tmux:$HOME/.config/tmux/tmux.conf
EOF

while IFS=: read -r src dst; do
    [ -z "$src" ] && continue
    dst=$(eval echo "$dst")
    if [ -e "$dst" ]; then
        echo "Backing up $dst to $dst.backup"
        mv "$dst" "$dst.backup"
    fi
    echo "Creating symlink for $src"
    ln -sf "$(pwd)/config/$src" "$dst"
done < /tmp/config_files

rm -f /tmp/config_files

echo -e "${GREEN}Installation completed!${NC}"