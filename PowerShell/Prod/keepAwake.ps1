Clear-Host
Echo "Keep awake."

$WShell = New-Object -com "Wscript.Shell"
$sleep = 30


while ($true)
{
  Write-Host "[INFO] SL DOWN"
  $WShell.sendkeys("{SCROLLLOCK}")

  Write-Host "[INFO] SLEEP 100MS"
  Start-Sleep -Milliseconds 100

  Write-Host "[INFO] SL DOWN"
  $WShell.sendkeys("{SCROLLLOCK}")

  Write-Host "[INFO] SLEEP" $sleep "S" 
  Start-Sleep -Seconds $sleep
}