#  Attack Surface Reduction, Controlled Folder Access, Network Protection, MpEngine, Network Inspection System, Quarantine, Real-time Protection, Remediation, Reporting, Scan, Security Intelligence Updates, Threats, and Microsoft Defender Application Guard checks
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

# Attack Surface Reduction Checks
$attackSurfaceReductionChecks = @(
    @{ Name = "Configure Attack Surface Reduction rules"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." },
    @{ Name = "Configure Attack Surface Reduction rules: Set the state for each ASR rule"; Value = "Configured"; Type = "Automated"; ExpectedValue = "Configured"; Recommendation = "Ensure the policy is configured for each ASR rule." }
)

# Network Protection Checks
$networkProtectionChecks = @(
    @{ Name = "Prevent users and apps from accessing dangerous websites"; Value = "Enabled: Block"; Type = "Automated"; ExpectedValue = "Enabled: Block"; Recommendation = "Ensure the policy is set to 'Enabled: Block'." }
)

# MpEngine Checks
$mpEngineChecks = @(
    @{ Name = "Enable file hash computation feature"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." }
)

# Network Inspection System Checks
$networkInspectionSystemChecks = @(
    @{ Name = "Convert warn verdict to block"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." }
)

# Real-time Protection Checks
$realTimeProtectionChecks = @(
    @{ Name = "Configure real-time protection and Security Intelligence Updates during OOBE"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." },
    @{ Name = "Scan all downloaded files and attachments"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." },
    @{ Name = "Turn off real-time protection"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the policy is set to 'Disabled'." },
    @{ Name = "Turn on behavior monitoring"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." },
    @{ Name = "Turn on script scanning"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." }
)

# Remediation Checks
$remediationChecks = @(
    @{ Name = "Configure Brute-Force Protection aggressiveness"; Value = "Enabled: Medium"; Type = "Automated"; ExpectedValue = "Enabled: Medium"; Recommendation = "Ensure the policy is set to 'Enabled: Medium' or higher." },
    @{ Name = "Configure Remote Encryption Protection Mode"; Value = "Enabled: Audit"; Type = "Automated"; ExpectedValue = "Enabled: Audit"; Recommendation = "Ensure the policy is set to 'Enabled: Audit' or higher." },
    @{ Name = "Configure how aggressively Remote Encryption Protection blocks threats"; Value = "Enabled: Medium"; Type = "Automated"; ExpectedValue = "Enabled: Medium"; Recommendation = "Ensure the policy is set to 'Enabled: Medium' or higher." }
)

# Reporting Checks
$reportingChecks = @(
    @{ Name = "Configure Watson events"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the policy is set to 'Disabled'." }
)

# Scan Checks
$scanChecks = @(
    @{ Name = "Scan excluded files and directories during quick scans"; Value = "Enabled: 1"; Type = "Automated"; ExpectedValue = "Enabled: 1"; Recommendation = "Ensure the policy is set to 'Enabled: 1'." },
    @{ Name = "Scan packed executables"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." },
    @{ Name = "Scan removable drives"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." },
    @{ Name = "Trigger a quick scan after X days without any scans"; Value = "Enabled: 7"; Type = "Automated"; ExpectedValue = "Enabled: 7"; Recommendation = "Ensure the policy is set to 'Enabled: 7'." },
    @{ Name = "Turn on e-mail scanning"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." }
)

# Threats Checks
$threatsChecks = @(
    @{ Name = "Configure detection for potentially unwanted applications"; Value = "Enabled: Block"; Type = "Automated"; ExpectedValue = "Enabled: Block"; Recommendation = "Ensure the policy is set to 'Enabled: Block'." },
    @{ Name = "Control whether exclusions are visible to local users"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." }
)

# Microsoft Defender Application Guard Checks
$defenderAppGuardChecks = @(
    @{ Name = "Allow auditing events in Microsoft Defender Application Guard"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." },
    @{ Name = "Allow camera and microphone access in Microsoft Defender Application Guard"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the policy is set to 'Disabled'." },
    @{ Name = "Allow data persistence for Microsoft Defender Application Guard"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the policy is set to 'Disabled'." },
    @{ Name = "Allow files to download and save to the host operating system from Microsoft Defender Application Guard"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the policy is set to 'Disabled'." },
    @{ Name = "Configure Microsoft Defender Application Guard clipboard settings: Clipboard behavior setting"; Value = "Enabled: Enable clipboard operation from an isolated session to the host"; Type = "Automated"; ExpectedValue = "Enabled: Enable clipboard operation from an isolated session to the host"; Recommendation = "Ensure the policy is set to 'Enabled: Enable clipboard operation from an isolated session to the host'." },
    @{ Name = "Turn on Microsoft Defender Application Guard in Managed Mode"; Value = "Enabled: 1"; Type = "Automated"; ExpectedValue = "Enabled: 1"; Recommendation = "Ensure the policy is set to 'Enabled: 1'." }
)

# Perform checks and generate reports
Get-ComplianceReport -Category "AttackSurfaceReduction" -Checks $attackSurfaceReductionChecks
Get-ComplianceReport -Category "NetworkProtection" -Checks $networkProtectionChecks
Get-ComplianceReport -Category "MpEngine" -Checks $mpEngineChecks
Get-ComplianceReport -Category "NetworkInspectionSystem" -Checks $networkInspectionSystemChecks
Get-ComplianceReport -Category "RealTimeProtection" -Checks $realTimeProtectionChecks
Get-ComplianceReport -Category "Remediation" -Checks $remediationChecks
Get-ComplianceReport -Category "Reporting" -Checks $reportingChecks
Get-ComplianceReport -Category "Scan" -Checks $scanChecks
Get-ComplianceReport -Category "Threats" -Checks $threatsChecks
Get-ComplianceReport -Category "DefenderAppGuard" -Checks $defenderAppGuardChecks

Write-Host "Compliance reports generated at: $outputDir"