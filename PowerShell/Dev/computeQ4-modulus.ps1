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

function Get-SumOfDigits {
    param (
        [int]$n
    )
    $digitSum = 0
    while ($n -gt 0) {
        $digitSum += $n % 10
        $n = [math]::floor($n / 10)
    }
    return $digitSum
}

[System.Int64]$sum = 0

Write-Host "[RANGE] $start-$end"
for ([System.Int64]$i = $start; $i -lt $end; $i++) {
    [System.Int64]$tmp = Get-SumOfDigits -n $i
    $sum = $sum + (Get-SumOfDigits -n $i)
    
    #if ($i % 10 -ne 0) {
    #    Write-Host -NoNewline "$tmp "
    #} else {
    #    Write-Host "$tmp [$i] {$sum}"
    #     $f = 0
    #}

    #if ($i % 1000000 -eq 0) {
    #    $debugInfo = "[$i] {$sum}"
    #    Out-File -FilePath .\q4.log -Append -InputObject $debugInfo
    #
    
    # Seems to take too long. Bug???
    #if ($i % 1000000 -eq 0) {Write-Host $i}
}
Write-Host -ForegroundColor Green $sum
