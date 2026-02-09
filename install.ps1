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

Write-Host "Installation complete! You can now control your agents in $TargetDir." -ForegroundColor Green
