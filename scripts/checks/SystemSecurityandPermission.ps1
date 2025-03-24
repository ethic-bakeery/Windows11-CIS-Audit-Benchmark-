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

# System and Security Permissions Checks
$systemSecurityPermissionsChecks = @(
    @{ Name = "Adjust memory quotas for a process"; Value = "Administrators, LOCAL SERVICE, NETWORK SERVICE"; Type = "Automated"; ExpectedValue = "Administrators, LOCAL SERVICE, NETWORK SERVICE"; Recommendation = "Ensure the policy is set to 'Administrators, LOCAL SERVICE, NETWORK SERVICE'." },
    @{ Name = "Back up files and directories"; Value = "Administrators"; Type = "Automated"; ExpectedValue = "Administrators"; Recommendation = "Ensure the policy is set to 'Administrators'." },
    @{ Name = "Change the system time"; Value = "Administrators, LOCAL SERVICE"; Type = "Automated"; ExpectedValue = "Administrators, LOCAL SERVICE"; Recommendation = "Ensure the policy is set to 'Administrators, LOCAL SERVICE'." },
    @{ Name = "Change the time zone"; Value = "Administrators, LOCAL SERVICE, Users"; Type = "Automated"; ExpectedValue = "Administrators, LOCAL SERVICE, Users"; Recommendation = "Ensure the policy is set to 'Administrators, LOCAL SERVICE, Users'." },
    @{ Name = "Create a pagefile"; Value = "Administrators"; Type = "Automated"; ExpectedValue = "Administrators"; Recommendation = "Ensure the policy is set to 'Administrators'." },
    @{ Name = "Create a token object"; Value = "No One"; Type = "Automated"; ExpectedValue = "No One"; Recommendation = "Ensure the policy is set to 'No One'." },
    @{ Name = "Create global objects"; Value = "Administrators, LOCAL SERVICE, NETWORK SERVICE, SERVICE"; Type = "Automated"; ExpectedValue = "Administrators, LOCAL SERVICE, NETWORK SERVICE, SERVICE"; Recommendation = "Ensure the policy is set to 'Administrators, LOCAL SERVICE, NETWORK SERVICE, SERVICE'." },
    @{ Name = "Create permanent shared objects"; Value = "No One"; Type = "Automated"; ExpectedValue = "No One"; Recommendation = "Ensure the policy is set to 'No One'." },
    @{ Name = "Create symbolic links"; Value = "Administrators"; Type = "Automated"; ExpectedValue = "Administrators"; Recommendation = "Ensure the policy is set to 'Administrators'." }
)

# Administrative and Debugging Rights Checks
$administrativeDebuggingRightsChecks = @(
    @{ Name = "Debug programs"; Value = "Administrators"; Type = "Automated"; ExpectedValue = "Administrators"; Recommendation = "Ensure the policy is set to 'Administrators'." },
    @{ Name = "Deny access to this computer from the network"; Value = "Guests, Local account"; Type = "Automated"; ExpectedValue = "Guests, Local account"; Recommendation = "Ensure the policy is set to 'Guests, Local account'." },
    @{ Name = "Deny log on as a batch job"; Value = "Guests"; Type = "Automated"; ExpectedValue = "Guests"; Recommendation = "Ensure the policy is set to 'Guests'." },
    @{ Name = "Deny log on as a service"; Value = "Guests"; Type = "Automated"; ExpectedValue = "Guests"; Recommendation = "Ensure the policy is set to 'Guests'." },
    @{ Name = "Deny log on locally"; Value = "Guests"; Type = "Automated"; ExpectedValue = "Guests"; Recommendation = "Ensure the policy is set to 'Guests'." },
    @{ Name = "Deny log on through Remote Desktop Services"; Value = "Guests, Local account"; Type = "Automated"; ExpectedValue = "Guests, Local account"; Recommendation = "Ensure the policy is set to 'Guests, Local account'." },
    @{ Name = "Enable computer and user accounts to be trusted for delegation"; Value = "No One"; Type = "Automated"; ExpectedValue = "No One"; Recommendation = "Ensure the policy is set to 'No One'." }
)

