#!/bin/bash

# Configuration
CONFIG_DIR="$HOME/.config/opencode"
SOURCE_DIR=".opencode"

# Ensure source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Error: Source directory '$SOURCE_DIR' not found. Please run this script from the repository root."
    exit 1
fi

# Create config directory if it doesn't exist
if [ ! -d "$CONFIG_DIR" ]; then
    echo "Creating configuration directory at $CONFIG_DIR..."
    mkdir -p "$CONFIG_DIR"
else
    echo "Configuration directory already exists at $CONFIG_DIR."
fi

# Copy contents
echo "Installing agents to $CONFIG_DIR..."
cp -r "$SOURCE_DIR/"* "$CONFIG_DIR/"

echo "Installation complete! You can now control your agents in $CONFIG_DIR."
