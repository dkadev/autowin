Write-Host "Installing Winget packages..." -ForegroundColor "Yellow"

# BASICS
winget install --id=7zip.7zip -e
winget install --id=Git.Git -e
winget install --id=Microsoft.WindowsTerminal -e
winget install --id=VideoLAN.VLC -e

# PASSWORD MANAGER
winget install --id=KeePassXCTeam.KeePassXC  -e

# EDITOR  
# winget install --id=Microsoft.VisualStudioCode -e
winget install --id=VSCodium.VSCodium -e

# SECURITY
winget install --id=GnuPG.Gpg4win -e

# DISK SPACE ANALYZER
winget install --id=AntibodySoftware.WizTree -e

# BROWSER
winget install --id=Mozilla.Firefox -e
winget install --id=Hibbiki.Chromium -e