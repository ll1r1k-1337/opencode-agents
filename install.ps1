# PowerShell Installation Script for OpenCode Agents

$ErrorActionPreference = "Stop"

# Determine paths
$SourceDir = Join-Path $PSScriptRoot ".opencode"
$TargetDir = Join-Path $HOME ".config\opencode"

# Check if source exists
if (-not (Test-Path $SourceDir)) {
    Write-Error "Error: Source directory '$SourceDir' not found. Please run this script from the repository root."
}

# Create target directory if it doesn't exist
if (-not (Test-Path $TargetDir)) {
    Write-Host "Creating configuration directory at $TargetDir..."
    New-Item -ItemType Directory -Force -Path $TargetDir | Out-Null
} else {
    Write-Host "Configuration directory already exists at $TargetDir."
}

# Copy files
Write-Host "Installing agents to $TargetDir..."
Copy-Item -Path "$SourceDir\*" -Destination $TargetDir -Recurse -Force

# Update configuration if exists
$UpdateScript = Join-Path $TargetDir "scripts\update_config.py"
$AgentsDir = Join-Path $TargetDir "agents"
$ConfigFiles = @("openconfig.json", "opencode.json")

if (Test-Path $UpdateScript) {
    foreach ($ConfigFile in $ConfigFiles) {
        $ConfigPath = Join-Path $TargetDir $ConfigFile
        if (Test-Path $ConfigPath) {
            Write-Host "Found configuration file: $ConfigPath"

            if (Get-Command python -ErrorAction SilentlyContinue) {
                Write-Host "Updating configuration..."
                python "$UpdateScript" "$ConfigPath" "$AgentsDir"
            } elseif (Get-Command python3 -ErrorAction SilentlyContinue) {
                Write-Host "Updating configuration..."
                python3 "$UpdateScript" "$ConfigPath" "$AgentsDir"
            } else {
                Write-Host "Warning: Python not found. Skipping configuration update for $ConfigFile." -ForegroundColor Yellow
            }
        }
    }
} else {
    Write-Host "Warning: Update script not found at $UpdateScript. Skipping configuration update." -ForegroundColor Yellow
}

Write-Host "Installation complete! You can now control your agents in $TargetDir." -ForegroundColor Green
