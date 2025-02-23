#!/bin/sh

# Color definitions
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

# Test environments
ENVIRONMENTS="alpine debian arch ubuntu kali manjaro"

# Build and run tests for each environment
for env in $ENVIRONMENTS; do
    echo -e "${BLUE}Testing on $env...${NC}"
    
    # Build container
    docker build -t neovim-test-$env -f tests/docker/Dockerfile.$env .
    
    # Run tests
    if docker run --rm neovim-test-$env; then
        echo -e "${GREEN}✓ Tests passed on $env${NC}"
    else
        echo -e "${RED}✗ Tests failed on $env${NC}"
    fi
    
    echo
done