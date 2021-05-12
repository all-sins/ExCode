# All of this is pointless because execution of anything is not possible without correct execution policy. Still cool though.


# Set the execution policy to restricted to simulate default configuration.
# Set-ExecutionPolicy Restricted

$verbose = $true

# Check the PS execution policy on the users system
$executionPolicy = Get-ExecutionPolicy
if ($executionPolicy -ne "Unrestricted") {
    # Atempt to change the execution policy.
    Write-Host "Current policy set to $executionPolicy."
    Write-Host "Atempting to change the execution policy!"
    try {
        Set-ExecutionPolicy Unrestricted -Scope Process -Force
    } catch {
        Write-Host "Failed to set execution policy"
        Write-Host "Press any key to exit..."
        Read-Host
        exit
    }
} else {
    if ($verbose) {
        Write-Host "Current policy set to $executionPolicy."
        Write-Host "Changing of execution policy not needed."
    }
}