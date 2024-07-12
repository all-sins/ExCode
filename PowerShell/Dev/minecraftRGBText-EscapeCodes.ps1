# Define command-line arguments.
param (
    # Text to add RGB to.
    [string]$inputString = "Lorem ipsum!"
)

# Gold, Blue, Green, Aqua, Red, Light Purple, White respectively.
$pchar = @("\u00A76","\u00A79","\u00A7a","\u00A7b","\u00A7c","\u00A7d","\u00A7f")

$rgbAppliedString = ""
$lastRand = ""
for ($i = 0; $i -lt $inputString.Length; $i++) {
    do {$rand = Get-Random -InputObject $pchar} while ($rand -eq $lastRand)
    $rgbAppliedString = $rgbAppliedString+$schar+$rand+$inputString.Substring($i, 1)
    $lastRand = $rand
}
Write-Host $rgbAppliedString
$rgbAppliedString | Set-Clipboard
