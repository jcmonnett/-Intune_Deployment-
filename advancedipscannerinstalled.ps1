# Define the download URL and installation directory
$downloadUrl = "https://www.advanced-ip-scanner.com/download/ipscan.exe"
$installDirectory = "C:\Program Files (x86)\Advanced IP Scanner"

# Check if Advanced IP Scanner is already installed
if (Test-Path -Path $installDirectory) {
    Write-Host "Advanced IP Scanner is already installed."
} else {
    Write-Host "Advanced IP Scanner is not installed. Installing..."

    # Download Advanced IP Scanner installer
    $installerPath = Join-Path $env:TEMP "ipscan.exe"
    Invoke-WebRequest -Uri $downloadUrl -OutFile $installerPath

    # Install Advanced IP Scanner silently
    Start-Process -FilePath $installerPath -ArgumentList "/S" -Wait

    # Check if installation was successful
    if (Test-Path -Path $installDirectory) {
        Write-Host "Advanced IP Scanner has been installed."
    } else {
        Write-Host "Failed to install Advanced IP Scanner."
    }

    # Clean up the temporary installer file
    Remove-Item -Path $installerPath -Force
}
