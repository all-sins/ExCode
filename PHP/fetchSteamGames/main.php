<?php
$xmlString = file_get_contents("https://steamcommunity.com/id/OG_Tsu/games?tab=all&xml=1");
$dom = new DOMDocument();
$dom->loadXML($xmlString);
$titles = $dom->getElementsByTagName("name");
foreach ($titles as $title) {
    echo $title->nodeValue . PHP_EOL;
}