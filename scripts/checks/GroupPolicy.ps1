# Define the output directory
# Group Policy, Internet Communication Management, iSCSI, KDC, Kerberos, Kernel DMA Protection, LAPS, Local Security Authority, Locale Services, Logon, App and Device Inventory, and App Package Deployment check
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

# Group Policy Checks
$groupPolicyChecks = @(
    @{ Name = "Configure registry policy processing: Do not apply during periodic background processing"; Value = "Enabled: FALSE"; Type = "Automated"; ExpectedValue = "Enabled: FALSE"; Recommendation = "Ensure the policy is set to 'Enabled: FALSE'." },
    @{ Name = "Configure registry policy processing: Process even if the Group Policy objects have not changed"; Value = "Enabled: TRUE"; Type = "Automated"; ExpectedValue = "Enabled: TRUE"; Recommendation = "Ensure the policy is set to 'Enabled: TRUE'." },
    @{ Name = "Configure security policy processing: Do not apply during periodic background processing"; Value = "Enabled: FALSE"; Type = "Automated"; ExpectedValue = "Enabled: FALSE"; Recommendation = "Ensure the policy is set to 'Enabled: FALSE'." },
    @{ Name = "Configure security policy processing: Process even if the Group Policy objects have not changed"; Value = "Enabled: TRUE"; Type = "Automated"; ExpectedValue = "Enabled: TRUE"; Recommendation = "Ensure the policy is set to 'Enabled: TRUE'." },
    @{ Name = "Continue experiences on this device"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the policy is set to 'Disabled'." },
    @{ Name = "Turn off background refresh of Group Policy"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the policy is set to 'Disabled'." }
)

# Internet Communication Management Checks
$internetCommunicationManagementChecks = @(
    @{ Name = "Turn off access to the Store"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." },
    @{ Name = "Turn off downloading of print drivers over HTTP"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." },
    @{ Name = "Turn off handwriting personalization data sharing"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." },
    @{ Name = "Turn off handwriting recognition error reporting"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." },
    @{ Name = "Turn off Internet Connection Wizard if URL connection is referring to Microsoft.com"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." },
    @{ Name = "Turn off Internet download for Web publishing and online ordering wizards"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." },
    @{ Name = "Turn off printing over HTTP"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." },
    @{ Name = "Turn off Registration if URL connection is referring to Microsoft.com"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." },
    @{ Name = "Turn off Search Companion content file updates"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." },
    @{ Name = "Turn off the 'Order Prints' picture task"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." },
    @{ Name = "Turn off the 'Publish to Web' task for files and folders"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." },
    @{ Name = "Turn off the Windows Messenger Customer Experience Improvement Program"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." },
    @{ Name = "Turn off Windows Customer Experience Improvement Program"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." },
    @{ Name = "Turn off Windows Error Reporting"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." }
)

# Kerberos Checks
$kerberosChecks = @(
    @{ Name = "Support device authentication using certificate"; Value = "Enabled: Automatic"; Type = "Automated"; ExpectedValue = "Enabled: Automatic"; Recommendation = "Ensure the policy is set to 'Enabled: Automatic'." }
)

# Kernel DMA Protection Checks
$kernelDMAProtectionChecks = @(
    @{ Name = "Enumeration policy for external devices incompatible with Kernel DMA Protection"; Value = "Enabled: Block All"; Type = "Automated"; ExpectedValue = "Enabled: Block All"; Recommendation = "Ensure the policy is set to 'Enabled: Block All'." }
)

# LAPS Checks
$lapsChecks = @(
    @{ Name = "Configure password backup directory"; Value = "Enabled: Active Directory"; Type = "Automated"; ExpectedValue = "Enabled: Active Directory"; Recommendation = "Ensure the policy is set to 'Enabled: Active Directory' or 'Enabled: Azure Active Directory'." },
    @{ Name = "Do not allow password expiration time longer than required by policy"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." },
    @{ Name = "Enable password encryption"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." },
    @{ Name = "Password Settings: Password Complexity"; Value = "Enabled: Large letters + small letters + numbers + special characters"; Type = "Automated"; ExpectedValue = "Enabled: Large letters + small letters + numbers + special characters"; Recommendation = "Ensure the policy is set to 'Enabled: Large letters + small letters + numbers + special characters'." },
    @{ Name = "Password Settings: Password Length"; Value = "Enabled: 15 or more"; Type = "Automated"; ExpectedValue = "Enabled: 15 or more"; Recommendation = "Ensure the policy is set to 'Enabled: 15 or more'." },
    @{ Name = "Password Settings: Password Age (Days)"; Value = "Enabled: 30 or fewer"; Type = "Automated"; ExpectedValue = "Enabled: 30 or fewer"; Recommendation = "Ensure the policy is set to 'Enabled: 30 or fewer'." },
    @{ Name = "Post-authentication actions: Grace period (hours)"; Value = "Enabled: 8 or fewer hours, but not 0"; Type = "Automated"; ExpectedValue = "Enabled: 8 or fewer hours, but not 0"; Recommendation = "Ensure the policy is set to 'Enabled: 8 or fewer hours, but not 0'." },
    @{ Name = "Post-authentication actions: Actions"; Value = "Enabled: Reset the password and logoff the managed account"; Type = "Automated"; ExpectedValue = "Enabled: Reset the password and logoff the managed account"; Recommendation = "Ensure the policy is set to 'Enabled: Reset the password and logoff the managed account' or higher." }
)

# Local Security Authority Checks
$localSecurityAuthorityChecks = @(
    @{ Name = "Allow Custom SSPs and APs to be loaded into LSASS"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the policy is set to 'Disabled'." },
    @{ Name = "Configures LSASS to run as a protected process"; Value = "Enabled: Enabled with UEFI Lock"; Type = "Automated"; ExpectedValue = "Enabled: Enabled with UEFI Lock"; Recommendation = "Ensure the policy is set to 'Enabled: Enabled with UEFI Lock'." }
)

# Locale Services Checks
$localeServicesChecks = @(
    @{ Name = "Disallow copying of user input methods to the system account for sign-in"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." }
)

# Logon Checks
$logonChecks = @(
    @{ Name = "Block user from showing account details on sign-in"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." },
    @{ Name = "Do not display network selection UI"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." },
    @{ Name = "Do not enumerate connected users on domain-joined computers"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." }
)

# App and Device Inventory Checks
$appDeviceInventoryChecks = @(
    @{ Name = "Turn off API Sampling"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." },
    @{ Name = "Turn off Application Footprint"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." },
    @{ Name = "Turn off Install Tracing"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." }
)

# App Package Deployment Checks
$appPackageDeploymentChecks = @(
    @{ Name = "Allow a Windows app to share application data between users"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the policy is set to 'Disabled'." },
    @{ Name = "Not allow per-user unsigned packages to install by default (requires explicitly allow per install)"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." },
    @{ Name = "Prevent non-admin users from installing packaged Windows apps"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." }
)

# Perform checks and generate reports
Get-ComplianceReport -Category "GroupPolicy" -Checks $groupPolicyChecks
Get-ComplianceReport -Category "InternetCommunicationManagement" -Checks $internetCommunicationManagementChecks
Get-ComplianceReport -Category "Kerberos" -Checks $kerberosChecks
Get-ComplianceReport -Category "KernelDMAProtection" -Checks $kernelDMAProtectionChecks
Get-ComplianceReport -Category "LAPS" -Checks $lapsChecks
Get-ComplianceReport -Category "LocalSecurityAuthority" -Checks $localSecurityAuthorityChecks
Get-ComplianceReport -Category "LocaleServices" -Checks $localeServicesChecks
Get-ComplianceReport -Category "Logon" -Checks $logonChecks
Get-ComplianceReport -Category "AppDeviceInventory" -Checks $appDeviceInventoryChecks
Get-ComplianceReport -Category "AppPackageDeployment" -Checks $appPackageDeploymentChecks

Write-Host "Compliance reports generated at: $outputDir"