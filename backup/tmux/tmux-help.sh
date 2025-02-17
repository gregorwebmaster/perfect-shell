#!/bin/bash

# Definicja kodów kolorów
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo -e "${BLUE}### tmux Help ###${NC}"
echo
echo -e "${YELLOW}#### General ####${NC}"
echo

# General Section
echo -e "${GREEN}Prefix - Ctrl + Space | Sets Ctrl + Space as the tmux prefix key.${NC}"
echo -e "${GREEN}Prefix, r | Reloads the tmux configuration file.${NC}"
echo -e "${GREEN}Prefix, : | Enter into command line.${NC}"
echo
echo -e "${GREEN}Prefix, Ctrl + s | Saves the current sessions.${NC}"
echo -e "${GREEN}Prefix, Ctrl + r | Restores previously saved sessions.${NC}"
echo -e "${GREEN}Prefix, w | Shows a list of all sessions.${NC}"
echo

echo -e "${YELLOW}#### Windows ####${NC}"
echo

# Windows Section
echo -e "${GREEN}Prefix, c | Creates a new window.${NC}"
echo -e "${GREEN}Prefix, , | Rename a window.${NC}"
echo -e "${GREEN}Prefix,  | Creates a new window.${NC}"


echo -e "${GREEN}Shift+Alt+H | Switches to the previous window.${NC}"
echo -e "${GREEN}Shift+Alt+L | Switches to the next window.${NC}"
echo
echo -e "${GREEN}Prefix, f | find window by name.${NC}"
echo

echo -e "${YELLOW}#### Panes ####${NC}"
echo

# Panes Section
echo -e "${GREEN}Prefix, Arrow Keys | Navigates through panes.${NC}"
echo -e "${GREEN}Prefix, Alt + Arrow Keys | Resizes the current pane.${NC}"
echo -e "${GREEN}Prefix, { | Moves the pane to the left.${NC}"
echo -e "${GREEN}Prefix, } | Moves the pane to the right.${NC}"
echo -e "${GREEN}Prefix, q | Selects a pane by its number.${NC}"
echo -e "${GREEN}Prefix, z | Toggles 100% zoom view for the current pane.${NC}"
echo -e "${GREEN}Prefix, ! | Exits zoomed view to return to normal view.${NC}"
echo -e "${GREEN}Prefix, x | Kills (closes) the current pane.${NC}"
echo

echo -e "${YELLOW}#### Copy mode ####${NC}"
echo

# Copy mode
echo -e "${GREEN}Prefix, [ | Enter to copy mode.${NC}"
echo
echo -e "${GREEN}<in-copy-mode> / | Press / to start a forward search.${NC}"
echo -e "${GREEN}<in-copy-mode> ? | Press ? to start a backward search.${NC}"
echo -e "${GREEN}<in-copy-mode> n | Press n to go to the next search result.${NC}"
echo -e "${GREEN}<in-copy-mode> Shift+n | Press Shift+n to go to the previous search result.${NC}"
echo
echo -e "${GREEN}<in-copy-mode>  v,  | Begin selection.${NC}"
echo -e "${GREEN}<in-copy-mode>  Ctrl+v,  | Rectangle selection.${NC}"
echo -e "${GREEN}<in-copy-mode>  y,  | Copy selection and exit copy mode.${NC}"
echo

echo -e "${YELLOW}#### Additional Commands ####${NC}"
echo

# Additional Commands
echo -e "${CYAN}- \`tmux new-session -s session_name\`: Creates a new session named 'session_name'.${NC}"
echo -e "${CYAN}- \`tmux list-sessions\`: Lists all sessions.${NC}"
echo -e "${CYAN}- \`tmux attach-session -t session_name\`: Attaches to the session named 'session_name'.${NC}"
echo -e "${CYAN}- \`tmux kill-session -t session_name\`: Kills the session named 'session_name'.${NC}"

echo
echo -e "${BLUE}### End of Help ###${NC}"

