<?php
$statJsonPath = "playerJson/";
$files = scandir($statJsonPath);
$files = array_diff($files, array(".", ".."));
$files = array_values($files);

class PlayerStat {
  public string $name;
  public float $playtime;

  public function __construct(string $name, int $playtime) {
    $this->name = $name;
    $this->playtime = $playtime;
  }
}

function uuidToName($uuid) {
  $uuid = str_replace("-", "", $uuid);
  $url = "https://playerdb.co/api/player/minecraft/" . $uuid;
  $curlClient = curl_init();
  curl_setopt($curlClient, CURLOPT_URL, $url);
  curl_setopt($curlClient, CURLOPT_RETURNTRANSFER, true);
  curl_setopt($curlClient, CURLOPT_CUSTOMREQUEST, "GET");
  $response = curl_exec($curlClient);
  if ( curl_errno($curlClient) ) {
    echo "Error: " . curl_error($curlClient);
  }
  curl_close($curlClient);
  $data = json_decode($response, true);
  #var_dump($data);
  return $data["data"]["player"]["username"];
}

print("[INFO] Detected " . count($files) . " files." . PHP_EOL );
$counter = 1;
$pStatList = [];
foreach ($files as $file) {
  print("[PROCESSING] (" . $counter . ") " . pathinfo($file, PATHINFO_FILENAME) . PHP_EOL);
  $counter++;
  $filePath = $statJsonPath . $file;
  if ( pathinfo($filePath, PATHINFO_EXTENSION) === "json" ) {
    $json = file_get_contents($filePath);
    $data = json_decode($json, true);
    if ( $data !== null ) {
      if ( isset( $data["stats"]["minecraft:custom"]["minecraft:play_time"] ) ) {
        // stats
        // minecraft:custom
        // minecraft:play_time
	$playerName = uuidToName( pathinfo($file, PATHINFO_FILENAME) );
	$timePlayedAsTicks = $data["stats"]["minecraft:custom"]["minecraft:play_time"];
	$pStatList[] = new PlayerStat($playerName, $timePlayedAsTicks);
	usort($pStatList, function($a, $b) {
	  return $b->playtime - $a->playtime;
	});
        #echo $playerName . " : " . $timePlayedAsHours . PHP_EOL;
      }
    }
  }
}

print("[INFO] Processing done." . PHP_EOL );
var_dump($pStatList);
foreach ($pStatList as $pStat) {
  echo $pStat->name . " : " . number_format($pStat->playtime / 20 / 60 / 60, 1) . " hours" . PHP_EOL;
}

