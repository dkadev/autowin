Write-Host "Installing Winget packages..." -ForegroundColor "Yellow"

# BASICS
winget install --id=7zip.7zip -e  
winget install --id=Git.Git -e  
winget install --id=GnuPG.Gpg4win -e  
winget install --id=Microsoft.WindowsTerminal -e  
winget install --id=VideoLAN.VLC -e 
winget install --id=Microsoft.PowerToys -e

# PASSWORD MANAGER
winget install --id=KeePassXCTeam.KeePassXC  -e
# winget install --id=DominikReichl.KeePass -e  


# MAIL
winget install --id=Mozilla.Thunderbird -e  


# EDITOR  
winget install --id=Microsoft.VisualStudioCode -e  
# winget install --id=VSCodium.VSCodium -e 


# SECURITY
winget install --id=NordVPN.NordVPN -e  
# winget install --id=Twilio.Authy -e  


# DISK SPACE ANALYZER
winget install --id=AntibodySoftware.WizTree -e 
# winget install --id=WinDirStat.WinDirStat -e  


# BROWSER
# winget install --id=Mozilla.Firefox -e  
winget install --id=Mozilla.Firefox.DeveloperEdition -e  
# winget install --id=LibreWolf.LibreWolf -e  
winget install --id=Hibbiki.Chromium -e  


# NOTION
winget install --id=Notion.Notion -e  
# winget install --id=NotionRepackaged.NotionEnhanced -e  


# EXTRA
winget install --id=TimKosse.FileZilla.Client -e 
# winget install --id=qBittorrent.qBittorrent -e  
winget install --id=Oracle.VirtualBox -e  
winget install --id=Logitech.OptionsPlus -e  