# Change these variables to regulate program behaviour.
$delayMS = 1000
$poolSize = 50

# Do not change these varibables.
$iteration = 0
$tempMAX = 0

while ($true) {
    # Retrieve object with connection data. Use -Count 1 to be able to access properties.
    $data = Test-Connection 8.8.8.8 -Count 1
    
    # Print out ping value with appropriate color.
    if ($data.ResponseTime -le 30) {Write-Host -ForegroundColor Cyan $data.ResponseTime}
    elseif ($data.ResponseTime -le 50) {Write-Host -ForegroundColor Magenta $data.ResponseTime}
    elseif ($data.ResponseTime -le 70) {Write-Host -ForegroundColor Green $data.ResponseTime}
    elseif ($data.ResponseTime -le 100) {Write-Host -ForegroundColor Yellow $data.ResponseTime}
    elseif ($data.ResponseTime -le 150) {Write-Host -ForegroundColor DarkYellow $data.ResponseTime}
    elseif ($data.ResponseTime -le 200) {Write-Host -ForegroundColor Red $data.ResponseTime}
    elseif ($data.ResponseTime -le 250) {Write-Host -ForegroundColor DarkRed $data.ResponseTime}
    else {Write-Host -ForegroundColor DarkRed ">250ms"}
    
    # Find out max ping
    if ($data.ResponseTime -gt $tempMAX) {
        $tempMAX = $data.ResponseTime
    }

    # Once iteration count is met, reset counter and print out status.
    if ($iteration -ge $poolSize) {
        if ($tempMAX -le 50) {Write-Host -ForegroundColor Magenta "Game on!"}
        elseif ($tempMAX -le 100) {Write-Host -ForegroundColor Yellow "Good!"}
        elseif ($tempMAX -le 150) {Write-Host -ForegroundColor DarkYellow "Okay-ish."}
        elseif ($tempMAX -le 200) {Write-Host -ForegroundColor Red "Good luck."}
        elseif ($tempMAX -le 250) {Write-Host -ForegroundColor DarkRed "Don't play."}
        else {Write-Host -ForegroundColor DarkRed -BackgroundColor Gray "You're fucked."}
        Write-Host ""

        # Reset varibables for next cycle.
        $iteration = 0
        $tempMAX = 0
    } else {
        $iteration++
    }
    
    # Regulate how fast the program runs.
    Start-Sleep -Milliseconds $delayMS
}
