# scoop
Write-Host "Installing Scoop..." -ForegroundColor "Yellow"
Invoke-WebRequest -useb get.scoop.sh | Invoke-Expression
Write-Host "Adding Scoop buckets..." -ForegroundColor "Yellow"
scoop install git
scoop bucket add extras
scoop bucket add versions
# Write-Host "Installing Scoop packages..." -ForegroundColor "Yellow"
# scoop install 7zip
# scoop install gpg4win
# scoop install python
# scoop install windirstat
# scoop install powertoys
# scoop install firefox
# scoop install librewolf
# scoop install mobaxterm
# scoop install filezilla
# scoop install vscode
# scoop install vscodium
# scoop install keepass
# scoop install thunderbird
# scoop install vlc
# scoop install qbittorrent
# scoop install notion

# Refresh-Environment

# 7ZIP
#Add 7-Zip as a context menu option by running:
# C:\Users\Usuario\scoop\apps\7zip\current\install-context.reg

# GIT
# Set Git Credential Manager Core by running:
# git config --global credential.helper manager

# PYTHON
# Allow applications and third-party installers to find python by running:
# C:\Users\Usuario\scoop\apps\python\current\install-pep-514.reg

# FIREFOX
# -----
# To set profile 'Scoop' as *DEFAULT*, or profiles/settings was lost after update:
# - Run 'Firefox Profile Manager', choose 'Scoop' then click 'Start Firefox'.
# - Visit 'about:profiles' page in Firefox to check *DEFAULT* profile.
# For details: https://support.mozilla.org/en-US/kb/profile-manager-create-remove-switch-firefox-profiles

# VSCODE
# -----
# Add Visual Studio Code as a context menu option by running: 
# reg import "C:\Users\Usuario\scoop\apps\vscode\current\install-context.reg"
# For file associations, run 'reg import 
# reg import "C:\Users\Usuario\scoop\apps\vscode\current\install-associations.reg"

# VSCODIUM
# -----
# Add VSCodium as a context menu option by running:
# reg import "C:\Users\Usuario\scoop\apps\vscodium\current\install-context.reg"
# For file associations, run 'reg import
# reg import "C:\Users\Usuario\scoop\apps\vscodium\current\install-associations.reg"

# THUNDERBIRD
# -----
# To set profile 'Scoop' as *DEFAULT*, or profiles/settings was lost after update:
# - Run 'Thunderbird Profile Manager', choose 'Scoop' then click 'Start Thunderbird'.
# - Visit 'about:profiles' page in Thunderbird to check *DEFAULT* profile.
# For details: https://support.mozilla.org/en-US/kb/profile-manager-create-and-remove-thunderbird-profiles