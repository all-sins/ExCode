# Start range value of January 1, 2023
$startDate = Get-Date -Year 2023 -Month 01 -Day 01 -Hour 00 -Minute 00 -Second 00 -Millisecond 000
$endDate = $startDate.AddHours(24).AddMilliseconds(-1)  # Subtract 1 millisecond to get the end of the day

# Convert the start and end dates to Unix time in milliseconds
$startTimeUnix = [math]::truncate((Get-Date $startDate).ToUniversalTime().Subtract((Get-Date "1970-01-01")).TotalMilliseconds)
$endTimeUnix = [math]::truncate((Get-Date $endDate).ToUniversalTime().Subtract((Get-Date "1970-01-01")).TotalMilliseconds)

# Print out range that will be used:
Write-Host "Range ["$startDate.ToString("yyyy-MM-dd HH:mm:ss.fff")" - "$endDate.ToString("yyyy-MM-dd HH:mm:ss.fff")"]"
Write-Host "Range ["$startTimeUnix" - "$endTimeUnix"]"

# Construct the API query URL
$apiEndpoint = "https://api.binance.com"
$apiTarget = "/api/v3/aggTrades"
$spotPairSymbol = "ETHUSDT"
$pageMax = 1000
$totalProcessed = 0
$firstRun = $true

# Pagination loop to retrieve all relevant results. Range for API is inclusive.
do { 
    if ($firstRun) {
        $apiInvokeURL = "$apiEndpoint$apiTarget?symbol=$spotPairSymbol&limit=$pageMax&startTime=$startTimeUnix&endTime=$endTimeUnix"
	$firstRun = $false
    } else {
	# New API URL and URL parameter to use for pagination after the first iteration of the loop.
        $apiInvokeURL = "$apiEndpoint$apiTarget?symbol=$spotPairSymbol&limit=$pageMax&startTime=$startTimeUnix&endTime=$endTimeUnix&fromId=$lastId"
    }

    # Results for $fromId API call are inclusive.
    #                                 Ignore
    #                                      v
    # 1,  2,  3,  4,  5,  6,  7,  8,  9,  10
    # 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, ...
    # ^
    # Start
    #
    # First request will fetch 1-10. Need to ignore last result, since that will be used for
    # the next iteration of the loop unless there are no more results, which we can check
    # by looking at if we got less results than the $pageMax variable passed into $limit parameter.

    # Display the API query URL and fire it.
    Write-Host -ForegroundColor Green "[From $lastId] $apiInvokeURL"
    Write-Host -ForegroundColor White -NoNewLine
    Invoke-WebRequest -URI $apiInvokeURL -OutVariable response | Out-Null

    # Display status of invocation:
    Write-Host -ForegroundColor White -NoNewLine

    # Parse JSON, compute statistics, find last ID to use for pagination.
    $parsedJson = $response.Content | ConvertFrom-Json -AsHashTable 
    $jsonCount = $parsedJson.Count
    $totalProcessed = $totalProcessed + ($jsonCount - 2) # -1 for index and -1 for pagination
    $lastId = $parsedJson.Get($jsonCount - 2).a
    
    $lastProcessedIndex = $jsonCount - 2 
    Write-Host "totalProcessed/jsonCount/lastProcessedIndex/lastId"
    Write-Host "$totalProcessed/$jsonCount/$lastProcessedIndex/$lastId"
} while ($jsonCount -eq $pageMax)
