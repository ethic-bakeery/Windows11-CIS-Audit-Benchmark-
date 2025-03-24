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

# Miscellaneous Services Checks
$miscellaneousServicesChecks = @(
    @{ Name = "Problem Reports and Solutions Control Panel Support (wercplsupport)"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the service is set to 'Disabled'." },
    @{ Name = "Remote Access Auto Connection Manager (RasAuto)"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the service is set to 'Disabled'." },
    @{ Name = "Remote Desktop Configuration (SessionEnv)"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the service is set to 'Disabled'." },
    @{ Name = "Remote Desktop Services (TermService)"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the service is set to 'Disabled'." },
    @{ Name = "Remote Desktop Services UserMode Port Redirector (UmRdpService)"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the service is set to 'Disabled'." },
    @{ Name = "Remote Procedure Call (RPC) Locator (RpcLocator)"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the service is set to 'Disabled'." },
    @{ Name = "Remote Registry (RemoteRegistry)"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the service is set to 'Disabled'." },
    @{ Name = "Routing and Remote Access (RemoteAccess)"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the service is set to 'Disabled'." },
    @{ Name = "Server (LanmanServer)"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the service is set to 'Disabled'." },
    @{ Name = "Simple TCP/IP Services (simptcp)"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the service is set to 'Disabled' or 'Not Installed'." },
    @{ Name = "SNMP Service (SNMP)"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the service is set to 'Disabled' or 'Not Installed'." },
    @{ Name = "Special Administration Console Helper (sacsvr)"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the service is set to 'Disabled' or 'Not Installed'." },
    @{ Name = "SSDP Discovery (SSDPSRV)"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the service is set to 'Disabled'." },
    @{ Name = "UPnP Device Host (upnphost)"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the service is set to 'Disabled'." },
    @{ Name = "Web Management Service (WMSvc)"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the service is set to 'Disabled' or 'Not Installed'." },
    @{ Name = "Windows Error Reporting Service (WerSvc)"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the service is set to 'Disabled'." },
    @{ Name = "Windows Event Collector (Wecsvc)"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the service is set to 'Disabled'." },
    @{ Name = "Windows Media Player Network Sharing Service (WMPNetworkSvc)"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the service is set to 'Disabled' or 'Not Installed'." },
    @{ Name = "Windows Mobile Hotspot Service (icssvc)"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the service is set to 'Disabled'." },
    @{ Name = "Windows Push Notifications System Service (WpnService)"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the service is set to 'Disabled'." },
    @{ Name = "Windows PushToInstall Service (PushToInstall)"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the service is set to 'Disabled'." }
)

# Perform checks and generate reports
Get-ComplianceReport -Category "MiscellaneousServices" -Checks $miscellaneousServicesChecks

Write-Host "Compliance report generated at: $outputDir"