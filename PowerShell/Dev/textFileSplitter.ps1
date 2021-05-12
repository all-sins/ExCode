foreach ($line in Get-Content E:\programming\PowerShell\modList.txt) {
    if ($line -match "-") {
        $line = $line.Split("-")[0]
    } elseif ($line -match "_") {
        $line = $line.Split("_")[0]
    }
    write-output $line
}