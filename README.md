# Windows 10 Pro Clean install + Activation + Config + Programs + Dotfiles

- Windows update  + Restarts

## Activation

- Run admin CMD
- cd into dotfiles directory
- Run `activation.bat`

## Config

- Change HOSTNAME on windows ps1
- Run admin PowerShell
- `Set-ExecutionPolicy AllSigned`
- `Set-ExecutionPolicy RemoteSigned -scope CurrentUser`
- Run `windows.ps1`

## Programs

- https://github.com/microsoft/winget-cli/releases/
- Run non-privileged PowerShell
- Run `packages.ps1`