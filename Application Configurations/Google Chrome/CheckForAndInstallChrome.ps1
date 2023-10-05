<#
.SYNOPSIS
     PowerShell script that checks if Google Chrome is installed in either Program Files or Program Files (x86) and then installs it if not found. The script assumes you have the Google Chrome installer (for example, named chrome_installer.exe) in the same directory as the script.
.NOTES
    Author: John Monnett
    Date: 10.4.23
    Type: Public
    Version: 1.0.0
    Links: https://github.com/jcmonnett
#>

# Paths to check for Google Chrome
$chromePaths = @(
    "C:\Program Files\Google\Chrome\Application\chrome.exe",
    "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
)

$chromeFound = $false

foreach ($path in $chromePaths) {
    if (Test-Path $path) {
        Write-Output "Google Chrome found at $path"
        $chromeFound = $true
        break
    }
}

if (-not $chromeFound) {
    Write-Output "Google Chrome not found. Initiating installation..."
    
    # Assuming the installer is in the same directory as the script and named 'chrome_installer.exe'
    $installerPath = Join-Path -Path $PSScriptRoot -ChildPath 'chrome_installer.exe'
    
    if (Test-Path $installerPath) {
        Start-Process -Wait -FilePath $installerPath
        Write-Output "Google Chrome installation completed."
    } else {
        Write-Error "Chrome installer not found at $installerPath"
    }
} else {
    Write-Output "Google Chrome is already installed."
}
