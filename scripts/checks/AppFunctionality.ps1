# Define the output directory
# App Privacy, App Runtime, Application Compatibility, AutoPlay Policies, Biometrics, and BitLocker Drive Encryption checks.
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

# App Privacy Checks
$appPrivacyChecks = @(
    @{ Name = "Let Windows apps activate with voice while the system is locked"; Value = "Enabled: Force Deny"; Type = "Automated"; ExpectedValue = "Enabled: Force Deny"; Recommendation = "Ensure the policy is set to 'Enabled: Force Deny'." }
)

# App Runtime Checks
$appRuntimeChecks = @(
    @{ Name = "Allow Microsoft accounts to be optional"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." },
    @{ Name = "Block launching Universal Windows apps with Windows Runtime API access from hosted content"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." }
)

# AutoPlay Policies Checks
$autoPlayPoliciesChecks = @(
    @{ Name = "Disallow Autoplay for non-volume devices"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." },
    @{ Name = "Set the default behavior for AutoRun"; Value = "Enabled: Do not execute any autorun commands"; Type = "Automated"; ExpectedValue = "Enabled: Do not execute any autorun commands"; Recommendation = "Ensure the policy is set to 'Enabled: Do not execute any autorun commands'." },
    @{ Name = "Turn off Autoplay"; Value = "Enabled: All drives"; Type = "Automated"; ExpectedValue = "Enabled: All drives"; Recommendation = "Ensure the policy is set to 'Enabled: All drives'." }
)

# Biometrics Checks
$biometricsChecks = @(
    @{ Name = "Configure enhanced anti-spoofing"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." }
)

# BitLocker Drive Encryption - Fixed Data Drives Checks
$bitLockerFixedDataDrivesChecks = @(
    @{ Name = "Allow access to BitLocker-protected fixed data drives from earlier versions of Windows"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the policy is set to 'Disabled'." },
    @{ Name = "Choose how BitLocker-protected fixed drives can be recovered"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." },
    @{ Name = "Choose how BitLocker-protected fixed drives can be recovered: Allow data recovery agent"; Value = "Enabled: True"; Type = "Automated"; ExpectedValue = "Enabled: True"; Recommendation = "Ensure the policy is set to 'Enabled: True'." },
    @{ Name = "Choose how BitLocker-protected fixed drives can be recovered: Recovery Password"; Value = "Enabled: Allow 48-digit recovery password"; Type = "Automated"; ExpectedValue = "Enabled: Allow 48-digit recovery password"; Recommendation = "Ensure the policy is set to 'Enabled: Allow 48-digit recovery password' or higher." },
    @{ Name = "Choose how BitLocker-protected fixed drives can be recovered: Recovery Key"; Value = "Enabled: Allow 256-bit recovery key"; Type = "Automated"; ExpectedValue = "Enabled: Allow 256-bit recovery key"; Recommendation = "Ensure the policy is set to 'Enabled: Allow 256-bit recovery key' or higher." },
    @{ Name = "Choose how BitLocker-protected fixed drives can be recovered: Omit recovery options from the BitLocker setup wizard"; Value = "Enabled: True"; Type = "Automated"; ExpectedValue = "Enabled: True"; Recommendation = "Ensure the policy is set to 'Enabled: True'." },
    @{ Name = "Choose how BitLocker-protected fixed drives can be recovered: Save BitLocker recovery information to AD DS for fixed data drives"; Value = "Enabled: False"; Type = "Automated"; ExpectedValue = "Enabled: False"; Recommendation = "Ensure the policy is set to 'Enabled: False'." },
    @{ Name = "Choose how BitLocker-protected fixed drives can be recovered: Configure storage of BitLocker recovery information to AD DS"; Value = "Enabled: Backup recovery passwords and key packages"; Type = "Automated"; ExpectedValue = "Enabled: Backup recovery passwords and key packages"; Recommendation = "Ensure the policy is set to 'Enabled: Backup recovery passwords and key packages'." },
    @{ Name = "Choose how BitLocker-protected fixed drives can be recovered: Do not enable BitLocker until recovery information is stored to AD DS for fixed data drives"; Value = "Enabled: False"; Type = "Automated"; ExpectedValue = "Enabled: False"; Recommendation = "Ensure the policy is set to 'Enabled: False'." },
    @{ Name = "Configure use of hardware-based encryption for fixed data drives"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the policy is set to 'Disabled'." },
    @{ Name = "Configure use of passwords for fixed data drives"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the policy is set to 'Disabled'." },
    @{ Name = "Configure use of smart cards on fixed data drives"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." },
    @{ Name = "Configure use of smart cards on fixed data drives: Require use of smart cards on fixed data drives"; Value = "Enabled: True"; Type = "Automated"; ExpectedValue = "Enabled: True"; Recommendation = "Ensure the policy is set to 'Enabled: True'." }
)

# BitLocker Drive Encryption - Operating System Drives Checks
$bitLockerOSDrivesChecks = @(
    @{ Name = "Allow enhanced PINs for startup"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." },
    @{ Name = "Allow Secure Boot for integrity validation"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." },
    @{ Name = "Choose how BitLocker-protected operating system drives can be recovered"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." },
    @{ Name = "Choose how BitLocker-protected operating system drives can be recovered: Allow data recovery agent"; Value = "Enabled: False"; Type = "Automated"; ExpectedValue = "Enabled: False"; Recommendation = "Ensure the policy is set to 'Enabled: False'." },
    @{ Name = "Choose how BitLocker-protected operating system drives can be recovered: Recovery Password"; Value = "Enabled: Require 48-digit recovery password"; Type = "Automated"; ExpectedValue = "Enabled: Require 48-digit recovery password"; Recommendation = "Ensure the policy is set to 'Enabled: Require 48-digit recovery password'." },
    @{ Name = "Choose how BitLocker-protected operating system drives can be recovered: Recovery Key"; Value = "Enabled: Do not allow 256-bit recovery key"; Type = "Automated"; ExpectedValue = "Enabled: Do not allow 256-bit recovery key"; Recommendation = "Ensure the policy is set to 'Enabled: Do not allow 256-bit recovery key'." },
    @{ Name = "Choose how BitLocker-protected operating system drives can be recovered: Omit recovery options from the BitLocker setup wizard"; Value = "Enabled: True"; Type = "Automated"; ExpectedValue = "Enabled: True"; Recommendation = "Ensure the policy is set to 'Enabled: True'." },
    @{ Name = "Choose how BitLocker-protected operating system drives can be recovered: Save BitLocker recovery information to AD DS for operating system drives"; Value = "Enabled: True"; Type = "Automated"; ExpectedValue = "Enabled: True"; Recommendation = "Ensure the policy is set to 'Enabled: True'." },
    @{ Name = "Choose how BitLocker-protected operating system drives can be recovered: Configure storage of BitLocker recovery information to AD DS"; Value = "Enabled: Store recovery passwords and key packages"; Type = "Automated"; ExpectedValue = "Enabled: Store recovery passwords and key packages"; Recommendation = "Ensure the policy is set to 'Enabled: Store recovery passwords and key packages'." },
    @{ Name = "Choose how BitLocker-protected operating system drives can be recovered: Do not enable BitLocker until recovery information is stored to AD DS for operating system drives"; Value = "Enabled: True"; Type = "Automated"; ExpectedValue = "Enabled: True"; Recommendation = "Ensure the policy is set to 'Enabled: True'." },
    @{ Name = "Configure use of hardware-based encryption for operating system drives"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the policy is set to 'Disabled'." },
    @{ Name = "Configure use of passwords for operating system drives"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the policy is set to 'Disabled'." },
    @{ Name = "Require additional authentication at startup"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." },
    @{ Name = "Require additional authentication at startup: Allow BitLocker without a compatible TPM"; Value = "Enabled: False"; Type = "Automated"; ExpectedValue = "Enabled: False"; Recommendation = "Ensure the policy is set to 'Enabled: False'." }
)

# Perform checks and generate reports
Get-ComplianceReport -Category "AppPrivacy" -Checks $appPrivacyChecks
Get-ComplianceReport -Category "AppRuntime" -Checks $appRuntimeChecks
Get-ComplianceReport -Category "AutoPlayPolicies" -Checks $autoPlayPoliciesChecks
Get-ComplianceReport -Category "Biometrics" -Checks $biometricsChecks
Get-ComplianceReport -Category "BitLockerFixedDataDrives" -Checks $bitLockerFixedDataDrivesChecks
Get-ComplianceReport -Category "BitLockerOSDrives" -Checks $bitLockerOSDrivesChecks

Write-Host "Compliance reports generated at: $outputDir"