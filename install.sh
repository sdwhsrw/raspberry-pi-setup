#!/bin/bash
# Raspberry Pi 5 Standard Setup Script
# Based on README.md requirements

# Array to keep track of failed installations
FAILED_INSTALLS=()

# Helper function to run a command and track success/failure
install_step() {
    local step_name="$1"
    echo "====================================================="
    echo "Installing/Running: $step_name..."
    echo "====================================================="
    shift # Remove the first argument so the rest is the command
    
    # Run the command
    if "$@"; then
        echo "--> SUCCESS: $step_name"
    else
        echo "--> FAILED:  $step_name"
        FAILED_INSTALLS+=("$step_name")
    fi
    echo ""
}

echo "Starting Raspberry Pi 5 Setup..."
echo ""

# 1. Update and upgrade system
install_step "System Update & Upgrade" bash -c 'sudo apt update && sudo apt upgrade -y'

# 2. Install apt packages: build-essential, tealdeer (tldr), git, cmake, vim
install_step "Standard apt packages" sudo apt install -y build-essential tealdeer git cmake vim

# Update tldr pages (tealdeer provides tldr)
install_step "Update tldr pages" tldr --update

# 3. Install NVM (Node Version Manager)
# Using set -eo pipefail ensures that if curl fails, the whole command fails
install_step "NVM (Node Version Manager)" bash -c 'set -eo pipefail; curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash'

# Source nvm so it's available in the current session for subsequent commands
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# 4. Install Docker & Docker Compose via apt
install_step "Docker & Docker Compose" sudo apt install -y docker.io docker-compose

# Add the current user to the docker group so you don't need sudo for docker commands
install_step "Add user to docker group" sudo usermod -aG docker $USER

# 5. Install Tailscale
install_step "Tailscale" bash -c 'set -eo pipefail; curl -fsSL https://tailscale.com/install.sh | sh'

# 6. Install Antigravity CLI
install_step "Antigravity CLI" bash -c 'set -eo pipefail; curl -fsSL https://antigravity.google/cli/install.sh | bash'

# 7. Install CodeX CLI
install_step "CodeX CLI" bash -c 'set -eo pipefail; curl -fsSL https://chatgpt.com/codex/install.sh | sh'

echo "====================================================="
echo "Setup process completed!"

# Check if there were any failures
if [ ${#FAILED_INSTALLS[@]} -eq 0 ]; then
    echo "🎉 All installations were SUCCESSFUL!"
else
    echo "⚠️  WARNING: The following steps FAILED:"
    for fail in "${FAILED_INSTALLS[@]}"; do
        echo "  - $fail"
    done
    echo "Please check the logs above to see what went wrong."
fi

echo "====================================================="
echo "NOTE: Please restart your terminal or log out and log back in"
echo "for group changes (like Docker) and PATH changes (like NVM) to take effect."
echo "====================================================="
