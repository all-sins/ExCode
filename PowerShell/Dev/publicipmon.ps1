# Public IP CLI Monitor v0.1
# Especially useful for LTE connections.
# -Tsu
Clear-Host
$i = 0;
$firstRun = $true;
while ($true) {
  $tmp = (Invoke-WebRequest -uri "https://api.ipify.org/").Content
  if ($tmp -eq $last) {
    if ($firstRun) {Write-Host $tmp}
    $i++
    $comp1 = "["
    $comp2 = "] "
    $pattern = $comp1+$i+$comp2;
    Write-Host $pattern -NoNewline
  } else {$i = 0}
  $last = $tmp
  Start-Sleep -Seconds 1
}