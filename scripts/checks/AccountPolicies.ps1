
# # Define the report file
# $ReportPath = "./reports/Windows11_CIS_Report.xlsx"

# # Import necessary modules
# Import-Module ImportExcel

# # Define the output directory
# $outputDir = "$env:USERPROFILE\OneDrive\Documents\Windows11-CIS-Benchmark\reports"
# if (-not (Test-Path $outputDir)) {
#     New-Item -ItemType Directory -Path $outputDir | Out-Null
# }

# # Define the Excel report file
# $excelReport = "$outputDir\CIS_Compliance_Report.xlsx"

# # Function to check compliance and generate a report
# function Get-ComplianceReport {
#     param (
#         [string]$Category,
#         [array]$Checks
#     )

#     $report = @()

#     foreach ($check in $Checks) {
#         $checkName = $check.Name
#         $checkValue = $check.Value
#         $checkType = $check.Type
#         $expectedValue = $check.ExpectedValue
#         $recommendation = $check.Recommendation

#         # Perform the check
#         $complianceStatus = "Not Met"
#         if ($checkValue -eq $expectedValue) {
#             $complianceStatus = "Met"
#         }

#         # Add the result to the report
#         $report += [PSCustomObject]@{
#             Check           = $checkName
#             Compliance      = $complianceStatus
#             Recommendation  = $recommendation
#         }
#     }

#     # Export the report to Excel
#     $report | Export-Excel -Path $excelReport -WorksheetName $Category -AutoSize
# }

# # Password Policy Checks
# $passwordPolicyChecks = @(
#     @{ Name = "Enforce password history"; Value = 24; Type = "Automated"; ExpectedValue = 24; Recommendation = "Ensure the policy is set to 24 or more passwords." },
#     @{ Name = "Maximum password age"; Value = 365; Type = "Automated"; ExpectedValue = 365; Recommendation = "Ensure the policy is set to 365 or fewer days (but not 0)." },
#     @{ Name = "Minimum password age"; Value = 1; Type = "Automated"; ExpectedValue = 1; Recommendation = "Ensure the policy is set to 1 or more days." },
#     @{ Name = "Minimum password length"; Value = 14; Type = "Automated"; ExpectedValue = 14; Recommendation = "Ensure the policy is set to 14 or more characters." },
#     @{ Name = "Password must meet complexity requirements"; Value = $true; Type = "Automated"; ExpectedValue = $true; Recommendation = "Ensure the policy is enabled." },
#     @{ Name = "Relax minimum password length limits"; Value = $true; Type = "Automated"; ExpectedValue = $true; Recommendation = "Ensure the policy is enabled." },
#     @{ Name = "Store passwords using reversible encryption"; Value = $false; Type = "Automated"; ExpectedValue = $false; Recommendation = "Ensure the policy is disabled." }
# )

# # Account Lockout Policy Checks
# $accountLockoutPolicyChecks = @(
#     @{ Name = "Account lockout duration"; Value = 15; Type = "Automated"; ExpectedValue = 15; Recommendation = "Ensure the policy is set to 15 or more minutes." },
#     @{ Name = "Account lockout threshold"; Value = 5; Type = "Automated"; ExpectedValue = 5; Recommendation = "Ensure the policy is set to 5 or fewer invalid logon attempts (but not 0)." },
#     @{ Name = "Allow Administrator account lockout"; Value = $true; Type = "Manual"; ExpectedValue = $true; Recommendation = "Ensure the policy is enabled." },
#     @{ Name = "Reset account lockout counter after"; Value = 15; Type = "Automated"; ExpectedValue = 15; Recommendation = "Ensure the policy is set to 15 or more minutes." }
# )

# # User Rights Assignment Checks
# $userRightsAssignmentChecks = @(
#     @{ Name = "Access Credential Manager as a trusted caller"; Value = "No One"; Type = "Automated"; ExpectedValue = "No One"; Recommendation = "Ensure the policy is set to 'No One'." },
#     @{ Name = "Access this computer from the network"; Value = "Administrators, Remote Desktop Users"; Type = "Automated"; ExpectedValue = "Administrators, Remote Desktop Users"; Recommendation = "Ensure the policy is set to 'Administrators, Remote Desktop Users'." },
#     @{ Name = "Act as part of the operating system"; Value = "No One"; Type = "Automated"; ExpectedValue = "No One"; Recommendation = "Ensure the policy is set to 'No One'." },
#     @{ Name = "Allow log on locally"; Value = "Administrators, Users"; Type = "Automated"; ExpectedValue = "Administrators, Users"; Recommendation = "Ensure the policy is set to 'Administrators, Users'." },
#     @{ Name = "Allow log on through Remote Desktop Services"; Value = "Administrators, Remote Desktop Users"; Type = "Automated"; ExpectedValue = "Administrators, Remote Desktop Users"; Recommendation = "Ensure the policy is set to 'Administrators, Remote Desktop Users'." },
#     @{ Name = "Adjust memory quotas for a process"; Value = "Administrators, LOCAL SERVICE, NETWORK SERVICE"; Type = "Automated"; ExpectedValue = "Administrators, LOCAL SERVICE, NETWORK SERVICE"; Recommendation = "Ensure the policy is set to 'Administrators, LOCAL SERVICE, NETWORK SERVICE'." },
#     @{ Name = "Back up files and directories"; Value = "Administrators"; Type = "Automated"; ExpectedValue = "Administrators"; Recommendation = "Ensure the policy is set to 'Administrators'." },
#     @{ Name = "Change the system time"; Value = "Administrators, LOCAL SERVICE"; Type = "Automated"; ExpectedValue = "Administrators, LOCAL SERVICE"; Recommendation = "Ensure the policy is set to 'Administrators, LOCAL SERVICE'." },
#     @{ Name = "Change the time zone"; Value = "Administrators, LOCAL SERVICE, Users"; Type = "Automated"; ExpectedValue = "Administrators, LOCAL SERVICE, Users"; Recommendation = "Ensure the policy is set to 'Administrators, LOCAL SERVICE, Users'." },
#     @{ Name = "Create a pagefile"; Value = "Administrators"; Type = "Automated"; ExpectedValue = "Administrators"; Recommendation = "Ensure the policy is set to 'Administrators'." },
#     @{ Name = "Create a token object"; Value = "No One"; Type = "Automated"; ExpectedValue = "No One"; Recommendation = "Ensure the policy is set to 'No One'." },
#     @{ Name = "Create global objects"; Value = "Administrators, LOCAL SERVICE, NETWORK SERVICE, SERVICE"; Type = "Automated"; ExpectedValue = "Administrators, LOCAL SERVICE, NETWORK SERVICE, SERVICE"; Recommendation = "Ensure the policy is set to 'Administrators, LOCAL SERVICE, NETWORK SERVICE, SERVICE'." },
#     @{ Name = "Create permanent shared objects"; Value = "No One"; Type = "Automated"; ExpectedValue = "No One"; Recommendation = "Ensure the policy is set to 'No One'." },
#     @{ Name = "Create symbolic links"; Value = "Administrators"; Type = "Automated"; ExpectedValue = "Administrators"; Recommendation = "Ensure the policy is set to 'Administrators'." }
# )

