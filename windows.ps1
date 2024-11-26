###############################################################################
### Security and Identity                                                     #
###############################################################################
Write-Host "Configuring System..." -ForegroundColor "Yellow"

# Set Computer Name
Write-Host "Setting Computer Name..." 
try {
    (Get-WmiObject Win32_ComputerSystem).Rename("WIN") | Out-Null
    Write-Host "Computer name set successfully." -ForegroundColor "Green"
} catch {
    Write-Host "Failed to set computer name: $_" -ForegroundColor "Red"
}


###############################################################################
### Privacy                                                                   #
###############################################################################
Write-Host "Configuring Privacy..." -ForegroundColor "Yellow"

# General: Don't let apps use advertising ID for experiences across apps: Allow: 1, Disallow: 0
if (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo")) {New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" -Type Folder | Out-Null}
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" "Enabled" 0
Remove-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" "Id" -ErrorAction SilentlyContinue

# General: Disable Application launch tracking: Enable: 1, Disable: 0
Set-ItemProperty "HKCU:\\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "Start-TrackProgs" 0

# General: Disable SmartScreen Filter for Store Apps: Enable: 1, Disable: 0
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost" "EnableWebContentEvaluation" 0

# General: Disable key logging & transmission to Microsoft: Enable: 1, Disable: 0
# Disabled when Telemetry is set to Basic
if (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Input")) {New-Item -Path "HKCU:\SOFTWARE\Microsoft\Input" -Type Folder | Out-Null}
if (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Input\TIPC")) {New-Item -Path "HKCU:\SOFTWARE\Microsoft\Input\TIPC" -Type Folder | Out-Null}
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Input\TIPC" "Enabled" 0

# General: Opt-out from websites from accessing language list: Opt-in: 0, Opt-out 1
Set-ItemProperty "HKCU:\Control Panel\International\User Profile" "HttpAcceptLanguageOptOut" 1

# General: Disable SmartGlass: Enable: 1, Disable: 0
#Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\SmartGlass" "UserAuthPolicy" 0

# General: Disable SmartGlass over BlueTooth: Enable: 1, Disable: 0
#Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\SmartGlass" "BluetoothPolicy" 0

# General: Disable suggested content in settings app: Enable: 1, Disable: 0
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SubscribedContent-338393Enabled" 0
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SubscribedContent-338394Enabled" 0
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SubscribedContent-338396Enabled" 0

# General: Disable tips and suggestions for welcome and what's new: Enable: 1, Disable: 0
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SubscribedContent-310093Enabled" 0

# General: Disable tips and suggestions when I use windows: Enable: 1, Disable: 0
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SubscribedContent-338389Enabled" 0

# Start Menu: Disable suggested content: Enable: 1, Disable: 0
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SubscribedContent-338388Enabled" 0

# Start Menu: Disable search entries: Enable: 0, Disable: 1
if (!(Test-Path "HKCU:\Software\Policies\Microsoft\Windows\Explorer")) {New-Item -Path "HKCU:\Software\Policies\Microsoft\Windows\Explorer" -Type Folder | Out-Null}
Set-ItemProperty "HKCU:\Software\Policies\Microsoft\Windows\Explorer" "DisableSearchBoxSuggestions" 1

# Camera: Don't let apps use camera: Allow, Deny
# if (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\webcam")) {New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\webcam" -Type Folder | Out-Null}
# Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\webcam" "Value" "Deny"

# Microphone: Don't let apps use microphone: Allow, Deny
# if (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\microphone")) {New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\microphone" -Type Folder | Out-Null}
# Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\microphone" "Value" "Deny"

# Notifications: Don't let apps access notifications: Allow, Deny
# if (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userNotificationListener")) {New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userNotificationListener" -Type Folder | Out-Null}
# Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userNotificationListener" "Value" "Deny"

# Speech, Inking, & Typing: Stop "Getting to know me"
if (!(Test-Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization")) {New-Item -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization" -Type Folder | Out-Null}
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\InputPersonalization" "RestrictImplicitTextCollection" 1
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\InputPersonalization" "RestrictImplicitInkCollection" 1
if (!(Test-Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore")) {New-Item -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" -Type Folder | Out-Null}
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" "HarvestContacts" 0
if (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Personalization\Settings")) {New-Item -Path "HKCU:\SOFTWARE\Microsoft\Personalization\Settings" -Type Folder | Out-Null}
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Personalization\Settings" "AcceptedPrivacyPolicy" 0
if (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Speech_OneCore\Settings")) {New-Item -Path "HKCU:\SOFTWARE\Microsoft\Speech_OneCore\Settings" -Type Folder | Out-Null}
if (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Speech_OneCore\Settings\OnlineSpeechPrivacy")) {New-Item -Path "HKCU:\SOFTWARE\Microsoft\Speech_OneCore\Settings\OnlineSpeechPrivacy" -Type Folder | Out-Null}
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Speech_OneCore\Settings\OnlineSpeechPrivacy" "HasAccepted" 0

# Account Info: Don't let apps access name, picture, and other account info: Allow, Deny
# if (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userAccountInformation")) {New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userAccountInformation" -Type Folder | Out-Null}
# Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userAccountInformation" "Value" "Deny"

# Contacts: Don't let apps access contacts: Allow, Deny
if (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\contacts")) {New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\contacts" -Type Folder | Out-Null}
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\contacts" "Value" "Deny"

# Calendar: Don't let apps access calendar: Allow, Deny
if (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appointments")) {New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appointments" -Type Folder | Out-Null}
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appointments" "Value" "Deny"

# Call History: Don't let apps make phone calls: Allow, Deny
if (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCall")) {New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCall" -Type Folder | Out-Null}
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCall" "Value" "Deny"

# Call History: Don't let apps access call history: Allow, Deny
if (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCallHistory")) {New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCallHistory" -Type Folder | Out-Null}
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCallHistory" "Value" "Deny"

# Diagnostics: Don't let apps access diagnostics of other apps: Allow, Deny
if (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appDiagnostics")) {New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appDiagnostics" -Type Folder | Out-Null}
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appDiagnostics" "Value" "Deny"

# Documents: Don't let apps access documents: Allow, Deny
if (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\documentsLibrary")) {New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\documentsLibrary" -Type Folder | Out-Null}
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\documentsLibrary" "Value" "Deny"

# Downloads: Don't let apps access downloads: Allow, Deny
if (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\downloadsFolder")) {New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\downloadsFolder" -Type Folder | Out-Null}
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\downloadsFolder" "Value" "Deny"

# Email: Don't let apps read and send email: Allow, Deny
if (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\email")) {New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\email" -Type Folder | Out-Null}
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\email" "Value" "Deny"

# File System: Don't let apps access the file system: Allow, Deny
if (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\broadFileSystemAccess")) {New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\broadFileSystemAccess" -Type Folder | Out-Null}
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\broadFileSystemAccess" "Value" "Deny"

# Location: Don't let apps access the location: Allow, Deny
if (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location")) {New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" -Type Folder | Out-Null}
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" "Value" "Deny"

# Messaging: Don't let apps read or send messages (text or MMS): Allow, Deny
if (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\chat")) {New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\chat" -Type Folder | Out-Null}
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\chat" "Value" "Deny"

# Music Library: Don't let apps access music library: Allow, Deny
if (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\musicLibrary")) {New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\musicLibrary" -Type Folder | Out-Null}
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\musicLibrary" "Value" "Deny"

# Pictures: Don't let apps access pictures: Allow, Deny
if (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\picturesLibrary")) {New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\picturesLibrary" -Type Folder | Out-Null}
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\picturesLibrary" "Value" "Deny"

# Radios: Don't let apps control radios (like Bluetooth): Allow, Deny
if (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\radios")) {New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\radios" -Type Folder | Out-Null}
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\radios" "Value" "Deny"

# Screenshot: Don't let apps take screenshots: Allow, Deny
if (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\graphicsCaptureProgrammatic")) {New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\graphicsCaptureProgrammatic" -Type Folder | Out-Null}
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\graphicsCaptureProgrammatic" "Value" "Deny"

# Screenshot Borders: Don't let apps access screenshot border settings: Allow, Deny
if (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\graphicsCaptureWithoutBorder")) {New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\graphicsCaptureWithoutBorder" -Type Folder | Out-Null}
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\graphicsCaptureWithoutBorder" "Value" "Deny"

# Tasks: Don't let apps access the tasks: Allow, Deny
if (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userDataTasks")) {New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userDataTasks" -Type Folder | Out-Null}
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userDataTasks" "Value" "Deny"

# Other Devices: Don't let apps share and sync with non-explicitly-paired wireless devices over uPnP: Allow, Deny
if (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\bluetoothSync")) {New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\bluetoothSync" -Type Folder | Out-Null}
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\bluetoothSync" "Value" "Deny"

# Videos: Don't let apps access videos: Allow, Deny
if (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\videosLibrary")) {New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\videosLibrary" -Type Folder | Out-Null}
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\videosLibrary" "Value" "Deny"

# Feedback: Windows should never ask for my feedback
if (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Siuf")) {New-Item -Path "HKCU:\SOFTWARE\Microsoft\Siuf" -Type Folder | Out-Null}
if (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Siuf\Rules")) {New-Item -Path "HKCU:\SOFTWARE\Microsoft\Siuf\Rules" -Type Folder | Out-Null}
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Siuf\Rules" "NumberOfSIUFInPeriod" 0

# Feedback: Telemetry: Send Diagnostic and usage data: Basic: 1, Enhanced: 2, Full: 3
Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" "AllowTelemetry" 1
Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" "MaxTelemetryAllowed" 1


###############################################################################
### Personalization                                                           #
###############################################################################
Write-Host "Configuring Personalization..." -ForegroundColor "Yellow"

## Set the Desktop Background to solid color
## Background Color: #000000
Write-Host "Setting Desktop Background to solid color"
try {
    Set-ItemProperty "HKCU:\Control Panel\Desktop" "Wallpaper" ""
    Set-ItemProperty "HKCU:\Control Panel\Desktop" "WallpaperStyle" 2
    Set-ItemProperty "HKCU:\Control Panel\Desktop" "TileWallpaper" 0
    Set-ItemProperty "HKCU:\Control Panel\Colors" "Background" "0 0 0"
    Write-Host "OK" -ForegroundColor "Green"
} catch {
    Write-Host "ERROR: $_" -ForegroundColor "Red"
}


###############################################################################
### Accessibility and Ease of Use                                             #
###############################################################################
Write-Host "Configuring Accessibility..." -ForegroundColor "Yellow"

# Turn Off Windows Narrator Hotkey: Enable: 1, Disable: 0
Write-Host "Turn Off Windows Narrator Hotkey" 
try {
    Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Narrator\NoRoam" "WinEnterLaunchEnabled" 0
    Write-Host "OK" -ForegroundColor "Green"
} catch {
    Write-Host "ERROR: $_" -ForegroundColor "Red"
}

# Disable "Window Snap" Automatic Window Arrangement: Enable: 1, Disable: 0
# Write-Host "Disable 'Window Snap' Automatic Window Arrangement" 
# try {
#     Set-ItemProperty "HKCU:\Control Panel\Desktop" "WindowArrangementActive" 0
#     Write-Host "OK" -ForegroundColor "Green"
# } catch {
#     Write-Host "ERROR: $_" -ForegroundColor "Red"
# }

# Disable automatic fill to space on Window Snap: Enable: 1, Disable: 0
Write-Host "Disable automatic fill to space on Window Snap" 
try {
    Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "SnapFill" 0
    Write-Host "OK" -ForegroundColor "Green"
} catch {
    Write-Host "ERROR: $_" -ForegroundColor "Red"
}

# Disable showing what can be snapped next to a window: Enable: 1, Disable: 0
Write-Host "Disable showing what can be snapped next to a window" 
try {
    Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "SnapAssist" 0
    Write-Host "OK" -ForegroundColor "Green"
} catch {
    Write-Host "ERROR: $_" -ForegroundColor "Red"
}

# Disable automatic resize of adjacent windows on snap: Enable: 1, Disable: 0
Write-Host "Disable automatic resize of adjacent windows on snap" 
try {
    Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "JointResize" 0
    Write-Host "OK" -ForegroundColor "Green"
} catch {
    Write-Host "ERROR: $_" -ForegroundColor "Red"
}

# Disable auto-correct: Enable: 1, Disable: 0
Write-Host "Disable auto-correct" 
try {
    Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\TabletTip\1.7" "EnableAutocorrection" 0
    Write-Host "OK" -ForegroundColor "Green"
} catch {
    Write-Host "ERROR: $_" -ForegroundColor "Red"
}


###############################################################################
### Windows Defender                                                          #
###############################################################################
Write-Host "Configuring Windows Defender..." -ForegroundColor "Yellow"

# Disable Windows Defender Real-Time Protection
Set-MpPreference -DisableRealtimeMonitoring $true

# Disable Windows Defender Scheduled Scans
Set-MpPreference -DisableBehaviorMonitoring $true
Set-MpPreference -DisableOnAccessProtection $true
Set-MpPreference -DisableIOAVProtection $true
Set-MpPreference -DisablePrivacyMode $true

# Disable Windows Defender Services
Stop-Service -Name WinDefend -Force
Set-Service -Name WinDefend -StartupType Disabled

# Disable Windows Defender in the registry
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender" -Name "DisableAntiSpyware" -Value 1
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender" -Name "DisableAntiVirus" -Value 1

# Disable Cloud-Based Protection: Enabled Advanced: 2, Enabled Basic: 1, Disabled: 0
Set-MpPreference -MAPSReporting 2

# Disable automatic sample submission: Prompt: 0, Auto Send Safe: 1, Never: 2, Auto Send All: 3
Set-MpPreference -SubmitSamplesConsent 2

Write-Host "Windows Defender has been disabled." -ForegroundColor "Green"
