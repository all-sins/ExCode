# Start range value of January 1, 2023
$startDate = Get-Date -Year 2023 -Month 01 -Day 01 -Hour 00 -Minute 00 -Second 00 -Millisecond 000
$endDate = $startDate.AddHours(24).AddMilliseconds(-1)  # Subtract 1 millisecond to get the end of the day

# Convert the start and end dates to Unix time in milliseconds
$startTimeUnix = (Get-Date $startDate -UnixTimeSeconds).TotalMilliseconds)
$endTimeUnix = (Get-Date $endDate -UnixTimeSeconds).TotalMilliseconds)

# Print out range that will be used:
Write-Host "Range ["$startDate.ToString("yyyy-MM-dd HH:mm:ss.fff")" - "$endDate.ToString("yyyy-MM-dd HH:mm:ss.fff")"]"
Write-Host "Range ["$startTimeUnix" - "$endTimeUnix"]"

# Construct the API query URL
$apiEndpoint = "https://api.binance.com"
$spotPairSymbol = "ETHUSDT"
$pageMax = 1000
$apiInvokeURL = "/api/v3/aggTrades?symbol=$spotPairSymbol&limit=$pageMax&startTime=$startTimeUnix&endTime=$endTimeUnix"

# Display the API query URL
Write-Host "API Query URL: $apiInvokeURL"

