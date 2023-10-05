<#
.SYNOPSIS
     Powershell script that will join the system to the domain and also rename it. 
.NOTES
    Author: John Monnett
    Date: 10.4.23
    Type: Public
    Version: 1.0.0
    Links: https://github.com/jcmonnett


Usage:
1. Save the script as JoinAndRename.ps1.
2. Open PowerShell as an administrator.
3. Navigate to the directory where you saved the script.
4. Run the script and provide the required parameters:

.\JoinAndRename.ps1 -domainName "YOUR_DOMAIN_NAME" -abbreviation "ABBREVIATION" -domainCredential "DOMAIN\Username"

Replace YOUR_DOMAIN_NAME with your actual domain name and ABBREVIATION with your desired abbreviation. DOMAIN\Username is a domain user with permissions to join machines to the domain.

When prompted, enter the password for the domain user.

Note:

1. You need administrative privileges to join a machine to a domain and rename it.
2. Ensure that the formed new computer name (ABBREVIATION-SERIAL) does not exceed the maximum length allowed for NetBIOS names, which is 15 characters.

#>

param (
    [Parameter(Mandatory=$true)]
    [string]$domainName,

    [Parameter(Mandatory=$true)]
    [string]$abbreviation,

    [Parameter(Mandatory=$true)]
    [string]$domainCredential
)

# Get computer's serial number from BIOS
$serialNumber = (Get-WmiObject -Class Win32_BIOS).SerialNumber

# Form the new computer name
$newComputerName = "$abbreviation-$serialNumber"

try {
    # Join to the domain
    Add-Computer -DomainName $domainName -Credential $domainCredential
    Write-Output "Joined to the domain $domainName successfully."

    # Rename the computer
    Rename-Computer -NewName $newComputerName -Force
    Write-Output "Computer renamed to $newComputerName successfully."

    # You might want to restart the computer to ensure changes take effect
    # Restart-Computer
} catch {
    Write-Error "An error occurred: $_"
}
