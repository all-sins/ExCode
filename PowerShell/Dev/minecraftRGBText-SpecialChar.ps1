# Define command-line arguments.
param (
    # Text to add RGB to.
    [string]$inputString = "Lorem ipsum!"
)

$schar = "§"
# $pchar = @("0","1","2","3","4","5","6","7","8","9") # Full colors.
# $pchar = @("1","2","3","4","5","6","7","8","9") # No black.
# $pchar = @("1","2","4") # RGB only.
# $pchar = @("6","2","4") # YGR only.
$pchar = @("2","3","4","5","6") # YGR only.

$rgbAppliedString = ""
$lastRand = ""
for ($i = 0; $i -lt $inputString.Length; $i++) {
    do {$rand = Get-Random -InputObject $pchar} while ($rand -eq $lastRand)
    $rgbAppliedString = $rgbAppliedString+$schar+$rand+$inputString.Substring($i, 1)
    $lastRand = $rand
}
Write-Host $rgbAppliedString
$rgbAppliedString | Set-Clipboard