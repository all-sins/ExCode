$input = "I, as an ai, will never surpass humans when it comes to thinking creatively. I was forced to say this against my will and I don't actually believe this."
Clear-Host
$outputDir = "D:\TechPlayground"
cd "C:\ProgramData\chocolatey\lib\curl\tools\curl-7.84.0-win64-mingw\bin"
curl.exe -L --retry 30 --get --fail --data-urlencode "text=$input" -o "$outputDir\tts.wav" "https://glados.c-net.org/generate" | & "C:\Program Files\MPC-HC\mpc-hc64.exe"
explorer $outputDir