#!/bin/sh

# Color definitions
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

# Get project directory (where the script is located)
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

# Detect OS
detect_os() {
    if [ "$(uname)" = "Darwin" ]; then
        echo "macos"
    elif [ -f "/etc/alpine-release" ]; then
        echo "alpine"
    elif [ -f "/etc/debian_version" ]; then
        echo "debian"
    elif [ -f "/etc/arch-release" ]; then
        echo "arch"
    else
        echo -e "${RED}Unable to detect your operating system.${NC}"
        echo -e "${RED}This installer currently supports:${NC}"
        echo -e "${BLUE}- macOS${NC}"
        echo -e "${BLUE}- Alpine Linux${NC}"
        echo -e "${BLUE}- Debian/Ubuntu${NC}"
        echo -e "${BLUE}- Arch Linux${NC}"
        echo -e "${RED}Please contact the project author for support: ${NC}"
        echo -e "${BLUE} https://github.com/gregorwebmaster/perfect-shell ${NC}"
        exit 1
    fi
}

# Source OS-specific installation functions
OS_TYPE=$(detect_os)
if [ -f "$SCRIPT_DIR/install/$OS_TYPE.sh" ]; then
    . "$SCRIPT_DIR/install/$OS_TYPE.sh"
else
    echo -e "${RED}Unsupported operating system${NC}"
    exit 1
fi

# Common installation steps
install_common() {
    # NPM packages
    echo -e "${BLUE}Installing npm packages...${NC}"
    NPM_PACKAGES="intelephense pyright bash-language-server typescript-language-server vscode-langservers-extracted"
    for package in $NPM_PACKAGES; do
        npm list -g --depth=0 | grep -q "$package" || $SUDO_CMD npm install -g "$package"
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

    # Setup directories and configs
    setup_config_files
}

setup_config_files() {
    echo -e "${BLUE}Setting up configuration files...${NC}"

    # Create required directories
    mkdir -p "$HOME/.config/nvim"
    mkdir -p "$HOME/.config/tmux"

    # Make help scripts executable
    chmod +x "$SCRIPT_DIR/help/"*.sh

    # Add help aliases
    touch "$HOME/.aliases"
    grep -q "# Help aliases" "$HOME/.aliases" || cat >> "$HOME/.aliases" << EOF

# Help aliases
alias ah='$SCRIPT_DIR/help/aliases-help.sh'
alias nh='$SCRIPT_DIR/help/nvim-help.sh'
alias th='$SCRIPT_DIR/help/tmux-help.sh'
EOF

    # Create symlinks
    setup_symlinks
}

setup_symlinks() {
    # Neovim config
    if [ -d "$HOME/.config/nvim" ]; then
        rm -rf "$HOME/.config/nvim"
    fi
    ln -sfn "$SCRIPT_DIR/configs/neovim" "$HOME/.config/nvim"

    # Zsh config
    if [ -f "$HOME/.zshrc" ]; then
        mv "$HOME/.zshrc" "$HOME/.zshrc.backup"
    fi
    ln -sf "$SCRIPT_DIR/configs/zsh/.zshrc" "$HOME/.zshrc"

    # Tmux config
    if [ -f "$HOME/.config/tmux/tmux.conf" ]; then
        mv "$HOME/.config/tmux/tmux.conf" "$HOME/.config/tmux/tmux.conf.backup"
    fi
    ln -sf "$SCRIPT_DIR/configs/tmux/tmux.conf" "$HOME/.config/tmux/tmux.conf"
}

# Main installation
echo -e "${BLUE}Installing for $OS_TYPE...${NC}"
install_packages
install_common
echo -e "${GREEN}Installation completed!${NC}"
