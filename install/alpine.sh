#!/bin/sh


install_packages() {
    # System packages
    SYSTEM_PACKAGES="git curl wget bash zsh ripgrep nodejs npm go rust tmux mc htop"

    echo -e "${BLUE}Installing system packages...${NC}"
    # Update and install base packages
    apk update
    for package in $SYSTEM_PACKAGES; do
        if ! command -v "$package" >/dev/null 2>&1; then
            echo "Installing $package..."
            apk info -e "$package" >/dev/null 2>&1 || apk add "$package"
        else
            echo "$package already installed"
        fi
    done

    # Check Neovim version and reinstall if needed
    echo -e "${BLUE}Checking Neovim version...${NC}"
    if command -v nvim >/dev/null 2>&1; then
        current_version=$(nvim --version | head -n1 | cut -d ' ' -f2)
        required_version="0.10"
        if printf '%s\n' "$required_version" "$current_version" | sort -V -C; then
            echo "Neovim version $current_version is already up to date"
        else
            echo "Neovim version $current_version is outdated, reinstalling..."
            apk del neovim
            apk add -X https://dl-cdn.alpinelinux.org/alpine/edge/main libuv
            apk add -X https://dl-cdn.alpinelinux.org/alpine/edge/community neovim
        fi
    else
        echo "Neovim not found, installing..."
        apk add -X https://dl-cdn.alpinelinux.org/alpine/edge/main libuv
        apk add -X https://dl-cdn.alpinelinux.org/alpine/edge/community neovim
    fi
}