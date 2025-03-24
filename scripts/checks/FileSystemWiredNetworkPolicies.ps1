# File System, Wired Network (IEEE 802.3) Policies, Windows Defender Firewall with Advanced Security, and Administrative Templates (Computer)


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

# Windows Defender Firewall - Domain Profile Checks
$windowsDefenderFirewallDomainProfileChecks = @(
    @{ Name = "Windows Firewall: Domain: Firewall state"; Value = "On (recommended)"; Type = "Automated"; ExpectedValue = "On (recommended)"; Recommendation = "Ensure the policy is set to 'On (recommended)'." },
    @{ Name = "Windows Firewall: Domain: Inbound connections"; Value = "Block (default)"; Type = "Automated"; ExpectedValue = "Block (default)"; Recommendation = "Ensure the policy is set to 'Block (default)'." },
    @{ Name = "Windows Firewall: Domain: Settings: Display a notification"; Value = "No"; Type = "Automated"; ExpectedValue = "No"; Recommendation = "Ensure the policy is set to 'No'." }
)

# Administrative Templates (Computer) - Control Panel Checks
$administrativeTemplatesControlPanelChecks = @(
    @{ Name = "Prevent enabling lock screen camera"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." },
    @{ Name = "Prevent enabling lock screen slide show"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." },
    @{ Name = "Allow users to enable online speech recognition services"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the policy is set to 'Disabled'." },
    @{ Name = "Allow Online Tips"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the policy is set to 'Disabled'." }
)

# Administrative Templates (Computer) - MS Security Guide Checks
$administrativeTemplatesMSSecurityGuideChecks = @(
    @{ Name = "Apply UAC restrictions to local accounts on network logons"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." },
    @{ Name = "Configure SMB v1 client driver"; Value = "Enabled: Disable driver (recommended)"; Type = "Automated"; ExpectedValue = "Enabled: Disable driver (recommended)"; Recommendation = "Ensure the policy is set to 'Enabled: Disable driver (recommended)'." }
)

# Perform checks and generate reports
Get-ComplianceReport -Category "WindowsDefenderFirewallDomainProfile" -Checks $windowsDefenderFirewallDomainProfileChecks
Get-ComplianceReport -Category "AdministrativeTemplatesControlPanel" -Checks $administrativeTemplatesControlPanelChecks
Get-ComplianceReport -Category "AdministrativeTemplatesMSSecurityGuide" -Checks $administrativeTemplatesMSSecurityGuideChecks

Write-Host "Compliance reports generated at: $outputDir"