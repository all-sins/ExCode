# Process names.
# RIP. Don't have sufficient permissions to kill CMCounter.
# Repurposing as a popup killer.
$closableAnnoyingPopups = @("ACN_HelloforBusiness_Utility")
$annoyingPopupsThatNeedElevatedPermsToClose = @("CMCounter")
$waitSecondCount = 5
$previousProcessCount = 0
$verbose = $false

while ($true) {
    
    # Get all processes.
    $processes = Get-Process

    # Check if there are more processes than the last time we checked.
    if ($processes.Length -gt $previousProcessCount) {
        if ($verbose) {Write-Host $processes.Length ">" $previousProcessCount}

        # If there are more then search for the undesirable processes and kill them.
        Write-Host "[INFO] Scanning..."
        $processes | ForEach-Object -Process {
            if ($closableAnnoyingPopups -contains $_.Name) {
                Write-Host "[MATCH] $_ found. Deleting."
                $_.Kill()
            } else {
                # Otherwise just print the process in question and move on.
                if ($verbose) {Write-Host "[INFO] Scanning $_."}
            }
        }
    } else {
        Write-Host "[SLEEP] No new processes detected."
    }

    $previousProcessCount = $processes.Length
    Write-Host "[SLEEP] Sleeping..."
    Start-Sleep -Seconds $waitSecondCount
}