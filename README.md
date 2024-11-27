# Autowin

AutoWin is a tool designed to automate the deployment of a custom environment on Windows. It simplifies the installation process by executing some scripts that installs a set of tools and settings.

## Pre-installation steps

- Install all Windows Updates + Reboot (Repeat until no more updates)
- Run `activation.bat` in privileged CMD

    ```cmd
    .\activation.bat
    ```

- Reboot

## Settings

- Set HOSTNAME on `windows.ps1`
- Run `windows.ps1` in privileged PowerShell

    ```powershell
    Set-ExecutionPolicy AllSigned
    Set-ExecutionPolicy RemoteSigned -scope CurrentUser
    .\windows.ps1
    ```

- Run `Unfuck-Windows10.ps1` in privileged PowerShell

    ```powershell
    .\Unfuck-Windows10\Unfuck-Windows10.ps1
    ```

- Reboot

## Tools

- Check for winget or download it from the latest release [here](https://github.com/microsoft/winget-cli/releases/latest)

    ```powershell
    winget --version
    ```

- Run `packages.ps1` in non-privileged PowerShell

    ```powershell
    .\packages.ps1
    ```

- Reboot

## Acknowledgements

- Thanks to the KMS38 bug
- Inspired on `jayharris` [dotfiles](https://github.com/jayharris/dotfiles-windows) powershell scripts.
- Great work from `tylerdotrar` with the debloating and privacy stuff - [Unfuck-Windows10](https://github.com/tylerdotrar/Unfuck-Windows10)
