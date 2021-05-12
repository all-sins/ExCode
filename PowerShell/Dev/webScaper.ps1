$html = Invoke-WebRequest -uri https://control.akamai.com/apps/property-manager/#/groups?gid=95848
($html.ParsedHtml.getElementsByTagName("<a>") | Where {$_.className -eq "popover-target util-clickable ng-binding ng-scope"}).innerText
($HTML.ParsedHtml.getElementsByTagName("a") | Where{ $_.className -eq "popover-target util-clickable ng-binding ng-scope" } ).innerText