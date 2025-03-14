#!/bin/sh

# Color definitions
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

# Get project directory (where the script is located)
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

# Get the actual user when running with sudo
ACTUAL_USER=${SUDO_USER:-$USER}
ACTUAL_HOME=$(getent passwd "$ACTUAL_USER" | cut -d: -f6)

# Check if running as root when not in config mode
# Check if running as root
check_root() {
    if [ "$(id -u)" -ne 0 ]; then
        echo -e "${RED}This script must be run as root (use sudo)${NC}"
        exit 1
    fi
}

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
    if [ -n "$SUDO_USER" ]; then
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

        # Install Oh My Zsh as the actual user
        echo -e "${BLUE}Installing Oh My Zsh...${NC}"
        if [ ! -d "$ACTUAL_HOME/.oh-my-zsh" ]; then
            su - "$ACTUAL_USER" -c '
                rm -rf ~/.oh-my-zsh
                export RUNZSH=no
                export KEEP_ZSHRC=yes
                sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
            '
        fi

        chown -R "$ACTUAL_USER:$(id -gn $ACTUAL_USER)" "$ACTUAL_HOME/.oh-my-zsh"

        if [ "$SHELL" != "$(which zsh)" ]; then
            chsh -s "$(which zsh)" "$ACTUAL_USER"
        fi
    fi
}

setup_config_files() {
    echo -e "${BLUE}Setting up configuration files...${NC}"

    # Create required directories if they don't exist as symlinks
    [ ! -L "$ACTUAL_HOME/.config/nvim" ] && mkdir -p "$ACTUAL_HOME/.config/nvim"
    [ ! -L "$ACTUAL_HOME/.config/tmux" ] && su - "$ACTUAL_USER" -c "mkdir -p $ACTUAL_HOME/.config/tmux"

    # Make help scripts executable
    chmod +x "$SCRIPT_DIR/help/"*.sh

    # Add help aliases
    touch "$ACTUAL_HOME/.aliases"
    grep -q "# Help aliases" "$ACTUAL_HOME/.aliases" || cat >> "$ACTUAL_HOME/.aliases" << EOF

# Help aliases
alias ah='$SCRIPT_DIR/help/aliases-help.sh'
alias nh='$SCRIPT_DIR/help/nvim-help.sh'
alias th='$SCRIPT_DIR/help/tmux-help.sh'
EOF
}

setup_symlinks() {
    # Neovim config
    if [ -d "$ACTUAL_HOME/.config/nvim" ]; then
        mv "$ACTUAL_HOME/.config/nvim" "$ACTUAL_HOME/.config/nvim.backup-$(date +%Y%m%d-%H%M%S)"
    fi
    ln -sfn "$SCRIPT_DIR/configs/neovim" "$ACTUAL_HOME/.config/nvim"

    # Zsh config
    if [ -f "$ACTUAL_HOME/.zshrc" ]; then
        mv "$ACTUAL_HOME/.zshrc" "$ACTUAL_HOME/.zshrc.backup-$(date +%Y%m%d-%H%M%S)"
    fi
    ln -sf "$SCRIPT_DIR/configs/zsh/.zshrc" "$ACTUAL_HOME/.zshrc"

    # Tmux config
    su - "$ACTUAL_USER" -c "mkdir -p $ACTUAL_HOME/.config/tmux/plugins"
    if [ -f "$ACTUAL_HOME/.config/tmux/tmux.conf" ]; then
        mv "$ACTUAL_HOME/.config/tmux/tmux.conf" "$ACTUAL_HOME/.config/tmux/tmux.conf.backup-$(date +%Y%m%d-%H%M%S)"
    fi
    ln -sf "$SCRIPT_DIR/configs/tmux/tmux.conf" "$ACTUAL_HOME/.config/tmux/tmux.conf"

    # Install Tmux Plugin Manager
    if [ ! -d "$ACTUAL_HOME/.config/tmux/plugins/tpm" ]; then
        su - "$ACTUAL_USER" -c "git clone https://github.com/tmux-plugins/tpm $ACTUAL_HOME/.config/tmux/plugins/tpm"
    fi

    # Install Tmux plugins using sh instead of bash
    su - "$ACTUAL_USER" -c "TMUX_PLUGIN_MANAGER_PATH='$ACTUAL_HOME/.config/tmux/plugins/' \
    sh $ACTUAL_HOME/.config/tmux/plugins/tpm/scripts/install_plugins.sh" >/dev/null 2>&1
}

# Main installation
check_root

echo -e "${BLUE}Installing for $OS_TYPE...${NC}"
install_packages
install_common
setup_config_files
setup_symlinks

echo -e "${GREEN}Installation completed!${NC}"
