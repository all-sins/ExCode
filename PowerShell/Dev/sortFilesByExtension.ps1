$items = gci -path .
$uniqueExtensions = New-Object System.Collections.ArrayList
foreach ($item in $items) {
  $extension = $item.Extension
  if (-NOT $uniqueExtensions.Contains($extension)) {
    $uniqueExtensions.Add($extension)
  }
}
$uniqueExtensions

foreach ($ext in $uniqueExtensions) {
  $wildcardArgument = "*"+$ext
  $procName = $ext.Replace(".","")
  mkdir $procName
  Copy-Item -Path $wildcardArgument -Destination $procName -Recurse -Force -ErrorAction SilentlyContinue
}