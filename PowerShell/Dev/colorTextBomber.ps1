$colors = @(
    "Black",
    "DarkBlue",
    "DarkGreen",
    "DarkYellow",
    "Magenta",
    "Yellow",
    "Blue",
    "DarkCyan",
    "DarkMagenta",
    "Cyan",
    "DarkGray",
    "Green",
    "White"
)

$msThrottle = 50;
$msg = "You are an angel. "
$multi = 10;

while ( $true ) {
    $nbr = Get-Random -Minimum 0 -Maximum ($colors.Length - 1);
    $color = $colors[$nbr];
    Write-Host -ForegroundColor $color ($msg * $multi);
    Start-Sleep -Milliseconds $msThrottle
}