#!/bin/bash

# Colors
GREEN='\033[1;32m'
RED='\033[1;31m'
BLUE='\033[1;34m'
NC='\033[0m'

# Function to print and exit on error
exit_on_error() {
    echo -e "${RED}❌ Error: $1${NC}"
    exit 1
}

# Run Portainer container
echo -e "${BLUE}🚀 Starting Portainer container...${NC}"

docker run -d \
  --name portainer_agent \
  --restart=always \
  -p 9001:9001 \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /var/lib/docker/volumes:/var/lib/docker/volumes \
  portainer/agent \
  || exit_on_error "Failed to run Portainer container."

# Confirm success
echo -e "${GREEN}✅ Portainer Agent has been set up successfully on port 9001.${NC}"
