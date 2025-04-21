#!/bin/bash

set -e
echo ""
echo "🚀 Starting environment setup..."

echo ""
echo "🔄 Updating and upgrading system packages..."
sudo apt-get update -y || { echo "❌ Failed to update packages"; exit 1; }
sudo apt-get upgrade -y || { echo "❌ Failed to upgrade packages"; exit 1; }

echo ""
echo "🐍 Checking for Python and venv..."
sudo apt-get install -y python3 || { echo "❌ Failed to install Python3"; exit 1; }
sudo apt install -y python3-venv || { echo "❌ Failed to install python3-venv"; exit 1; }

echo ""
echo "📁 Creating virtual environment in 'venv/'..."
python3 -m venv venv || { echo "❌ Failed to create virtual environment"; exit 1; }

echo "📦 Installing Python packages from requirements.txt..."
source venv/bin/activate
if [ ! -f requirements.txt ]; then
  echo "❌ requirements.txt not found!"
  exit 1
fi

pip install --upgrade pip
pip install -r requirements.txt || { echo "❌ Failed to install packages"; exit 1; }

echo "✅ Setup complete. Virtual environment ready."
echo "👉 To activate it later: source venv/bin/activate"
