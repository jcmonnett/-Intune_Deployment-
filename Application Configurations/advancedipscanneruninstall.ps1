<#
.SYNOPSIS
    Checks if Advanced IP Scanner is installed. If it is, it uninstalls the application silently.
.NOTES
    Author: John Monnett
    Date: 10.1.23
    Type: Public
    Version: 1.0.0
    Links: https://github.com/jcmonnett
#>

# Define the application name
$applicationName = "Advanced IP Scanner"

# Check if Advanced IP Scanner is installed
$installed = Get-WmiObject -Query "SELECT * FROM Win32_Product WHERE Name = '$applicationName'"

if ($installed -eq $null) {
    Write-Host "$applicationName is not installed."
} else {
    Write-Host "$applicationName is installed. Uninstalling..."

    # Uninstall Advanced IP Scanner
    $uninstallCommand = "msiexec.exe /x $($installed.IdentifyingNumber) /qn"
    Start-Process -FilePath "cmd.exe" -ArgumentList "/C $uninstallCommand" -Wait

    # Check if the uninstallation was successful
    $checkUninstall = Get-WmiObject -Query "SELECT * FROM Win32_Product WHERE Name = '$applicationName'"
    if ($checkUninstall -eq $null) {
        Write-Host "$applicationName has been uninstalled."
    } else {
        Write-Host "Failed to uninstall $applicationName."
    }
}
