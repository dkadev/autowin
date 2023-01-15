Write-Host "Installing Chocolatey..." -ForegroundColor "Yellow"
Invoke-WebRequest -useb chocolatey.org/install.ps1 | Invoke-Expression
# Write-Host "Installing Chocolatey packages..." -ForegroundColor "Yellow"
# chocolatey
# choco install microsoft-windows-terminal
# choco install nordvpn
# choco install authy-desktop
# choco install freefilesync
# choco install virtualbox