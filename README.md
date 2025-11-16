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

3. **Run Windows debloating script** in Administrator PowerShell:
   ```powershell
   Set-ExecutionPolicy Unrestricted -Scope Process -Force
   .\Unfuck-Windows10\Unfuck-Windows10.ps1
   ```

4. **Reboot** to apply all system changes

### 4. Software Installation
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
- Inspired on `jayharris` [dotfiles](https://github.com/jayharris/dotfiles-windows) powershell scripts.
- Great work from `tylerdotrar` with the debloating and privacy stuff - [Unfuck-Windows10](https://github.com/tylerdotrar/Unfuck-Windows10)
