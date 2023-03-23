
############
# <CONFIG> #
############
# Password properties.
$passLong = 16

# Enable character sets.
$enableSymbols = $true
$enableNumbers = $true
$enableUpper = $true
$enableLower = $true
 
# Declare character sets.
$symbols = "[]?=:;/+|*@!#$%&'(),-.\^_``{}~<>"
$numbers = "0123456789"
$upper = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
$lower = "abcdefghijklmnopqrstuvwxyz"
#############
# </CONFIG> #
#############

$symbolsObj = New-Object -TypeName psobject
Add-Member -InputObject $symbolsObj -MemberType NoteProperty -Name Chars -Value $symbols
Add-Member -InputObject $symbolsObj -MemberType NoteProperty -Name Enable -Value $enableSymbols

$numbersObj = New-Object -TypeName psobject
Add-Member -InputObject $numbersObj -MemberType NoteProperty -Name Chars -Value $numbers
Add-Member -InputObject $numbersObj -MemberType NoteProperty -Name Enable -Value $enableNumbers

$upperObj = New-Object -TypeName psobject
Add-Member -InputObject $upperObj -MemberType NoteProperty -Name Chars -Value $upper
Add-Member -InputObject $upperObj -MemberType NoteProperty -Name Enable -Value $enableUpper

$lowerObj = New-Object -TypeName psobject
Add-Member -InputObject $lowerObj -MemberType NoteProperty -Name Chars -Value $lower
Add-Member -InputObject $lowerObj -MemberType NoteProperty -Name Enable -Value $enableLower

$charObjs = $symbolsObj, $numbersObj, $upperObj, $lowerObj

$charPool = ""
foreach ($charObj in $charObjs) {
  if ($charObj.Enable) {
    $charPool += $charObj.Chars
  }
}

$genPass = ""
$charPool = $charPool.ToCharArray()
for ($i = 0; $i -lt $passLong; $i++) {
  $randInRange = Get-Random -Maximum $charPool.Length -Minimum 0
  $genPass += $charPool[$randInRange]
}

Write-Host $genPass
