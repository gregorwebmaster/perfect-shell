#!/bin/sh

install_packages() {
    # System packages
    SYSTEM_PACKAGES="git curl wget mc zsh ripgrep nodejs npm go rust tmux"

    echo -e "${BLUE}Installing system packages...${NC}"
    # Full system upgrade
    # Update and install base packages
    pacman -Syu --noconfirm
    pacman -S --noconfirm zsh zsh-completions
    
    for package in $SYSTEM_PACKAGES; do
        if ! command -v "$package" >/dev/null 2>&1; then
            echo "Installing $package..."
            pacman -Qi "$package" >/dev/null 2>&1 || pacman -S --noconfirm "$package"
        else
            echo "$package already installed"
        fi
    done

    # Reinstall npm globally
    npm install -g npm@latest

    # Check Neovim version and reinstall if needed
    echo -e "${BLUE}Checking Neovim version...${NC}"
    if command -v nvim >/dev/null 2>&1; then
        current_version=$(nvim --version | head -n1 | cut -d ' ' -f2)
        required_version="0.10.0"
        if printf '%s\n' "$required_version" "$current_version" | sort -V -C; then
            echo "Neovim version $current_version is already up to date"
        else
            echo "Neovim version $current_version is outdated, reinstalling..."
            pacman -R --noconfirm neovim
            pacman -S --noconfirm neovim
        fi
    else
        echo "Neovim not found, installing..."
        pacman -S --noconfirm neovim
    fi
}