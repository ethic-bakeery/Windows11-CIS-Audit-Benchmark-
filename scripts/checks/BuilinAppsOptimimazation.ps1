# Define the output directory
#  Camera, Chat, Cloud Content, Connect, Credential User Interface, Data Collection and Preview Builds, Delivery Optimization, and Desktop App Installer checks
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

# Camera Checks
$cameraChecks = @(
    @{ Name = "Allow Use of Camera"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the policy is set to 'Disabled'." }
)

# Cloud Content Checks
$cloudContentChecks = @(
    @{ Name = "Turn off cloud consumer account state content"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." },
    @{ Name = "Turn off cloud optimized content"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." },
    @{ Name = "Turn off Microsoft consumer experiences"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." }
)

# Connect Checks
$connectChecks = @(
    @{ Name = "Require pin for pairing"; Value = "Enabled: First Time"; Type = "Automated"; ExpectedValue = "Enabled: First Time"; Recommendation = "Ensure the policy is set to 'Enabled: First Time' or 'Enabled: Always'." }
)

# Credential User Interface Checks
$credentialUIChecks = @(
    @{ Name = "Do not display the password reveal button"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." },
    @{ Name = "Enumerate administrator accounts on elevation"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the policy is set to 'Disabled'." },
    @{ Name = "Prevent the use of security questions for local accounts"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." }
)

# Data Collection and Preview Builds Checks
$dataCollectionChecks = @(
    @{ Name = "Allow Diagnostic Data"; Value = "Enabled: Diagnostic data off (not recommended)"; Type = "Automated"; ExpectedValue = "Enabled: Diagnostic data off (not recommended)"; Recommendation = "Ensure the policy is set to 'Enabled: Diagnostic data off (not recommended)' or 'Enabled: Send required diagnostic data'." },
    @{ Name = "Configure Authenticated Proxy usage for the Connected User Experience and Telemetry service"; Value = "Enabled: Disable Authenticated Proxy usage"; Type = "Automated"; ExpectedValue = "Enabled: Disable Authenticated Proxy usage"; Recommendation = "Ensure the policy is set to 'Enabled: Disable Authenticated Proxy usage'." },
    @{ Name = "Disable OneSettings Downloads"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." },
    @{ Name = "Do not show feedback notifications"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." },
    @{ Name = "Enable OneSettings Auditing"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." },
    @{ Name = "Limit Diagnostic Log Collection"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." },
    @{ Name = "Limit Dump Collection"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." }
)

# Delivery Optimization Checks
$deliveryOptimizationChecks = @(
    @{ Name = "Download Mode"; Value = "Not Enabled: Internet"; Type = "Automated"; ExpectedValue = "Not Enabled: Internet"; Recommendation = "Ensure the policy is NOT set to 'Enabled: Internet'." }
)

# Desktop App Installer Checks
$desktopAppInstallerChecks = @(
    @{ Name = "Enable App Installer"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the policy is set to 'Disabled'." },
    @{ Name = "Enable App Installer Experimental Features"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the policy is set to 'Disabled'." },
    @{ Name = "Enable App Installer Hash Override"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the policy is set to 'Disabled'." },
    @{ Name = "Enable App Installer Local Archive Malware Scan Override"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the policy is set to 'Disabled'." },
    @{ Name = "Enable App Installer Microsoft Store Source Certificate Validation Bypass"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the policy is set to 'Disabled'." },
    @{ Name = "Enable App Installer ms-appinstaller protocol"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the policy is set to 'Disabled'." },
    @{ Name = "Enable Windows Package Manager command line interfaces"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the policy is set to 'Disabled'." }
)

# Perform checks and generate reports
Get-ComplianceReport -Category "Camera" -Checks $cameraChecks
Get-ComplianceReport -Category "CloudContent" -Checks $cloudContentChecks
Get-ComplianceReport -Category "Connect" -Checks $connectChecks
Get-ComplianceReport -Category "CredentialUI" -Checks $credentialUIChecks
Get-ComplianceReport -Category "DataCollection" -Checks $dataCollectionChecks
Get-ComplianceReport -Category "DeliveryOptimization" -Checks $deliveryOptimizationChecks
Get-ComplianceReport -Category "DesktopAppInstaller" -Checks $desktopAppInstallerChecks

Write-Host "Compliance reports generated at: $outputDir"