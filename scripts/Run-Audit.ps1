# RunAllScripts.ps1

# Define the path where the scripts are located
$scriptPath = "C:\Users\cryfo\OneDrive\Documents\Windows11-CIS-Benchmark\scripts\checks"

# List of scripts to run
$scriptFiles = @(
    "AccountPolicies.ps1",
    "AppFunctionality.ps1",
    "AttackSurfaceReduction.ps1",
    "BuilinAppsOptimimazation.ps1",
    "FileSystemWiredNetworkPolicies.ps1",
    "GroupPolicy.ps1",
    "MiscellaneousServices.ps1",
    "SecurityOptionChecks.ps1",
    "SystemSecurityandPermission.ps1",
    "SystemServices.ps1",
    "WindowsSecurityAndFeaturesCheck.ps1"
)

# Run each script
foreach ($script in $scriptFiles) {
    $scriptFullPath = Join-Path -Path $scriptPath -ChildPath $script
    Write-Host "Running $scriptFullPath..."
    & $scriptFullPath
}