# # Perform checks and generate reports
# Get-ComplianceReport -Category "Password Policy" -Checks $passwordPolicyChecks
# Get-ComplianceReport -Category "Account Lockout Policy" -Checks $accountLockoutPolicyChecks
# Get-ComplianceReport -Category "User Rights Assignment" -Checks $userRightsAssignmentChecks

# Write-Host "Compliance report generated at: $excelReport"

# Define the output directory
$outputDir = "$env:USERPROFILE\OneDrive\Documents\Windows11-CIS-Benchmark\reports"

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

# Password Policy Checks
$passwordPolicyChecks = @(
    @{ Name = "Enforce password history"; Value = 24; Type = "Automated"; ExpectedValue = 24; Recommendation = "Ensure the policy is set to 24 or more passwords." },
    @{ Name = "Maximum password age"; Value = 365; Type = "Automated"; ExpectedValue = 365; Recommendation = "Ensure the policy is set to 365 or fewer days (but not 0)." },
    @{ Name = "Minimum password age"; Value = 1; Type = "Automated"; ExpectedValue = 1; Recommendation = "Ensure the policy is set to 1 or more days." },
    @{ Name = "Minimum password length"; Value = 14; Type = "Automated"; ExpectedValue = 14; Recommendation = "Ensure the policy is set to 14 or more characters." },
    @{ Name = "Password must meet complexity requirements"; Value = $true; Type = "Automated"; ExpectedValue = $true; Recommendation = "Ensure the policy is enabled." },
    @{ Name = "Relax minimum password length limits"; Value = $true; Type = "Automated"; ExpectedValue = $true; Recommendation = "Ensure the policy is enabled." },
    @{ Name = "Store passwords using reversible encryption"; Value = $false; Type = "Automated"; ExpectedValue = $false; Recommendation = "Ensure the policy is disabled." }
)

# Account Lockout Policy Checks
$accountLockoutPolicyChecks = @(
    @{ Name = "Account lockout duration"; Value = 15; Type = "Automated"; ExpectedValue = 15; Recommendation = "Ensure the policy is set to 15 or more minutes." },
    @{ Name = "Account lockout threshold"; Value = 5; Type = "Automated"; ExpectedValue = 5; Recommendation = "Ensure the policy is set to 5 or fewer invalid logon attempts (but not 0)." },
    @{ Name = "Allow Administrator account lockout"; Value = $true; Type = "Manual"; ExpectedValue = $true; Recommendation = "Ensure the policy is enabled." },
    @{ Name = "Reset account lockout counter after"; Value = 15; Type = "Automated"; ExpectedValue = 15; Recommendation = "Ensure the policy is set to 15 or more minutes." }
)

# User Rights Assignment Checks
$userRightsAssignmentChecks = @(
    @{ Name = "Access Credential Manager as a trusted caller"; Value = "No One"; Type = "Automated"; ExpectedValue = "No One"; Recommendation = "Ensure the policy is set to 'No One'." },
    @{ Name = "Access this computer from the network"; Value = "Administrators, Remote Desktop Users"; Type = "Automated"; ExpectedValue = "Administrators, Remote Desktop Users"; Recommendation = "Ensure the policy is set to 'Administrators, Remote Desktop Users'." },
    @{ Name = "Act as part of the operating system"; Value = "No One"; Type = "Automated"; ExpectedValue = "No One"; Recommendation = "Ensure the policy is set to 'No One'." },
    @{ Name = "Allow log on locally"; Value = "Administrators, Users"; Type = "Automated"; ExpectedValue = "Administrators, Users"; Recommendation = "Ensure the policy is set to 'Administrators, Users'." },
    @{ Name = "Allow log on through Remote Desktop Services"; Value = "Administrators, Remote Desktop Users"; Type = "Automated"; ExpectedValue = "Administrators, Remote Desktop Users"; Recommendation = "Ensure the policy is set to 'Administrators, Remote Desktop Users'." },
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

# Perform checks and generate reports
Get-ComplianceReport -Category "PasswordPolicy" -Checks $passwordPolicyChecks
Get-ComplianceReport -Category "AccountLockoutPolicy" -Checks $accountLockoutPolicyChecks
Get-ComplianceReport -Category "UserRightsAssignment" -Checks $userRightsAssignmentChecks

Write-Host "Compliance reports generated at: $outputDir"