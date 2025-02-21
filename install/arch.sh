#!/bin/sh

SUDO_CMD="sudo"

install_packages() {
    # System packages
    SYSTEM_PACKAGES="git curl wget mc zsh ripgrep nodejs npm go rust tmux"

    echo -e "${BLUE}Installing system packages...${NC}"
    for package in $SYSTEM_PACKAGES; do
        if ! command -v "$package" >/dev/null 2>&1; then
            echo "Installing $package..."
            sudo pacman -Qi "$package" >/dev/null 2>&1 || sudo pacman -S --noconfirm "$package"
        else
            echo "$package already installed"
        fi
    done

    # Check Neovim version and reinstall if needed
    echo -e "${BLUE}Checking Neovim version...${NC}"
    if command -v nvim >/dev/null 2>&1; then
        current_version=$(nvim --version | head -n1 | cut -d ' ' -f2)
        required_version="0.10.0"
        if printf '%s\n' "$required_version" "$current_version" | sort -V -C; then
            echo "Neovim version $current_version is already up to date"
        else
            echo "Neovim version $current_version is outdated, reinstalling..."
            sudo pacman -R --noconfirm neovim
            sudo pacman -S --noconfirm neovim
        fi
    else
        echo "Neovim not found, installing..."
        sudo pacman -S --noconfirm neovim
    fi
}