# Important to note that that subration is done
# in order. Second element is subtracted from
# the first one 100% of cases.
function Get-TimeDelta {
    param(
        [DateTime]$a,
	[DateTime]$b
    )
    return $a - $b
}

$now = Get-Date
./computeQ4-charCast.ps1
Write-Host -Foreground Cyan (Get-TimeDelta -a (Get-Date) -b $now)

$now = Get-Date
./computeQ4-modulus.ps1
Write-Host -Foreground Magenta (Get-TimeDelta -a (Get-Date) -b $now)
