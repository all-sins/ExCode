param([Parameter(Mandatory)]$minutes = 60)

$WShell = New-Object -com "Wscript.Shell"

if ($minutes -eq 0) {
    Echo "[INF] Keep-alive with Scroll Lock..."
    while ($true)
    {
      $WShell.sendkeys("{SCROLLLOCK}")
      Start-Sleep -Milliseconds 100
      $WShell.sendkeys("{SCROLLLOCK}")
      Start-Sleep -Seconds 240
    }
} else {
    for ($i = 0; $i -lt $minutes; $i++) {
      $WShell.sendkeys("{SCROLLLOCK}")
      Start-Sleep -Milliseconds 100
      $WShell.sendkeys("{SCROLLLOCK}")
      Clear-Host
      Echo "[$minutes] Keep-alive with Scroll Lock..."
      $i--;
      Start-Sleep -Seconds 240
    }
}

