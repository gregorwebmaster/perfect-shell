#!/bin/sh

install_packages() {
    echo -e "${BLUE}Installing system packages...${NC}"

    # Set environment variables for non-interactive installation
    export DEBIAN_FRONTEND=noninteractive
    export TERM=xterm
    export GOPATH=$HOME/gov
    export PATH=$PATH:$GOPATH/bin

    # Create Go workspace directory
    mkdir -p $GOPATH/bin

    # Update and install essential packages first
    apt-get update
    apt-get install -y libdb5.3 libpython3.11-stdlib libperl5.36 libpam-modules
    apt-get install -y libcurl4 libcurl3-gnutls libappstream4
    apt-get install -y --reinstall readline-common libreadline8
    apt-get install -y curl git zsh apt-utils software-properties-common libterm-readline-perl-perl zsh-common

    # Add Node.js repository and install Node.js
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
    apt-get install -y nodejs

    # Install Neovim from source
    # Install Neovim dependencies and build tools
    apt-get install -y ninja-build gettext cmake unzip pkg-config libtool-bin g++ automake

    # Clone and build Neovim with proper permissions
    git clone https://github.com/neovim/neovim
    cd neovim
    git checkout stable
    # Ensure proper permissions for build directory
    chown -R $(whoami):$(id -gn) .
    chmod -R 755 .
    make CMAKE_BUILD_TYPE=Release -j$(nproc)
    make install
    cd ..
    rm -rf neovim

    # Install Go 1.22
    wget https://go.dev/dl/go1.22.0.linux-amd64.tar.gz
    rm -rf /usr/local/go
    tar -C /usr/local -xzf go1.22.0.linux-amd64.tar.gz
    rm go1.22.0.linux-amd64.tar.gz
    
    # Add Go to system-wide PATH
    echo 'export PATH=$PATH:/usr/local/go/bin' >> /etc/profile
    echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
    echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.zshrc
    export PATH=$PATH:/usr/local/go/bin
    
    # Verify Go installation
    source /etc/profile
    go version

    # System packages for later installation
    SYSTEM_PACKAGES="wget mc ripgrep rustc cargo tmux"

    # Install remaining packages
    for package in $SYSTEM_PACKAGES; do
        if ! command -v "$package" >/dev/null 2>&1; then
            echo "Installing $package..."
            dpkg -l | grep -q "$package" || DEBIAN_FRONTEND=noninteractive apt-get install -y "$package"
        else
            echo "$package already installed"
        fi
    done

    # Cleanup
    apt-get autoremove -y
}