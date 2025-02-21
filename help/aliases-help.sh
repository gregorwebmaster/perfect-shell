#!/bin/sh

# Definicja kodów kolorów
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo -e "${BLUE}### Zsh Aliases Help ###${NC}"
echo

echo -e "${YELLOW}#### Git Aliases ####${NC}"
echo

# Sekcja Git
echo -e "${GREEN}gst | git status${NC}"
echo -e "${GREEN}gco | git checkout${NC}"
echo -e "${GREEN}gcm | git commit -m 'message'${NC}"
echo -e "${GREEN}gpl | git pull${NC}"
echo -e "${GREEN}gps | git push${NC}"
echo -e "${GREEN}gaa | git add --all${NC}"
echo -e "${GREEN}gbr | git branch${NC}"
echo -e "${GREEN}glo | git log --oneline${NC}"
echo
echo

echo -e "${YELLOW}#### Docker Aliases ####${NC}"
echo

# Sekcja Docker
echo -e "${GREEN}dps | docker ps${NC}"
echo -e "${GREEN}dpsa | docker ps -a${NC}"
echo -e "${GREEN}dib | docker images${NC}"
echo -e "${GREEN}dtc | docker container${NC}"
echo -e "${GREEN}dti | docker image${NC}"
echo -e "${GREEN}drm | docker rm${NC}"
echo -e "${GREEN}dri | docker rmi${NC}"
echo -e "${GREEN}dst | docker stop${NC}"
echo -e "${GREEN}dbuild | docker build -t your_tag .${NC}"
echo -e "${GREEN}dexec | docker exec -it container_name bash${NC}"
echo
echo

echo -e "${YELLOW}#### Docker Compose Aliases ####${NC}"
echo

# Sekcja Docker Compose
echo -e "${GREEN}dcup | docker-compose up${NC}"
echo -e "${GREEN}dcd | docker-compose down${NC}"
echo -e "${GREEN}dcl | docker-compose logs${NC}"
echo -e "${GREEN}dcb | docker-compose build${NC}"
echo -e "${GREEN}dcr | docker-compose run${NC}"
echo -e "${GREEN}dcp | docker-compose pull${NC}"
echo -e "${GREEN}dcu | docker-compose up -d${NC}"
echo -e "${GREEN}dcs | docker-compose stop${NC}"
echo -e "${GREEN}dcrestart | docker-compose restart${NC}"
echo -e "${GREEN}dcps | docker-compose ps${NC}"
echo
echo

echo -e "${YELLOW}#### Symfony Aliases ####${NC}"
echo

# Sekcja Symfony
echo -e "${GREEN}sfcc | symfony console cache:clear${NC}"
echo -e "${GREEN}sfr | symfony console cache:remove${NC}"
echo -e "${GREEN}sft | symfony server:start${NC}"
echo -e "${GREEN}sfs | symfony server:stop${NC}"
echo -e "${GREEN}sfcr | symfony console cache:restart${NC}"
echo -e "${GREEN}sfg | symfony console debug:router${NC}"
echo -e "${GREEN}sfd | symfony console debug:container${NC}"
echo -e "${GREEN}sftd | symfony console debug:twig${NC}"
echo -e "${GREEN}sfmigrate | symfony console doctrine:migrations:migrate${NC}"
echo -e "${GREEN}sform | symfony console make:form${NC}"
echo
echo

echo -e "${BLUE}### End of Aliases Help ###${NC}"

