param (
    # Start index.
    [int]$start = 0,

    # End index.
    [int]$end = 99
)

[System.Int64]$sum = 0

Write-Host "[RANGE] $start-$end"
for ($i = $start; $i -lt $end; $i++) {
    $asStr = [String]$i
    [System.Int64]$tmp = 0
    foreach ($char in $asStr.ToCharArray()) {
        if ($char -ne "0") {
	        $tmp = $tmp + [int]::Parse($char)
	    }
    }
$sum = $sum + $tmp
}

$sum

(1+2+3+4+5+6+7+8+9)*10