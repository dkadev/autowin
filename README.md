# AutoWin

AutoWin is a comprehensive tool designed to automate the deployment of a custom Windows environment. It streamlines the installation process through a series of PowerShell and batch scripts that configure settings and install essential tools.

## 🚀 Quick Start

### 1. System Preparation
- Install all Windows Updates and reboot (repeat until no more updates are available)

### 2. Windows Activation
Choose one of the available activation methods:

#### Option A: HWID Activation (Recommended)
```cmd
.\Activation\HWID\HWID.bat
```

#### Option B: KMS38 Activation
```cmd
.\Activation\KMS38\KMS38.bat
```

> **Note:** Run the chosen activation script in an **Administrator Command Prompt**

- Reboot after activation

### 3. System Configuration
1. **Set your computer hostname** in `windows.ps1`
2. **Configure PowerShell execution policy** and run system settings:
   ```powershell
   Set-ExecutionPolicy Unrestricted -Scope Process -Force
   .\windows.ps1
   ```

### 4. System Debloating (Optional)

Remove Windows bloatware and improve privacy using Win11Debloat:

1. **Download Win11Debloat**: Get the [latest version](https://github.com/Raphire/Win11Debloat/releases/latest) and extract to your desired location
2. **Run the debloat script** in Administrator PowerShell:
   ```powershell
   Set-ExecutionPolicy Unrestricted -Scope Process -Force
   cd c:\Win11Debloat  # Navigate to extracted folder
   .\Win11Debloat.ps1
   ```
3. **Follow the on-screen instructions** carefully to customize your debloating options

> **Tip:** This script supports [command-line parameters](https://github.com/Raphire/Win11Debloat/wiki/How-To-Use#parameters) for advanced customization.

4. **Reboot** to apply all system changes

### 5. Software Installation
1. **Verify winget is available** or download from [Microsoft's latest release](https://github.com/microsoft/winget-cli/releases/latest):
   ```powershell
   winget --version
   ```

2. **Install software packages** in regular PowerShell (no admin required):
   ```powershell
   Set-ExecutionPolicy Unrestricted -Scope Process -Force
   .\packages.ps1
   ```

- Reboot

## Acknowledgements

- [massgravel](https://github.com/massgravel/Microsoft-Activation-Scripts) ❤️ 
- [jayharris](https://github.com/jayharris/dotfiles-windows) dotfiles powershell scripts
- [tylerdotrar](https://github.com/tylerdotrar/Unfuck-Windows10) for Unfuck-Windows10 project
- [Raphire](https://github.com/Raphire/Win11Debloat) for Win11Debloat project
