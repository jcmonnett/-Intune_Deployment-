<#
.SYNOPSIS
    PowerShell script that checks if Google Chrome uninstall.exe is in either Program Files or Program Files (x86) and then uninstalls Google Chrome if found.
.NOTES
    Author: John Monnett
    Date: 10.4.23
    Type: Public
    Version: 1.0.0
    Links: https://github.com/jcmonnett
#>

# Paths to check for Google Chrome uninstaller
$uninstallerPaths = @(
    "C:\Program Files\Google\Chrome\Application\uninstall.exe",
    "C:\Program Files (x86)\Google\Chrome\Application\uninstall.exe"
)

$chromeFound = $false

foreach ($path in $uninstallerPaths) {
    if (Test-Path $path) {
        Write-Output "Google Chrome uninstaller found at $path"
        $chromeFound = $true
        
        # Start the uninstaller
        Start-Process -Wait -FilePath $path -ArgumentList "--force-uninstall"
        Write-Output "Google Chrome uninstallation completed."
        break
    }
}

if (-not $chromeFound) {
    Write-Output "Google Chrome uninstaller not found. It might not be installed."
}
