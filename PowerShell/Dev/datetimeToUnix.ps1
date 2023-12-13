function datetimeToUnix {
  param([DateTime] $dt)
  $universal = $dt.ToUniversalTime()
  $daylightsavings = $universal.AddHours(2)
  $subtractEpoch = $daylightsavings.Subtract((Get-Date "1970-01-01"))
  return $subtractEpoch.TotalSeconds
}


$tmp = New-Object DateTime
$tmp = $tmp.AddYears(2022) # start
Write-Host "Start: $(datetimeToUnix -dt $tmp)"

$tmp = $tmp.AddHours(23)
$tmp = $tmp.AddMinutes(59)
$tmp = $tmp.AddSeconds(59)
Write-Host "End: $(datetimeToUnix -dt $tmp)"