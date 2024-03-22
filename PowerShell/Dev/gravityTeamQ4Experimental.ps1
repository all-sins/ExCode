###############################
# Consider rewriting in Java. #
###############################
$max = [Math]::Pow(10,12) 
$maxPerCore = $max / 8 # 125000000
$threads = 8
$analyticsThrottle = 5
Write-Host $maxPerCore
# Why are you not getting populated with data?
$sums = @([System.Int64]::new()) * 8

# Create a mutex for synchronization
$mutex = [System.Threading.Mutex]::new()

# Function to increment an element in the array in a synchronized manner
function AddValueToIndex {
    param([System.Int64]$value, [int]$index)
    $mutex.WaitOne() | Out-Null
    $sums[$index] = $sums[$index] + $value
    $debugInfo = "Thread-$index Updated sums[$index]: $($sums[$index])"
    $mutex.ReleaseMutex()
    Out-File -FilePath C:\Users\Tsu\add-value.log -Append -InputObject $debugInfo
}

# Function to increment an element in the array in a synchronized manner
function GetValueAtIndex {
    param([int]$index)
    $mutex.WaitOne() | Out-Null
    $returnTmp = $sums[$index]
    $debugInfo = "Thread-$index Returning sums[$index]: $returnTmp"
    $mutex.ReleaseMutex()
    Out-File -FilePath C:\Users\Tsu\get-value.log -Append -InputObject $debugInfo
    return $returnTmp
}

# Create and or clear log files.
if (Test-Path -Path C:\Users\Tsu\add-value.log) {
    Clear-Content -Path C:\Users\Tsu\add-value.log
} else {
    New-Item -ItemType File -Name add-value.log -Path C:\Users\Tsu\
}

if (Test-Path -Path C:\Users\Tsu\get-value.log) {
    Clear-Content -Path C:\Users\Tsu\get-value.log
} else {
    New-Item -ItemType File -Name get-value.log -Path C:\Users\Tsu\
}

if (Test-Path -Path C:\Users\Tsu\compute.log) {
    Clear-Content -Path C:\Users\Tsu\compute.log
} else {
    New-Item -ItemType File -Name compute.log -Path C:\Users\Tsu\
}

# Start jobs in parallel
$msg = ""
for ($j = 0; $j -lt $threads; $j++) {
    $start = $j * $maxPerCore
    $end = (($j + 1) * $maxPerCore) - 1
    if (($end -gt $max) -or ($j -eq $threads - 1)) {
      $end = $max
    }
    # Start-Job -ScriptBlock $computeJob -ArgumentList $start, $end, $j
    $index = $j
    Start-Job {
        Out-File -FilePath C:\Users\Tsu\tmp.file -Append -InputObject "$start $end $index"
        for ($i = $start; $i -lt $end; $i++) {
            Out-File -FilePath C:\Users\Tsu\tmp.file -Append -InputObject "Computing $i"
            $asStr = [String]$i
            [System.Int64]$tmp = 0
            foreach ($char in $asStr.ToCharArray()) {
                $tmp = $tmp + [int]::Parse($char)
            }
            Out-File -FilePath C:\Users\Tsu\tmp.file -Append -InputObject "Storing $i => $tmp"
            AddValueToIndex -value $tmp -index $index
        }
    }
    $msg += "[Thread-$j] $start $end`n"
}
Write-Host -ForegroundColor Cyan $msg

# Wait for all jobs to finish and print analytic data
Write-Host -ForegroundColor Magenta "[ANALYTICS] Starting..."
$analyticsItteration = 0

# Why does this not work?
# Just jumps past one itteration and then exits. :(
while (Get-Job -State "Running") {
    $currentSUM = 0
    $tmp = @(0) * 8
    for ($i = 0; $i -lt 8; $i++) {
        $tmp[$i] = GetValueAtIndex -index $i
        $currentSUM += $tmp[$i]
        Write-Host -ForegroundColor Cyan -NoNewline "[Thread-$i] "
        Write-Host -ForegroundColor Blue $tmp[$i]
    }
    Write-Host "CurrentSUM: " $currentSUM
    Write-Host
    Start-Sleep -Seconds $analyticsThrottle
    $analyticsItteration++
}
Write-Host -ForegroundColor Green "COMPUTE-DONE!"

Write-Host "Writing results to file..."
if (-not (Test-Path -Path ~\gravityTeamQ4.result)) {
  New-Item -ItemType File -Path ~\ -Name gravityTeamQ4.result
}
#Clear-Content -Path ~\gravityTeamQ4.result
# Retrieve results and save them.
Out-File -FilePath ~\gravityTeamQ4.result -Append -InputObject $(Get-Job | Receive-Job -Keep)
Write-Host -ForegroundColor Green "WRITE-DONE!"

# Clean-up threads.
Write-Host "Removing Jobs..."
foreach ($job in Get-Job) {
  Stop-Job $job
  Remove-Job $job
}