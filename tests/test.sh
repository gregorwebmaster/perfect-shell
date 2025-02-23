#!/bin/sh

# Color definitions
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

# Test results counter
PASSED=0
FAILED=0

# Test function
run_test() {
    local test_name=$1
    local test_command=$2
    
    echo -e "${BLUE}Testing: ${test_name}...${NC}"
    if eval "$test_command"; then
        echo -e "${GREEN}✓ Passed${NC}"
        PASSED=$((PASSED + 1))
    else
        echo -e "${RED}✗ Failed${NC}"
        FAILED=$((FAILED + 1))
    fi
    echo
}

# System tests
run_test "Neovim installation" "command -v nvim"
run_test "Neovim version" "nvim --version | grep -q '0.10'"
run_test "Neovim config directory" "[ -d ~/.config/nvim ]"
run_test "Tmux installation" "command -v tmux"
run_test "Tmux config" "[ -f ~/.config/tmux/tmux.conf ]"
run_test "Zsh installation" "command -v zsh"
run_test "Oh My Zsh installation" "[ -d ~/.oh-my-zsh ]"
run_test "Help scripts permissions" "[ -x ./help/aliases-help.sh ] && [ -x ./help/nvim-help.sh ] && [ -x ./help/tmux-help.sh ]"

# Language servers tests
run_test "Node.js installation" "command -v node"
run_test "NPM installation" "command -v npm"
run_test "Go installation" "command -v go"
run_test "Intelephense installation" "npm list -g | grep -q intelephense"
run_test "Pyright installation" "npm list -g | grep -q pyright"
run_test "Gopls installation" "[ -f ~/go/bin/gopls ]"

# Configuration tests
run_test "Aliases file" "grep -q 'Help aliases' ~/.aliases"
run_test "Zsh config symlink" "[ -L ~/.zshrc ]"
run_test "Neovim config symlink" "[ -L ~/.config/nvim ]"
run_test "Tmux config symlink" "[ -L ~/.config/tmux/tmux.conf ]"

# Print summary
echo -e "\n${BLUE}Test Summary:${NC}"
echo -e "${GREEN}Passed: ${PASSED}${NC}"
echo -e "${RED}Failed: ${FAILED}${NC}"

# Exit with status code based on test results
[ $FAILED -eq 0 ]