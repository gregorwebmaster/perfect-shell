# Makefile for installing dependencies on Linux and macOS

# Package managers
NPM = $(shell which npm)
GO = $(shell which go)
CARGO = $(shell which cargo)
APT = $(shell which apt-get)
BREW = $(shell which brew)

# Check if a command exists
define command_exists
	command -v $(1) >/dev/null 2>&1
endef

# Install commands
install_npm_package = \
	npm list -g --depth=0 | grep $(1) || sudo npm install -g $(1)

install_go_package = \
	go list $(1) >/dev/null 2>&1 || sudo go install $(1)@latest

install_cargo_package = \
	cargo install --list | grep $(1) || cargo install $(1)

install_apt_package = \
	dpkg -l | grep $(1) || sudo apt-get install -y $(1)

install_brew_package = \
	brew list $(1) >/dev/null 2>&1 || brew install $(1)

# Packages to install
NPM_PACKAGES = \
	intelephense \
	pyright \
	bash-language-server \
	typescript-language-server \
	vscode-langservers-extracted

GO_PACKAGES = \
	golang.org/x/tools/gopls

# Targets
all: install

install: install_tools install_npm install_go install_ripgrep

install_tools:
	@echo "\033[1;34mRoot privileges are required to install some packages.\033[0m"
	@if ! $(call command_exists,npm); then \
		if $(call command_exists,apt-get); then \
			echo "\033[1;33mInstalling Node.js and npm...\033[0m"; \
			sudo apt-get update && sudo apt-get install -y nodejs npm; \
		elif $(call command_exists,brew); then \
			echo "\033[1;33mInstalling Node.js via Homebrew...\033[0m"; \
			brew install node; \
		else \
			echo "No suitable package manager found to install npm. Please install manually."; \
		fi \
	fi

	@if ! $(call command_exists,go); then \
		if $(call command_exists,apt-get); then \
			echo "\033[1;33mInstalling Go...\033[0m"; \
			sudo apt-get update && sudo apt-get install -y go; \
		elif $(call command_exists,brew); then \
			echo "\033[1;33mInstalling Go via Homebrew...\033[0m"; \
			brew install go; \
		else \
			echo "No suitable package manager found to install Go. Please install manually."; \
		fi \
	fi

	@if ! $(call command_exists,cargo); then \
		if $(call command_exists,apt-get); then \
			echo "\033[1;33mInstalling Rust and Cargo using rustup...\033[0m"; \
			curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y; \
			export PATH="$HOME/.cargo/bin:$PATH"; \
		elif $(call command_exists,brew); then \
			echo "\033[1;33mInstalling Rust and Cargo via Homebrew...\033[0m"; \
			brew install rust; \
		else \
			echo "No suitable package manager found to install Cargo. Please install manually."; \
		fi \
	fi

install_npm:
	@echo "\033[1;32mInstalling npm packages...\033[0m"
	$(foreach package,$(NPM_PACKAGES),\
		$(call install_npm_package,$(package));)
	@echo "\033[1;32mNPM packages installed.\033[0m"

install_go:
	@echo "\033[1;32mInstalling Go packages...\033[0m"
	$(foreach package,$(GO_PACKAGES),\
		$(call install_go_package,$(package));)
	@echo "\033[1;32mGo packages installed.\033[0m"

install_ripgrep:
	@echo "\033[1;32mInstalling ripgrep...\033[0m"
	@if $(call command_exists,apt-get); then \
		$(call install_apt_package,ripgrep); \
	elif $(call command_exists,brew); then \
		$(call install_brew_package,ripgrep); \
	elif $(call command_exists,cargo); then \
		$(call install_cargo_package,ripgrep); \
	else \
		echo "No suitable package manager found for ripgrep. Please install manually."; \
	fi
	@echo "\033[1;32mRipgrep installed.\033[0m"

.PHONY: all install install_tools install_npm install_go install_ripgrep

