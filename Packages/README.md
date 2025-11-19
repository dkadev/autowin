# Software Package Files

This directory contains configuration files for the AutoWin automated software installer.

## File Format

- One package per line
- Lines starting with `#` are comments and will be ignored
- Empty lines are ignored
- Use exact package identifiers for best results

## Package Identifiers

### Winget
Use the exact package ID from winget search:
```
winget search "package name"
```
Example: `Microsoft.VisualStudioCode`

### Scoop
Use the package name as shown in scoop search:
```
scoop search "package name"
```
Example: `wiztree`

### Chocolatey
Use the package name from chocolatey.org:
```
choco search "package name"
```
Example: `firefox`
