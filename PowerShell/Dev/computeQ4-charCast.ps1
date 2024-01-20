param (
    # Start index.
    [int]$start = 0,

    # End index.
    [int]$end = 100
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
    $sum = $sum + $tmp
}
Write-Host -ForegroundColor Green $sum
