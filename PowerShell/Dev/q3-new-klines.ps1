function sumDigits {
    param(
        [Parameter(Mandatory)]
        [String] $number,
        [Parameter(Mandatory)]
        [Char] $delimiter
    )
    $floatingPoint = $number.Split($delimiter).Get(1)
    $floatingPoint
    $asStr = [String]$floatingPoint
    [System.Int64]$sum = 0
    foreach ($char in $asStr.ToCharArray()) {
        if ($char -ne "0") {
            $sum = $sum + [int]::Parse($char)
        }
    }
    return $sum
}

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
$spotPairSymbol = "ETHUSDT"
# $interval = "3m"  # Granularity.
$totalProcessed = 0

###########################################################################################
# IDEA: USE GRANULARITY 1000 OR WHATEVER AND LOOP THROUGH WITH LOWEST AVAILABLE PERCISION #
###########################################################################################
# &limit=1000&interval=1s&startTime=0&endTime=1000
# &limit=1000&interval=1s&startTime=1001&endTime=2000
# &limit=1000&interval=1s&startTime=2001&endTime=3000
# etc. etc.
# UNTIL YOU GET EVERYTHING MUHAHUHUAHAHA
# IT IS 3AM I NEED SLEEP

for ($j = 1; $j -le 60; $j++) {
    $interval = $j.ToString()+"m"
    $apiInvokeURL = "$apiEndpoint/api/v3/uiKlines?symbol=$spotPairSymbol&limit=1000&interval=$interval&startTime=$startTimeUnix&endTime=$endTimeUnix"
    # /api/v3/klines
    # /api/v3/uiKlines

    1196.87958333
    1196.87958333
    # Display the API query URL and fire it.
    Write-Host -ForegroundColor Green "[From $lastId] $apiInvokeURL"
    Write-Host -ForegroundColor White -NoNewLine
    try {
        Invoke-WebRequest -URI $apiInvokeURL -OutVariable response | Out-Null

        # Parse JSON, compute statistics, find last ID to use for pagination.
        $parsedJson = $response.Content | ConvertFrom-Json -AsHashTable 
        $jsonCount = $parsedJson.Count
        $totalProcessed = $totalProcessed + ($jsonCount - 1) # -1 for index
        # lastId = $parsedJson.Get($jsonCount - 1).a

        $lastProcessedIndex = $jsonCount - 1
        Write-Host "totalProcessed/jsonCount/lastProcessedIndex"
        Write-Host "$totalProcessed/$jsonCount/$lastProcessedIndex"

        $sum = 0
        foreach ($item in $parsedJson) {
            $sum = $sum + $item.Get(4)
        }
        $average = $sum / $parsedJson.Count
        Write-Host "Before 8 digit trunc: $average"
        $average = [math]::truncate($average * 100000000) / 100000000
        Write-Host "After 8 digit trunc : $average"
        sumDigits $average '.'
    } catch {
        Write-Host -ForegroundColor Red "API didn't like $interval"
        Write-Host -ForegroundColor White -NoNewline
    }
}