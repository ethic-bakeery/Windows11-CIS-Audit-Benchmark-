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

# Security Options - Accounts Checks
$securityOptionsAccountsChecks = @(
    @{ Name = "Guest account status"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the policy is set to 'Disabled'." },
    @{ Name = "Limit local account use of blank passwords to console logon only"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." },
    @{ Name = "Rename administrator account"; Value = "Configured"; Type = "Automated"; ExpectedValue = "Configured"; Recommendation = "Ensure the policy is set to 'Configured'." },
    @{ Name = "Rename guest account"; Value = "Configured"; Type = "Automated"; ExpectedValue = "Configured"; Recommendation = "Ensure the policy is set to 'Configured'." }
)

# Security Options - Audit Policies Checks
$securityOptionsAuditPoliciesChecks = @(
    @{ Name = "Force audit policy subcategory settings (Windows Vista or later) to override audit policy category settings"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." },
    @{ Name = "Shut down system immediately if unable to log security audits"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the policy is set to 'Disabled'." }
)

# Security Options - Device and Printer Policies Checks
$securityOptionsDevicePrinterPoliciesChecks = @(
    @{ Name = "Prevent users from installing printer drivers"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." }
)

# Security Options - Domain Member Policies Checks
$securityOptionsDomainMemberPoliciesChecks = @(
    @{ Name = "Digitally encrypt or sign secure channel data (always)"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." },
    @{ Name = "Digitally encrypt secure channel data (when possible)"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." },
    @{ Name = "Digitally sign secure channel data (when possible)"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." },
    @{ Name = "Disable machine account password changes"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the policy is set to 'Disabled'." },
    @{ Name = "Maximum machine account password age"; Value = 30; Type = "Automated"; ExpectedValue = 30; Recommendation = "Ensure the policy is set to 30 or fewer days (but not 0)." },
    @{ Name = "Require strong (Windows 2000 or later) session key"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." }
)

# Security Options - Interactive Logon Policies Checks
$securityOptionsInteractiveLogonPoliciesChecks = @(
    @{ Name = "Do not require CTRL+ALT+DEL"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the policy is set to 'Disabled'." },
    @{ Name = "Don’t display last signed-in"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." },
    @{ Name = "Machine account lockout threshold"; Value = 10; Type = "Automated"; ExpectedValue = 10; Recommendation = "Ensure the policy is set to 10 or fewer invalid logon attempts (but not 0)." }
)

# Security Options - System Objects Checks
$securityOptionsSystemObjectsChecks = @(
    @{ Name = "System objects: Require case insensitivity for non-Windows subsystems"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." },
    @{ Name = "System objects: Strengthen default permissions of internal system objects (e.g. Symbolic Links)"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." }
)

# Security Options - User Account Control (UAC) Checks
$securityOptionsUACChecks = @(
    @{ Name = "User Account Control: Admin Approval Mode for the Built-in Administrator account"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." },
    @{ Name = "User Account Control: Behavior of the elevation prompt for administrators in Admin Approval Mode"; Value = "Prompt for consent on the secure desktop"; Type = "Automated"; ExpectedValue = "Prompt for consent on the secure desktop"; Recommendation = "Ensure the policy is set to 'Prompt for consent on the secure desktop' or higher." },
    @{ Name = "User Account Control: Behavior of the elevation prompt for standard users"; Value = "Automatically deny elevation requests"; Type = "Automated"; ExpectedValue = "Automatically deny elevation requests"; Recommendation = "Ensure the policy is set to 'Automatically deny elevation requests'." },
    @{ Name = "User Account Control: Detect application installations and prompt for elevation"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." },
    @{ Name = "User Account Control: Only elevate UIAccess applications that are installed in secure locations"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." },
    @{ Name = "User Account Control: Run all administrators in Admin Approval Mode"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." },
    @{ Name = "User Account Control: Switch to the secure desktop when prompting for elevation"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." },
    @{ Name = "User Account Control: Virtualize file and registry write failures to per-user locations"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." }
)

# Perform checks and generate reports
Get-ComplianceReport -Category "SecurityOptionsAccounts" -Checks $securityOptionsAccountsChecks
Get-ComplianceReport -Category "SecurityOptionsAuditPolicies" -Checks $securityOptionsAuditPoliciesChecks
Get-ComplianceReport -Category "SecurityOptionsDevicePrinterPolicies" -Checks $securityOptionsDevicePrinterPoliciesChecks
Get-ComplianceReport -Category "SecurityOptionsDomainMemberPolicies" -Checks $securityOptionsDomainMemberPoliciesChecks
Get-ComplianceReport -Category "SecurityOptionsInteractiveLogonPolicies" -Checks $securityOptionsInteractiveLogonPoliciesChecks
Get-ComplianceReport -Category "SecurityOptionsSystemObjects" -Checks $securityOptionsSystemObjectsChecks
Get-ComplianceReport -Category "SecurityOptionsUAC" -Checks $securityOptionsUACChecks

Write-Host "Compliance reports generated at: $outputDir"