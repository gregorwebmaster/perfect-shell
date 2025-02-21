#!/bin/sh

# Define color codes
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo -e "${BLUE}### Neovim Help ###${NC}"
echo

echo -e "${YELLOW}#### Default Shortcuts ####${NC}"
echo

# Default Neovim Shortcuts
echo -e "${GREEN}:w | Save the current file${NC}"
echo -e "${GREEN}:q | Quit Neovim${NC}"
echo -e "${GREEN}:wq | Save and quit${NC}"
echo -e "${GREEN}:wqa | Save all and quit Neovim${NC}"
echo -e "${GREEN}:e filename | Edit a specific file${NC}"
echo -e "${GREEN}:split | Split the window horizontally${NC}"
echo -e "${GREEN}:vsplit | Split the window vertically${NC}"
echo -e "${GREEN}Ctrl; w; h/j/k/l | Navigate between split windows${NC}"
echo -e "${GREEN}dd | Delete the current line${NC}"
echo -e "${GREEN}yy | Yank (copy) the current line${NC}"
echo -e "${GREEN}p | Paste after the cursor${NC}"
echo -e "${GREEN}u | Undo the last action${NC}"
echo -e "${GREEN}Ctrl; r | Redo the last undone action${NC}"
echo

echo -e "${YELLOW}#### Plugin Shortcuts ####${NC}"
echo

# Telescope Plugin Shortcuts
echo -e "${CYAN}##### Telescope #####${NC}"
echo -e "${GREEN}<Leader>; ff | Find files using Telescope${NC}"
echo -e "${GREEN}<Leader>; fg | Live grep using Telescope${NC}"
echo
# You can add more Telescope shortcuts here if defined

# Neo-tree Plugin Shortcuts
echo -e "${CYAN}##### Neo-tree #####${NC}"
echo -e "${GREEN}<Leader>; n | Reveal the filesystem in Neo-tree on the left${NC}"
echo -e "${GREEN}<Leader>; g | Open Neo-tree in a floating window showing git status${NC}"
echo -e "${GREEN} a | Create a new file${NC}"
echo -e "${GREEN} c | Copy file/directory${NC}"
echo -e "${GREEN} d | Delete file/directory${NC}"
echo

echo -e "${BLUE}### End of Help ###${NC}"

