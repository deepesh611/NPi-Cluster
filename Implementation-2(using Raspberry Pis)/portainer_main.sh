#!/bin/bash

# Colors
GREEN='\033[1;32m'
RED='\033[1;31m'
BLUE='\033[1;34m'
NC='\033[0m'

# Define Portainer volume and container name
PORTAINER_VOLUME="portainer_data"
PORTAINER_CONTAINER="portainer"

# Function to print and exit on error
exit_on_error() {
    echo -e "${RED}❌ Error: $1${NC}"
    exit 1
}

# Create Docker volume for Portainer
echo -e "${BLUE}📦 Creating Docker volume...${NC}"
docker volume create $PORTAINER_VOLUME || exit_on_error "Failed to create Docker volume."

# Run Portainer container
echo -e "${BLUE}🚀 Starting Portainer container...${NC}"

docker run -d \
  -p 8000:8000 -p 9000:9000 \
  --name=$PORTAINER_CONTAINER \
  --restart=always \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v $PORTAINER_VOLUME:/data \
  portainer/portainer-ce:linux-arm \
  || exit_on_error "Failed to run Portainer container."

# Confirm success
echo -e "${GREEN}✅ Portainer has been set up successfully on ports 9000 (UI) and 8000 (agent).${NC}"
