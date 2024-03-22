
# Video extensions.
$videoExtensions = [System.Collections.ArrayList]@("*.mp4", "*.mov", "*.MP4", "*.MOV")

# Image extensions.
$imageExtensions = [System.Collections.ArrayList]@("*.jpg", "*.png", "*.webm", "*.jpeg", "*.WEBM", "*.PNG", "*.webp", "*.JPG", "*.jpg_large", "*.WEBP", "*.jpglarge", "*.JPEG", "*.jfif", "*.Jpeg", "*.jpgd")

# Gifs.
$gifsExtensions = [System.Collections.ArrayList]@("*.gif", "*.GIF")

mkdir img, gif, vid
Write-Host "Sorting images..."
Move-Item -Path .\* -Destination .\img\ -Include $imageExtensions -Force -ErrorAction SilentlyContinue
Write-Host "Sorting gifs..."
Move-Item -Path .\* -Destination .\gif\ -Include $gifsExtensions -Force -ErrorAction SilentlyContinue
Write-Host "Sorting videos..."
Move-Item -Path .\* -Destination .\vid\ -Include $videoExtensions -Force -ErrorAction SilentlyContinue
Write-Host "Done!"