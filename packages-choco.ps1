# chocolatey

Write-Host "Installing Chocolatey..." -ForegroundColor "Yellow"
Invoke-WebRequest -useb chocolatey.org/install.ps1 | Invoke-Expression