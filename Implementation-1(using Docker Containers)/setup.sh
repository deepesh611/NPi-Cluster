#!/bin/bash

set -e
echo "🔧 Starting NPi-Cluster setup..."


# Check for root/sudo
if [ "$EUID" -ne 0 ]; then
  echo "❌ Please run this script as root or with sudo."
  exit 1
fi


echo "📦 Installing Docker..."

if ! command -v docker &> /dev/null
then
  apt-get update
  apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release

  curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
    $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

  apt-get update
  apt-get install -y docker-ce docker-ce-cli containerd.io
else
  echo "✅ Docker is already installed."
fi


echo "📦 Installing Docker Compose..."

if ! command -v docker-compose &> /dev/null
then
  curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  chmod +x /usr/local/bin/docker-compose
else
  echo "✅ Docker Compose is already installed."
fi



if ! groups $SUDO_USER | grep -q '\bdocker\b'; then
  echo "👤 Adding user '$SUDO_USER' to the docker group..."
  usermod -aG docker $SUDO_USER
  echo "⚠️ You must log out and log back in for group changes to apply."
fi



echo "🏗️ Building Docker containers..."
docker-compose build || { echo "❌ Docker build failed"; exit 1; }



echo "🚀 Starting the first NPi-Cluster node..."
docker-compose up -d node1 || { echo "❌ Failed to start node1"; exit 1; }


echo "🎉 Setup complete!"
echo "🔁 You can now run: python3 manager.py"

