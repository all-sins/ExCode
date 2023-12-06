function f {
  param(
    [Parameter(Mandatory)]
    [String] $text,
    [Parameter(Mandatory)]
    [String] $color,
    [Parameter(Mandatory)]
    [boolean] $newline
  )

  if ($newline) {
    Write-Host -ForegroundColor $color $text
  } else {
    Write-Host -ForegroundColor $color -NoNewline $text
  }
}

function printColoredSquares {
  $colors = [Enum]::GetValues([System.ConsoleColor]);
  foreach ($color in $colors) {
    Write-Host -NoNewline -ForegroundColor $color ▮
  }
}

# Build dashes.
$strBuild = ""
$unicodeBox = [char]0x25AE
for ($i = 0; $i -lt $pcInfo.CsUserName.length; $i++) {
  $strBuild += $unicodeBox
}

# Get ComputerInfo object.
$pcInfo = Get-ComputerInfo

# Calculate human readable memory values.
$ramAsMB = $pcInfo.CsPhyicallyInstalledMemory / 1024
$ramAsGB = $ramAsMB / 1024

# Fetch Win32_VideoController object.
$Win32_VideoController = Get-WmiObject -Class Win32_VideoController

# Fetch GPU memory value from Registry as other options are limited to a 32bit uint value which is inaccurate for values about 4GB.
# TODO:
# also, do you always pick first GPU and not the GPU with the most VRAM?
# OG.Tsu 🎃 — Today at 3:49 PM
# Are you referring to the list of Processors it returns?
$gpuMemorySizeInBytes = (Get-ItemProperty -Path "HKLM:\SYSTEM\ControlSet001\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0*" -Name HardwareInformation.qwMemorySize -ErrorAction SilentlyContinue)."HardwareInformation.qwMemorySize"
$gpuMemorySizeInGB = $gpuMemorySizeInBytes.ToInt64() / 1024 / 1024 / 1024

# Format uptime properly, since directly accessing a member of GetComputer-Info returns the value surrounded by " ".
$uptimeDay = $pcInfo.OsUptime.Days.ToString().Replace(" ", "")
$uptimeHrs = $pcInfo.OsUptime.Hours.ToString().Replace(" ", "")
$uptimeMin = $pcInfo.OsUptime.Minutes.ToString().Replace(" ", "")
$uptimeSec = $pcInfo.OsUptime.Seconds.ToString().Replace(" ", "")
$uptimeFormated = $uptimeDay+"d "+$uptimeHrs+"h "+$uptimeMin+"m "+$uptimeSec+"s"

# Control variable for spacing between ASCII and info text.
$spacing = "    "

# Print ASCII art with system information.
# TODO: Find a way to do this in a prettier syntax.
f -text "                          ....iilll" -color "Green" -newline $false; Write-Host -NoNewline $spacing; Write-Host $pcInfo.CsUserName;
f -text "                ....iilllllllllllll" -color "Green" -newline $false; Write-Host -NoNewline $spacing; Write-Host $strBuild;
f -text "    ....iillll"  -color "Red" -newline $false;  f -text "  lllllllllllllllllll" -color "Green" -newline $false; Write-Host $spacing"OS: " -NoNewline -ForegroundColor Magenta; Write-Host $pcInfo.OsName" ("$pcInfo.OsVersion") "$pcInfo.OsArchitecture
f -text "iillllllllllll"  -color "Red" -newline $false;  f -text "  lllllllllllllllllll" -color "Green" -newline $false; Write-Host $spacing"MB: " -NoNewline -ForegroundColor Magenta; Write-Host $pcInfo.CsModel" ("$pcInfo.CsManufacturer")"
f -text "llllllllllllll"  -color "Red" -newline $false;  f -text "  lllllllllllllllllll" -color "Green" -newline $false; Write-Host $spacing"CPU: " -NoNewline -ForegroundColor Magenta; Write-Host $pcInfo.CsProcessors.Name" ("$pcInfo.CsProcessors.NumberOfCores" cores)"
f -text "llllllllllllll"  -color "Red" -newline $false;  f -text "  lllllllllllllllllll" -color "Green" -newline $false; Write-Host $spacing"RAM: " -NoNewline -ForegroundColor Magenta; Write-Host $ramAsGB" GB ("$ramAsMB" MB)"
f -text "llllllllllllll"  -color "Red" -newline $false;  f -text "  lllllllllllllllllll" -color "Green" -newline $false; Write-Host $spacing"GPU: " -NoNewline -ForegroundColor Magenta; Write-Host $Win32_VideoController.Name" ("$gpuMemorySizeInGB" GB)"
f -text "llllllllllllll"  -color "Red" -newline $false;  f -text "  lllllllllllllllllll" -color "Green" -newline $false; Write-Host $spacing"Display: " -NoNewline -ForegroundColor Magenta; Write-Host $Win32_VideoController.CurrentHorizontalResolution" x "$Win32_VideoController.CurrentVerticalResolution" @ "$Win32_VideoController.MaxRefreshRate" Hz"
f -text "llllllllllllll"  -color "Red" -newline $false;  f -text "  lllllllllllllllllll" -color "Green" -newline $false; Write-Host $spacing"Uptime: " -NoNewline -ForegroundColor Magenta; Write-Host $uptimeFormated
f -text "                                   " -color "Green" -newline $true
f -text "llllllllllllll"  -color "Cyan" -newline $false;  f -text "  lllllllllllllllllll" -color "Yellow" -newline $false; Write-Host $spacing -NoNewline; printColoredSquares; Write-Host
f -text "llllllllllllll"  -color "Cyan" -newline $false;  f -text "  lllllllllllllllllll" -color "Yellow" -newline $true
f -text "llllllllllllll"  -color "Cyan" -newline $false;  f -text "  lllllllllllllllllll" -color "Yellow" -newline $true
f -text "llllllllllllll"  -color "Cyan" -newline $false;  f -text "  lllllllllllllllllll" -color "Yellow" -newline $true
f -text "llllllllllllll"  -color "Cyan" -newline $false;  f -text "  lllllllllllllllllll" -color "Yellow" -newline $true
f -text "``^^^^^^lllllll"  -color "Cyan" -newline $false;  f -text "  lllllllllllllllllll" -color "Yellow" -newline $true
f -text "      ````````^^^^"  -color "Cyan" -newline $false;  f -text "  ^^lllllllllllllllll" -color "Yellow" -newline $true;
f -text "                     ````````^^^^^^llll" -color "Yellow" -newline $true