# System Control and Audit Checks
$systemControlAuditChecks = @(
    @{ Name = "Force shutdown from a remote system"; Value = "Administrators"; Type = "Automated"; ExpectedValue = "Administrators"; Recommendation = "Ensure the policy is set to 'Administrators'." },
    @{ Name = "Generate security audits"; Value = "LOCAL SERVICE, NETWORK SERVICE"; Type = "Automated"; ExpectedValue = "LOCAL SERVICE, NETWORK SERVICE"; Recommendation = "Ensure the policy is set to 'LOCAL SERVICE, NETWORK SERVICE'." },
    @{ Name = "Impersonate a client after authentication"; Value = "Administrators, LOCAL SERVICE, NETWORK SERVICE, SERVICE"; Type = "Automated"; ExpectedValue = "Administrators, LOCAL SERVICE, NETWORK SERVICE, SERVICE"; Recommendation = "Ensure the policy is set to 'Administrators, LOCAL SERVICE, NETWORK SERVICE, SERVICE'." },
    @{ Name = "Increase scheduling priority"; Value = "Administrators, Window Manager\Window Manager Group"; Type = "Automated"; ExpectedValue = "Administrators, Window Manager\Window Manager Group"; Recommendation = "Ensure the policy is set to 'Administrators, Window Manager\Window Manager Group'." },
    @{ Name = "Load and unload device drivers"; Value = "Administrators"; Type = "Automated"; ExpectedValue = "Administrators"; Recommendation = "Ensure the policy is set to 'Administrators'." },
    @{ Name = "Lock pages in memory"; Value = "No One"; Type = "Automated"; ExpectedValue = "No One"; Recommendation = "Ensure the policy is set to 'No One'." },
    @{ Name = "Log on as a batch job"; Value = "Administrators"; Type = "Automated"; ExpectedValue = "Administrators"; Recommendation = "Ensure the policy is set to 'Administrators'." },
    @{ Name = "Log on as a service"; Value = "Configured"; Type = "Automated"; ExpectedValue = "Configured"; Recommendation = "Ensure the policy is set to 'Configured'." },
    @{ Name = "Manage auditing and security log"; Value = "Administrators"; Type = "Automated"; ExpectedValue = "Administrators"; Recommendation = "Ensure the policy is set to 'Administrators'." },
    @{ Name = "Modify an object label"; Value = "No One"; Type = "Automated"; ExpectedValue = "No One"; Recommendation = "Ensure the policy is set to 'No One'." },
    @{ Name = "Modify firmware environment values"; Value = "Administrators"; Type = "Automated"; ExpectedValue = "Administrators"; Recommendation = "Ensure the policy is set to 'Administrators'." },
    @{ Name = "Perform volume maintenance tasks"; Value = "Administrators"; Type = "Automated"; ExpectedValue = "Administrators"; Recommendation = "Ensure the policy is set to 'Administrators'." },
    @{ Name = "Profile single process"; Value = "Administrators"; Type = "Automated"; ExpectedValue = "Administrators"; Recommendation = "Ensure the policy is set to 'Administrators'." },
    @{ Name = "Profile system performance"; Value = "Administrators, NT SERVICE\WdiServiceHost"; Type = "Automated"; ExpectedValue = "Administrators, NT SERVICE\WdiServiceHost"; Recommendation = "Ensure the policy is set to 'Administrators, NT SERVICE\WdiServiceHost'." },
    @{ Name = "Replace a process level token"; Value = "LOCAL SERVICE, NETWORK SERVICE"; Type = "Automated"; ExpectedValue = "LOCAL SERVICE, NETWORK SERVICE"; Recommendation = "Ensure the policy is set to 'LOCAL SERVICE, NETWORK SERVICE'." },
    @{ Name = "Restore files and directories"; Value = "Administrators"; Type = "Automated"; ExpectedValue = "Administrators"; Recommendation = "Ensure the policy is set to 'Administrators'." },
    @{ Name = "Shut down the system"; Value = "Administrators, Users"; Type = "Automated"; ExpectedValue = "Administrators, Users"; Recommendation = "Ensure the policy is set to 'Administrators, Users'." },
    @{ Name = "Take ownership of files or other objects"; Value = "Administrators"; Type = "Automated"; ExpectedValue = "Administrators"; Recommendation = "Ensure the policy is set to 'Administrators'." }
)

# Perform checks and generate reports
Get-ComplianceReport -Category "SystemSecurityPermissions" -Checks $systemSecurityPermissionsChecks
Get-ComplianceReport -Category "AdministrativeDebuggingRights" -Checks $administrativeDebuggingRightsChecks
Get-ComplianceReport -Category "SystemControlAudit" -Checks $systemControlAuditChecks

Write-Host "Compliance reports generated at: $outputDir"