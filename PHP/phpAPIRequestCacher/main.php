<?php

use src\service\FileCacher;

require_once "vendor/autoload.php";
require_once "src/service/FileCacher.php";
require_once "src/dto/MeasurementDTO.php";
require_once "src/dto/ProductDTO.php";
require_once "src/dto/SizeTableDTO.php";

// Define parameters and instantiate implementation.
$cache = new FileCacher();
$productId = 438;
$requestedSize = 'L';
$cacheTimeout = 300;

// Retrieve data from the PrintfulAPI, extract necessary values and cache them.
$cache->set($productId, $cache->extractNecessaryData($productId, $requestedSize), $cacheTimeout);

// Retrieve previously cached data.
$demoItem = $cache->get($productId);

// Print formatted representation to stdout.
$demoItem->printProduct();
