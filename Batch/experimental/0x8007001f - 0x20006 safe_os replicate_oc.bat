REM windows 7 to windows 10 upgrade error 0x8007001f - 0x20006 safe_os replicate_oc
REM Reset Windows Update Components.
net stop wuauserv
net stop cryptSvc
net stop bits
net stop msiserver
ren C:\Windows\SoftwareDistribution SoftwareDistribution.old
ren C:\Windows\System32\catroot2 catroot2.old

REM Re-registering DLLs associated with making Internet Connections and reseting windows network interface.
regsvr32.exe /s atl.dll
regsvr32.exe /s urlmon.dll
regsvr32.exe /s mshtml.dll
netsh winsock reset
netsh winsock reset proxy

net start wuauserv
net start cryptSvc
net start bits
net start msiserver

REM Remove Developer Mod Package with DISM.
dism /online /remove-package /packagename:Microsoft-OneCore-DeveloperMode-Desktop-Package~31bf3856ad364e35~amd64~~10.0.17134.1