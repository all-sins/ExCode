$URL = "www.microsoft.com"
$waitS = 2

# This is a demo on how to work with IE as a COM object.
# The following command gets the same results as the example below.
# $IE1 = New-Object -COMObject InternetExplorer.Application -Property @{Navigate2="www.microsoft.com"; Visible = $True}

Write-Host "Creating COM object <InternetExplorer.Application>."
$IE2 = New-Object -COMObject InternetExplorer.Application
Start-Sleep -Seconds $waitS

Write-Host "Navigating to $URL."
$IE2.Navigate2($URL)
Start-Sleep -Seconds $waitS

Write-Host "Revealing window."
$IE2.Visible = $True
Start-Sleep -Seconds $waitS

Write-Host "Navigating to www.duckduckgo.com."
$IE2.Navigate2("www.duckduckgo.com")
Start-Sleep -Seconds $waitS

Write-Host "Hiding window."
$IE2.Visible = $False
Start-Sleep -Seconds $waitS

Write-Host "Navigating to www.google.com."
$IE2.Navigate2("www.google.com")
Start-Sleep -Seconds $waitS

Write-Host "Revealing window."
$IE2.Visible = $True
Start-Sleep -Seconds $waitS

Write-Host "Closing."
$tmpie.Quit()
Start-Sleep -Seconds $waitS