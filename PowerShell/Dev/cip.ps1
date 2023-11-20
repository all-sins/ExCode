# Define command-line arguments.
param (
    # Interval between pings.
    [int]$delayMS = 1000,
    
    # Amount of pings to gather before printing status.
    [int]$poolSize = 10,

    # Silently log latency to CSV file.
    [boolean]$silentLog = $false,

    # Max timeout for ICMP pings in seconds.
    [int]$icmpTimeout = 10
)

# Adresses to ping.
$googleDNS_1 = "8.8.8.8"
$googleDNS_2 = "8.8.4.4"
$openDNS_1 = "208.67.222.222"
$openDNS_2 = "208.67.220.220"

# Status code translations for the WMI ping class.
$StatusCodes = @{
    [uint32]0     = 'Success';
    [uint32]11001 = 'Buffer Too Small';
    [uint32]11002 = 'Destination Net Unreachable';
    [uint32]11003 = 'Destination Host Unreachable';
    [uint32]11004 = 'Destination Protocol Unreachable';
    [uint32]11005 = 'Destination Port Unreachable';
    [uint32]11006 = 'No Resources';
    [uint32]11007 = 'Bad Option';
    [uint32]11008 = 'Hardware Error';
    [uint32]11009 = 'Packet Too Big';
    [uint32]11010 = 'Request Timed Out';
    [uint32]11011 = 'Bad Request';
    [uint32]11012 = 'Bad Route';
    [uint32]11013 = 'TimeToLive Expired Transit';
    [uint32]11014 = 'TimeToLive Expired Reassembly';
    [uint32]11015 = 'Parameter Problem';
    [uint32]11016 = 'Source Quench';
    [uint32]11017 = 'Option Too Big';
    [uint32]11018 = 'Bad Destination';
    [uint32]11032 = 'Negotiating IPSEC';
    [uint32]11050 = 'General Failure'
};

# Do not change these varibables.
$iteration = 0
$tempMAX1 = 0
$tempMAX2 = 0
$tempMAX3 = 0
$tempMAX4 = 0
$spacingToggle = $false

function printWithColor {
    param (
        [Parameter(Mandatory)]
        [int] $ms,
        [Parameter(Mandatory)]
        [int] $pos
    )
    
    # TO DO
    # IMPLEMENT LOGIC TO FIX UGLY SPACING
    # MAYBE SOMETHING LIKE THIS
    # if ($ms -gt 99) {Write-Host "<less_spaces>"}
    # ANY OTHER WAY TO MESSURE THE CHARACTER LENGTH OF AN INT? :think:
    # Clean up ugly elseif chain in favor of a switch statement.
    if ($ms -eq 0) {Write-Host -NoNewline -ForegroundColor DarkRed ">999ms"}
    elseif ($ms -le 30) {Write-Host -NoNewline -ForegroundColor Cyan $ms}
    elseif ($ms -le 50) {Write-Host -NoNewline -ForegroundColor Magenta $ms}
    elseif ($ms -le 70) {Write-Host -NoNewline -ForegroundColor Green $ms}
    elseif ($ms -le 100) {Write-Host -NoNewline -ForegroundColor Yellow $ms}
    elseif ($ms -le 150) {Write-Host -NoNewline -ForegroundColor DarkYellow $ms}
    elseif ($ms -le 200) {Write-Host -NoNewline -ForegroundColor Red $ms}
    elseif ($ms -le 250) {Write-Host -NoNewline -ForegroundColor DarkRed $ms}
    else {Write-Host -NoNewline -ForegroundColor DarkRed ">250ms"}
    
    # Spacing.
    if ($pos -ne 4) {Write-Host -NoNewline ([char]9)([char]9)}
}

function printStatusWithColor {
    param(
        [Parameter(Mandatory)]
        [int] $maxMS,
        [Parameter(Mandatory)]
        [String] $msg
    )

    Write-Host -NoNewline $msg
    if ($maxMS -le 50) {
        Write-Host -ForegroundColor Magenta "Game on!"
    } elseif ($maxMS -le 100) {
        Write-Host -ForegroundColor Yellow "Good!"
    } elseif ($maxMS -le 150) {
        Write-Host -ForegroundColor DarkYellow "Okay-ish."
    } elseif ($maxMS -le 200) {
        Write-Host -ForegroundColor Red "Good luck."
    } elseif ($maxMS -le 250) {
        Write-Host -ForegroundColor DarkRed "Don't play."
    } else {
        Write-Host -ForegroundColor DarkRed -BackgroundColor Gray "You're fucked."
    }
}

while ($true) {
    # Retrieve object with connection data.
    $googleDNS_1_ping = (Test-Connection -TargetName $googleDNS_1 -Count 1 -TimeoutSeconds $icmpTimeout -ErrorAction SilentlyContinue).Latency;
    $googleDNS_2_ping = (Test-Connection -TargetName $googleDNS_2 -Count 1 -TimeoutSeconds $icmpTimeout -ErrorAction SilentlyContinue).Latency;
    $openDNS_1_ping = (Test-Connection -TargetName $openDNS_1 -Count 1 -TimeoutSeconds $icmpTimeout -ErrorAction SilentlyContinue).Latency;
    $openDNS_2_ping = (Test-Connection -TargetName $openDNS_2 -Count 1 -TimeoutSeconds $icmpTimeout -ErrorAction SilentlyContinue).Latency;
    
    if (-not $silentLog) {
        # Print out ping value with appropriate color.
        printWithColor $googleDNS_1_ping 1
        printWithColor $googleDNS_2_ping 2
        printWithColor $openDNS_1_ping 3
        printWithColor $openDNS_2_ping 4
        Write-Host ""
    
        # Find out max ping
        if ($googleDNS_1_ping -gt $tempMAX1) {
            $tempMAX1 = $googleDNS_1_ping
        }

        if ($googleDNS_2_ping -gt $tempMAX2) {
            $tempMAX2 = $googleDNS_2_ping
        }

        if ($openDNS_1_ping -gt $tempMAX3) {
            $tempMAX3 = $openDNS_1_ping
        }

        if ($openDNS_2_ping -gt $tempMAX4) {
            $tempMAX4 = $openDNS_2_ping
        }

        # Once iteration count is met, reset counter and print out status.
        if ($iteration -ge $poolSize) {
            printStatusWithColor $tempMAX1 "GoogleDNS1: "
            printStatusWithColor $tempMAX2 "GoogleDNS2: "
            printStatusWithColor $tempMAX3 "OpenDNS1: "
            printStatusWithColor $tempMAX4 "OpenDNS2: "

            # Reset varibables for next cycle.
            $iteration = 0
            $tempMAX1 = $tempMAX2 = $tempMAX3 = $tempMAX4 = 0
        } else {
            $iteration++
        }
    } else {
        if (-not (Test-Path -Path .\cip.log)) {
	    New-Item -Path . -Name cip.log
	}
	$nowUnixTime = [math]::Floor((Get-Date).ToUniversalTime().Subtract((Get-Date "1970-01-01")).TotalSeconds)
	Add-Content -Path .\cip.log -Value "$nowUnixTime,$googleDNS_1_ping,$googleDNS_2_ping,$openDNS_1_ping,$openDNS_2_ping";
    }    
    
    # Regulate how fast the program runs.
    Start-Sleep -Milliseconds $delayMS
}
