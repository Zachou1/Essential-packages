function Check-And-Install($pkg) {
    $installed = choco list --local-only | Select-String $pkg
    if ($installed) {
        Write-Host "$pkg is already installed."
        $choice = Read-Host "Do you want to update $pkg? (y/n)"
        if ($choice -eq "y") {
            choco upgrade $pkg -y
        } else {
            Write-Host "Skipping update for $pkg."
        }
    } else {
        Write-Host "Installing $pkg..."
        choco install $pkg -y
    }
}

Write-Host "Checking and installing essentials..."

# Developer tools
$devTools = @("git","nodejs-lts","openjdk","maven","gradle","python","docker-desktop","vscode","cmake","dotnet-sdk","virtualbox","vagrant","ansible","kubernetes-cli","minikube")
foreach ($pkg in $devTools) { Check-And-Install $pkg }

# Databases
$dbTools = @("postgresql","sqlite","redis")
foreach ($pkg in $dbTools) { Check-And-Install $pkg }

# Gaming essentials
$gaming = @("steam","lutris","obs-studio","vlc","ffmpeg","gamemode","mangohud","wine")
foreach ($pkg in $gaming) { Check-And-Install $pkg }

# Utilities
$utils = @("7zip","curl","wget","neovim","vim","htop","jq","fzf","bat","exa")
foreach ($pkg in $utils) { Check-And-Install $pkg }

Write-Host "Full dev + gamer kit installed successfully."
