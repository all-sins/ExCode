$sciNotation = "1E+306"
$bigNumber = [System.Numerics.BigInteger]::new($sciNotation)
Write-Host $bigNumber