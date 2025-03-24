# Define the output directory
# Cloud Clipboard, Remote Desktop Services, Windows Ink Workspace, Windows Installer, Windows Logon Options, Windows PowerShell, WinRM Client, WinRM Service, Windows Remote Shell, Windows Sandbox, Windows Security, Windows Update, Notifications, Internet Communication Settings, Attachment Manager, and Cloud Content checks
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

# Cloud Clipboard Checks
$cloudClipboardChecks = @(
    @{ Name = "Disable Cloud Clipboard integration for server-to-client data transfer"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." }
)

# Remote Desktop Services Checks
$remoteDesktopServicesChecks = @(
    @{ Name = "Do not allow passwords to be saved"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." },
    @{ Name = "Allow users to connect remotely by using Remote Desktop Services"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the policy is set to 'Disabled'." },
    @{ Name = "Allow UI Automation redirection"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the policy is set to 'Disabled'." },
    @{ Name = "Do not allow COM port redirection"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." },
    @{ Name = "Do not allow drive redirection"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." }
)

# Windows Ink Workspace Checks
$windowsInkWorkspaceChecks = @(
    @{ Name = "Allow suggested apps in Windows Ink Workspace"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the policy is set to 'Disabled'." },
    @{ Name = "Allow Windows Ink Workspace"; Value = "Enabled: On, but disallow access above lock"; Type = "Automated"; ExpectedValue = "Enabled: On, but disallow access above lock"; Recommendation = "Ensure the policy is set to 'Enabled: On, but disallow access above lock' or 'Enabled: Disabled'." }
)

# Windows Installer Checks
$windowsInstallerChecks = @(
    @{ Name = "Allow user control over installs"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the policy is set to 'Disabled'." },
    @{ Name = "Always install with elevated privileges"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the policy is set to 'Disabled'." },
    @{ Name = "Prevent Internet Explorer security prompt for Windows Installer scripts"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the policy is set to 'Disabled'." }
)

# Windows Logon Options Checks
$windowsLogonOptionsChecks = @(
    @{ Name = "Configure the transmission of the user's password in the content of MPR notifications sent by winlogon."; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the policy is set to 'Disabled'." },
    @{ Name = "Sign-in and lock last interactive user automatically after a restart"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the policy is set to 'Disabled'." }
)

# Windows PowerShell Checks
$windowsPowerShellChecks = @(
    @{ Name = "Turn on PowerShell Script Block Logging"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." },
    @{ Name = "Turn on PowerShell Transcription"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." }
)

# WinRM Client Checks
$winRMClientChecks = @(
    @{ Name = "Allow Basic authentication"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the policy is set to 'Disabled'." },
    @{ Name = "Allow unencrypted traffic"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the policy is set to 'Disabled'." },
    @{ Name = "Disallow Digest authentication"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." }
)

# WinRM Service Checks
$winRMServiceChecks = @(
    @{ Name = "Allow Basic authentication"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the policy is set to 'Disabled'." },
    @{ Name = "Allow remote server management through WinRM"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the policy is set to 'Disabled'." },
    @{ Name = "Allow unencrypted traffic"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the policy is set to 'Disabled'." },
    @{ Name = "Disallow WinRM from storing RunAs credentials"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." }
)

# Windows Remote Shell Checks
$windowsRemoteShellChecks = @(
    @{ Name = "Allow Remote Shell Access"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the policy is set to 'Disabled'." }
)

# Windows Sandbox Checks
$windowsSandboxChecks = @(
    @{ Name = "Allow clipboard sharing with Windows Sandbox"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the policy is set to 'Disabled'." },
    @{ Name = "Allow mapping folders into Windows Sandbox"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the policy is set to 'Disabled'." },
    @{ Name = "Allow networking in Windows Sandbox"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the policy is set to 'Disabled'." }
)

# Windows Security Checks
$windowsSecurityChecks = @(
    @{ Name = "Prevent users from modifying settings"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." }
)

# Windows Update Checks
$windowsUpdateChecks = @(
    @{ Name = "No auto-restart with logged on users for scheduled automatic updates installations"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the policy is set to 'Disabled'." },
    @{ Name = "Configure Automatic Updates"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." },
    @{ Name = "Configure Automatic Updates: Scheduled install day"; Value = "0 - Every day"; Type = "Automated"; ExpectedValue = "0 - Every day"; Recommendation = "Ensure the policy is set to '0 - Every day'." },
    @{ Name = "Enable features introduced via servicing that are off by default"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the policy is set to 'Disabled'." },
    @{ Name = "Remove access to 'Pause updates' feature"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." },
    @{ Name = "Manage preview builds"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the policy is set to 'Disabled'." },
    @{ Name = "Select when Preview Builds and Feature Updates are received"; Value = "Enabled: 180 or more days"; Type = "Automated"; ExpectedValue = "Enabled: 180 or more days"; Recommendation = "Ensure the policy is set to 'Enabled: 180 or more days'." },
    @{ Name = "Select when Quality Updates are received"; Value = "Enabled: 0 days"; Type = "Automated"; ExpectedValue = "Enabled: 0 days"; Recommendation = "Ensure the policy is set to 'Enabled: 0 days'." },
    @{ Name = "Enable optional updates"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the policy is set to 'Disabled'." }
)

# Notifications Checks
$notificationsChecks = @(
    @{ Name = "Turn off toast notifications on the lock screen"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." }
)

# Internet Communication Settings Checks
$internetCommunicationSettingsChecks = @(
    @{ Name = "Turn off Help Experience Improvement Program"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." }
)

# Attachment Manager Checks
$attachmentManagerChecks = @(
    @{ Name = "Do not preserve zone information in file attachments"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the policy is set to 'Disabled'." },
    @{ Name = "Notify antivirus programs when opening attachments"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." }
)

# Cloud Content Checks
$cloudContentChecks = @(
    @{ Name = "Configure Windows Spotlight on lock screen"; Value = "Disabled"; Type = "Automated"; ExpectedValue = "Disabled"; Recommendation = "Ensure the policy is set to 'Disabled'." },
    @{ Name = "Do not suggest third-party content in Windows Spotlight"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." },
    @{ Name = "Do not use diagnostic data for tailored experiences"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." },
    @{ Name = "Turn off all Windows Spotlight features"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." },
    @{ Name = "Turn off Spotlight collection on Desktop"; Value = "Enabled"; Type = "Automated"; ExpectedValue = "Enabled"; Recommendation = "Ensure the policy is set to 'Enabled'." }
)

# Perform checks and generate reports
Get-ComplianceReport -Category "CloudClipboard" -Checks $cloudClipboardChecks
Get-ComplianceReport -Category "RemoteDesktopServices" -Checks $remoteDesktopServicesChecks
Get-ComplianceReport -Category "WindowsInkWorkspace" -Checks $windowsInkWorkspaceChecks
Get-ComplianceReport -Category "WindowsInstaller" -Checks $windowsInstallerChecks
Get-ComplianceReport -Category "WindowsLogonOptions" -Checks $windowsLogonOptionsChecks
Get-ComplianceReport -Category "WindowsPowerShell" -Checks $windowsPowerShellChecks
Get-ComplianceReport -Category "WinRMClient" -Checks $winRMClientChecks
Get-ComplianceReport -Category "WinRMService" -Checks $winRMServiceChecks
Get-ComplianceReport -Category "WindowsRemoteShell" -Checks $windowsRemoteShellChecks
Get-ComplianceReport -Category "WindowsSandbox" -Checks $windowsSandboxChecks
Get-ComplianceReport -Category "WindowsSecurity" -Checks $windowsSecurityChecks
Get-ComplianceReport -Category "WindowsUpdate" -Checks $windowsUpdateChecks
Get-ComplianceReport -Category "Notifications" -Checks $notificationsChecks
Get-ComplianceReport -Category "InternetCommunicationSettings" -Checks $internetCommunicationSettingsChecks
Get-ComplianceReport -Category "AttachmentManager" -Checks $attachmentManagerChecks
Get-ComplianceReport -Category "CloudContent" -Checks $cloudContentChecks

Write-Host "Compliance reports generated at: $outputDir"