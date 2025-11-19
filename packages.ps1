# AutoWin Software Installer
# Automated software installation with multiple package managers

$ConfigPath = "./Packages"
$LogPath = "./logs"

# Create logs directory if it doesn't exist
if (!(Test-Path $LogPath)) {
    New-Item -ItemType Directory -Path $LogPath -Force | Out-Null
}

# Initialize log file
$LogFile = Join-Path $LogPath "install-$(Get-Date -Format 'yyyyMMdd-HHmmss').log"

# Logging function
function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $LogEntry = "[$Timestamp] [$Level] $Message"
    
    # Write to console with colors
    switch ($Level) {
        "WARN" { Write-Host $LogEntry -ForegroundColor Yellow }
        "ERROR" { Write-Host $LogEntry -ForegroundColor Red }
        "SUCCESS" { Write-Host $LogEntry -ForegroundColor Green }
        default { Write-Host $LogEntry -ForegroundColor White }
    }
    
    # Write to log file
    Add-Content -Path $LogFile -Value $LogEntry
}

# Function to read package list from file
function Get-PackageList {
    param([string]$FilePath)
    
    if (!(Test-Path $FilePath)) {
        Write-Log "Package file not found: $FilePath" "WARN"
        return @()
    }
    
    $packages = @()
    Get-Content $FilePath | ForEach-Object {
        $line = $_.Trim()
        if ($line -and !$line.StartsWith("#")) {
            $packages += $line
        }
    }
    
    return $packages
}

# Function to install Winget packages
function Install-WingetPackages {
    param([array]$Packages)
    
    if ($Packages.Count -eq 0) { return }
    
    Write-Log "Installing Winget packages..." "INFO"
    
    foreach ($package in $Packages) {
        Write-Log "Installing: $package"
        try {
            winget install --id=$package -e --silent --accept-package-agreements --accept-source-agreements | Out-Null
            if ($LASTEXITCODE -eq 0) {
                Write-Log "✅ $package" "SUCCESS"
            } else {
                Write-Log "❌ $package" "ERROR"
            }
        } catch {
            Write-Log "❌ $package" "ERROR"
        }
    }
}

# Function to install Scoop packages
function Install-ScoopPackages {
    param([array]$Packages)
    
    if ($Packages.Count -eq 0) { return }
    
    Write-Log "Installing Scoop packages..." "INFO"
    
    # Install scoop if needed
    if (!(Get-Command scoop -ErrorAction SilentlyContinue)) {
        Write-Log "Installing Scoop..."
        Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
        scoop install git
        scoop bucket add extras
        scoop bucket add versions
    }
    
    foreach ($package in $Packages) {
        Write-Log "Installing: $package"
        try {
            scoop install $package | Out-Null
            if ($LASTEXITCODE -eq 0) {
                Write-Log "✅ $package" "SUCCESS"
            } else {
                Write-Log "❌ $package" "ERROR"
            }
        } catch {
            Write-Log "❌ $package" "ERROR"
        }
    }
}

# Function to install Chocolatey packages
function Install-ChocolateyPackages {
    param([array]$Packages)
    
    if ($Packages.Count -eq 0) { return }
    
    Write-Log "Installing Chocolatey packages..." "INFO"
    
    # Install chocolatey if needed
    if (!(Get-Command choco -ErrorAction SilentlyContinue)) {
        Write-Log "Installing Chocolatey..."
        Set-ExecutionPolicy Bypass -Scope Process -Force
        [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
        Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
    }
    
    foreach ($package in $Packages) {
        Write-Log "Installing: $package"
        try {
            choco install $package -y | Out-Null
            if ($LASTEXITCODE -eq 0) {
                Write-Log "✅ $package" "SUCCESS"
            } else {
                Write-Log "❌ $package" "ERROR"
            }
        } catch {
            Write-Log "❌ $package" "ERROR"
        }
    }
}

# Function to prompt user for confirmation
function Confirm-Installation {
    param([string]$PackageManager, [array]$Packages)
    
    if ($Packages.Count -eq 0) {
        Write-Log "No $PackageManager packages found to install" "WARN"
        return $false
    }
    
    Write-Host "`nFound $($Packages.Count) $PackageManager packages:" -ForegroundColor Cyan
    $Packages | ForEach-Object { Write-Host "  - $_" -ForegroundColor Gray }
    
    do {
        $response = Read-Host "`nInstall $PackageManager packages? [Y/n]"
        if ([string]::IsNullOrWhiteSpace($response)) {
            $response = "y"
        }
        $response = $response.ToLower().Substring(0, 1)
    } while ($response -notin @('y', 'n'))
    
    if ($response -eq 'n') {
        Write-Host "Skipped $PackageManager packages" -ForegroundColor Yellow
    }
    
    return $response -eq 'y'
}

# Main installation
Write-Log "AutoWin Software Installation Started" "INFO"
Write-Log "Log: $LogFile" "INFO"

# Install packages with user confirmation
$wingetPackages = Get-PackageList (Join-Path $ConfigPath "winget.txt")
if (Confirm-Installation "Winget" $wingetPackages) {
    Install-WingetPackages $wingetPackages
} else {
    Write-Log "Skipping Winget packages" "INFO"
}

$scoopPackages = Get-PackageList (Join-Path $ConfigPath "scoop.txt")
if (Confirm-Installation "Scoop" $scoopPackages) {
    Install-ScoopPackages $scoopPackages
} else {
    Write-Log "Skipping Scoop packages" "INFO"
}

$chocoPackages = Get-PackageList (Join-Path $ConfigPath "choco.txt")
if (Confirm-Installation "Chocolatey" $chocoPackages) {
    Install-ChocolateyPackages $chocoPackages
} else {
    Write-Log "Skipping Chocolatey packages" "INFO"
}

Write-Log "Installation completed!" "SUCCESS"
Write-Log "Reboot recommended" "WARN"