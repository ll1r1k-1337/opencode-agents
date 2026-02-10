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

# Update configuration if exists
UPDATE_SCRIPT="$CONFIG_DIR/scripts/update_config.py"
AGENTS_DIR="$CONFIG_DIR/agents"
CONFIG_FILES=("openconfig.json" "opencode.json")

# Create config file if none exists
config_exists=false
for config_file in "${CONFIG_FILES[@]}"; do
    if [ -f "$CONFIG_DIR/$config_file" ]; then
        config_exists=true
        break
    fi
done

if [ "$config_exists" = false ]; then
    echo "No configuration file found. Creating default openconfig.json..."
    echo "{}" > "$CONFIG_DIR/openconfig.json"
fi

if [ -f "$UPDATE_SCRIPT" ]; then
    for config_file in "${CONFIG_FILES[@]}"; do
        config_path="$CONFIG_DIR/$config_file"
        if [ -f "$config_path" ]; then
            echo "Found configuration file: $config_path"
            if command -v python3 &> /dev/null; then
                echo "Updating configuration..."
                python3 "$UPDATE_SCRIPT" "$config_path" "$AGENTS_DIR"
            elif command -v python &> /dev/null; then
                echo "Updating configuration..."
                python "$UPDATE_SCRIPT" "$config_path" "$AGENTS_DIR"
            else
                echo "Warning: Python not found. Skipping configuration update for $config_file."
            fi
        fi
    done
else
    echo "Warning: Update script not found at $UPDATE_SCRIPT. Skipping configuration update."
fi

echo "Installation complete! You can now control your agents in $CONFIG_DIR."
