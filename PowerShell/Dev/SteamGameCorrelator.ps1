# Define command-line arguments.
param (
    # Text to add RGB to.
    # Last Param fails!
    # [string]$userIds = "ninj4kitty  ,  OG_Tsu, 76561198011112176"
    [string]$userIds = "ninj4kitty  ,  OG_Tsu"
)

Class User {
    [string]$userId
    [string[]]$games
    User ([string]$userId, [String[]]$games) {
        $this.userID = $userId
        $this.games = $games
    }
}

Class GameStat {
    [string]$gameName
    [int]$count
    GameStat ([string]$gameName, [int]$count) {
        $this.gameName = $gameName
        $this.count = $count
    }
}

Clear-Host

# Define constants.
$urlParameters = "/games?tab=all&xml=1"

# Cut out spaces.
Write-Host "[INFO] " -ForegroundColor Yellow -NoNewline; Write-Host "Cutting spaces..."
$userIds = $userIds.Replace(" ", "")

# Split input string into list of strings by delimiter ",".
Write-Host "[INFO] " -ForegroundColor Yellow -NoNewline; Write-Host "Splitting string..."
$userIdList = $userIds.Split(",")

# Create list of User objects.
$users = New-Object System.Collections.ArrayList

# First line is required for collection to not produce NPE.
New-Object -TypeName System.Collections.ArrayList
$gameStringList = [System.Collections.ArrayList]@()


foreach ($userId in $userIdList) {
    Write-Host "[INFO] " -ForegroundColor Yellow -NoNewline; Write-Host "Fetching game data..."
    $urlToInvoke = "http://steamcommunity.com/id/"+$userId+$urlParameters
    $responseObject = Invoke-WebRequest -Uri $urlToInvoke
    $deserializedXmlResponse = [xml]$responseObject.Content
    Write-Host "[DEBUG] " -ForegroundColor Cyan -NoNewline; Write-Host $userId" isTypeOf"($deserializedXmlResponse.gamesList.games.ChildNodes.name).GetType().Name
    $gameObjectList = $deserializedXmlResponse.gamesList.games.ChildNodes
    
    # Declare List of Strings and populate it with the names of the games.
    foreach ($gameObject in $gameObjectList) {
        $gameStringList.Add($gameObject.name.'#cdata-section') | Out-Null
    }
    Write-Host "[INFO] " -ForegroundColor Yellow -NoNewline; Write-Host $userId" has"($gameStringList.Count)" games!";
    
    #foreach ($gameString in $gameStringList) {
    #    Write-Host $gameString
    #}

    Write-Host "[INFO] " -ForegroundColor Yellow -NoNewline; Write-Host "Adding $userId to memory..."
    $userToAdd = [User]::new($userId, $gameStringList)
    $userId
    foreach ($gameString in $gameStringList) {$gameString}
    $users.Add($userToAdd) | Out-Null
}

# Combine all games into single list with duplicates.
New-Object -TypeName System.Collections.ArrayList
$fullGameList = [System.Collections.ArrayList]@()
foreach ($user in $users) {
    Write-Host "[DEBUG] " -ForegroundColor DarkCyan -NoNewline; Write-Host "Adding "$user.userId"'s "$user.games.Length" games..."
    $uniqueList = $user.games | select -Unique
    $fullGameList.AddRange($uniqueList) | Out-Null
}


# Count how many occurances there are of every game.
New-Object -TypeName System.Collections.ArrayList
$gameStatList = [System.Collections.ArrayList]@()
$uniqueGameList = $fullGameList | Select-Object -Unique
foreach ($game in $fullGameList) {
    $gameStatList.Add([GameStat]::new($game, 0)) | Out-Null
}


foreach ($game in $fullGameList) {
    foreach ($gameStat in $gameStatList) {
        if ($game -eq $gameStat.gameName) {
            $gameStat.count++
        }
    }
}

Write-Host "[SUCCESS] " -ForegroundColor Green -NoNewline; Write-Host "Done! Printing shared games..."

foreach ($gameStat in $gameStatList) {
    Write-Host $gameStat.count"  "$gameStat.gameName
}