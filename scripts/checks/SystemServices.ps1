# Define the output directory
$outputDir = "$env:USERPROFILE\Desktop\CIS_Compliance_Report"
if (-not (Test-Path $outputDir)) {
    New-Item -ItemType Directory -Path $outputDir | Out-Null
}

# Function to check compliance and generate a report
function Get-ComplianceReport {
    param (
        [string]$Category,
        [array]$Checks
    )

    $report = @()

    foreach ($check in $Checks) {
        $checkName = $check.Name
        $checkValue = $check.Value
        $checkType = $check.Type
        $expectedValue = $check.ExpectedValue
        $recommendation = $check.Recommendation

        # Perform the check
        $complianceStatus = "Not Met"
        if ($checkValue -eq $expectedValue) {
            $complianceStatus = "Met"
        }

        # Add the result to the report
        $report += [PSCustomObject]@{
            Check           = $checkName
            Compliance      = $complianceStatus
            Recommendation  = $recommendation
        }
    }

    # Export the report to CSV
    $report | Export-Csv -Path "$outputDir\$Category.csv" -NoTypeInformation
}

# System Services - Bluetooth Services Checks
$systemServicesBluetoothChecks = @(
    @{ Name = "Bluetooth Audio Gateway Service (BTAGService)"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the service is set to 'Disabled'." },
    @{ Name = "Bluetooth Support Service (bthserv)"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the service is set to 'Disabled'." }
)

# System Services - Browser Services Checks
$systemServicesBrowserChecks = @(
    @{ Name = "Computer Browser (Browser)"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the service is set to 'Disabled' or 'Not Installed'." }
)

# System Services - Location and Map Services Checks
$systemServicesLocationMapChecks = @(
    @{ Name = "Downloaded Maps Manager (MapsBroker)"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the service is set to 'Disabled'." },
    @{ Name = "GameInput Service (GameInputSvc)"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the service is set to 'Disabled'." },
    @{ Name = "Geolocation Service (lfsvc)"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the service is set to 'Disabled'." }
)

# System Services - Web and Remote Services Checks
$systemServicesWebRemoteChecks = @(
    @{ Name = "IIS Admin Service (IISADMIN)"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the service is set to 'Disabled' or 'Not Installed'." },
    @{ Name = "Infrared Monitor Service (irmon)"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the service is set to 'Disabled' or 'Not Installed'." },
    @{ Name = "Link-Layer Topology Discovery Mapper (lltdsvc)"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the service is set to 'Disabled'." },
    @{ Name = "LxssManager (LxssManager)"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the service is set to 'Disabled' or 'Not Installed'." },
    @{ Name = "Microsoft FTP Service (FTPSVC)"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the service is set to 'Disabled' or 'Not Installed'." },
    @{ Name = "Microsoft iSCSI Initiator Service (MSiSCSI)"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the service is set to 'Disabled'." },
    @{ Name = "OpenSSH SSH Server (sshd)"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the service is set to 'Disabled' or 'Not Installed'." },
    @{ Name = "Print Spooler (Spooler)"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the service is set to 'Disabled'." }
)

# Perform checks and generate reports
Get-ComplianceReport -Category "SystemServicesBluetooth" -Checks $systemServicesBluetoothChecks
Get-ComplianceReport -Category "SystemServicesBrowser" -Checks $systemServicesBrowserChecks
Get-ComplianceReport -Category "SystemServicesLocationMap" -Checks $systemServicesLocationMapChecks
Get-ComplianceReport -Category "SystemServicesWebRemote" -Checks $systemServicesWebRemoteChecks

Write-Host "Compliance reports generated at: $outputDir"