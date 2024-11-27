# scoop

$installScoopBuckets = Read-Host "Do you want to add Scoop and buckets? (yes/no)"
if ($installScoopBuckets -eq "yes") {
    Write-Host "Installing Scoop..." -ForegroundColor "Yellow"
    Invoke-WebRequest -useb get.scoop.sh | Invoke-Expression
    Write-Host "Adding Scoop buckets..." -ForegroundColor "Yellow"
    scoop install git
    scoop bucket add extras
    scoop bucket add versions
    $installScoopPackages = Read-Host "Do you want to install Scoop packages? (yes/no)"
    if ($installScoopPackages -eq "yes") {
        Write-Host "Installing Scoop packages..." -ForegroundColor "Yellow"
        scoop install wiztree
        scoop install python
        scoop install mobaxterm
    } else {
        Write-Host "Skipping Scoop packages installation." -ForegroundColor "Yellow"
    }
} else {
    Write-Host "Skipping Scoop buckets installation." -ForegroundColor "Yellow"
}

Refresh-Environment