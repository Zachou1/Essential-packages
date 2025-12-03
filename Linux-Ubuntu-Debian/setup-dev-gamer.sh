#!/bin/bash
set -e

check_and_install() {
    pkg=$1
    if dpkg -s "$pkg" >/dev/null 2>&1; then
        echo "$pkg is already installed."
        read -p "Do you want to update $pkg? (y/n): " choice
        if [ "$choice" = "y" ]; then
            sudo apt install --only-upgrade -y "$pkg"
        else
            echo "Skipping update for $pkg."
        fi
    else
        echo "Installing $pkg..."
        sudo apt install -y "$pkg"
    fi
}

echo "Updating package lists..."
sudo apt update

# Core developer tools
dev_tools=(
    curl wget git build-essential
    openjdk-17-jdk maven gradle
    python3 python3-pip
    nodejs npm
    docker.io docker-compose
    sqlite3 postgresql-client redis-tools
    vim nano neovim
    zsh htop tmux
    unzip zip tar
    gcc g++ make cmake clang
    libssl-dev net-tools ufw
)

# Extra developer stack
extra_dev=(
    kubectl minikube
    ansible
    virtualbox vagrant
    dotnet-sdk-6.0
)

# Gaming essentials
gaming_tools=(
    steam lutris
    wine winetricks
    gamemode mangohud
    obs-studio vlc ffmpeg
)

# Extras
extras=(
    jq tree ranger fzf bat exa
)

for pkg in "${dev_tools[@]}"; do check_and_install "$pkg"; done
for pkg in "${extra_dev[@]}"; do check_and_install "$pkg"; done
for pkg in "${gaming_tools[@]}"; do check_and_install "$pkg"; done
for pkg in "${extras[@]}"; do check_and_install "$pkg"; done

echo "Verifying installs..."
git --version
java -version
node -v
npm -v
python3 --version
docker --version
steam --version

echo "Full dev + gamer kit installed successfully."
