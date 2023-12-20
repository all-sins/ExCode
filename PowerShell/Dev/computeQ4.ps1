param (
    # Start index.
    [int]$start = 0,

    # End index.
    [int]$end = 100,

    # Interval for analytics.
    [int]$analyticsInterval = 10000,

    # Stdout analytics throttle.
    [int]$analyticsThrottleSec = 1
)

[System.Int64]$sum = 0

Write-Host "[RANGE] $start-$end"
for ($i = $start; $i -lt $end; $i++) {
    # Write-Host "Computing $i"
    $asStr = [String]$i
    [System.Int64]$tmp = 0
    foreach ($char in $asStr.ToCharArray()) {
        if ($char -ne "0") {
	    $tmp = $tmp + [int]::Parse($char)
	}
    }
    # Write-Host "$calcPerSec calculations per second"
    $modulusHeadache = $i
    if ($i -eq 0) {
        $modulusHeadache = $i++
    }
    # Write-Host "$modulusHeadache % $interval"
    if ($modulusHeadache % $analyticsInterval -eq 0) {
        Write-Host $i
    }
    # Write-Host "$i $tmp"
#Write-Host "Storing $i => $tmp"
$sum = $sum + $tmp
}
