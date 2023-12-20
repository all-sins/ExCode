param (
    # Start index.
    [int]$start = 0,

    # End index.
    [System.Int64]$end = 100,

    # Interval for analytics.
    [int]$analyticsInterval = 10000,

    # Stdout analytics throttle.
    [int]$analyticsThrottleSec = 1
)

[System.Int64]$sum = 0

Write-Host "[RANGE] $start-$end"
for ([System.Int64]$i = $start; $i -lt $end; $i++) {
    # Write-Host "Computing $i"
    $asStr = [String]$i
    [System.Int64]$tmp = 0
    # $f = 1
    foreach ($char in $asStr.ToCharArray()) {
	$tmp = $tmp + [int]::Parse($char)
	$sum = $sum + $tmp
    }
    # $f++
    #if ($i % 10 -ne 0) {
        # Write-Host -NoNewline "$tmp "
    #} else {
        # Write-Host "$tmp [$i] {$sum}"
	# $f = 0
    #}
    if ($i % 1000000 -eq 0) {
        $debugInfo = "[$i] {$sum}"
        Out-File -FilePath .\q4.log -Append -InputObject $debugInfo
    }
}
Write-Host
Write-Host -ForegroundColor Green $sum
