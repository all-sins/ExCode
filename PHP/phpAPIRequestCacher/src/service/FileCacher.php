<?php

namespace src\service;

use CatalogAPI;
use src\dto\MeasurementDTO;
use src\dto\ProductDTO;
use src\dto\SizeTableDTO;
use src\interface\CacheInterface;

// There has to be  a better way to do this,
// but without the __DIR__."/../.. this class is not usable for tests.
require_once __DIR__."/../../vendor/autoload.php";
require_once  __DIR__."/../../src/interfaces/CacheInterface.php";
require_once  __DIR__."/../../src/service/CatalogAPI.php";
require_once  __DIR__."/../../src/dto/ProductDTO.php";
require_once  __DIR__."/../../src/dto/MeasurementDTO.php";
require_once  __DIR__."/../../src/dto/SizeTableDTO.php";

class FileCacher implements CacheInterface
{
    private string $cachePath;
    private CatalogAPI $catalogAPI;

    public function __construct(string $cachePath = __DIR__ . "/cache")
    {
        $this->cachePath = $cachePath;
        // Ensure that the cache directory exists.
        if (!file_exists($cachePath)) {
            mkdir($cachePath, 0777, true);
        }
        $this->catalogAPI = new CatalogAPI();
    }

    public function extractNecessaryData(string $productId, string $requestedSize) {
        // Retrieve product data.
        $product = $this->get("product_$productId");
        if (!$product) {
            $product = $this->catalogAPI->getProductById($productId);
            $sizeTableData = $this->catalogAPI->getSizeTables($productId);

            // Necessary data for the product:
            $productData = $product->result->product;
            $id = $productData->id;
            $title = $productData->title;
            $description = $productData->description;

            // Necessary data from size tables.
            $sizeTables = [];
            foreach ($sizeTableData->result->size_tables as $sizeTable) {
                $sizeTableType = $sizeTable->type;
                $sizeTableUnit = $sizeTable->unit;
                $sizeTableDescription = $sizeTable->description;
                $measurements = [];
                // echo "Type: $type, Unit: $unit, Description: $description" . PHP_EOL;

                // Iterating over measurements within the size table
                foreach ($sizeTable->measurements as $measurement) {
                    $typeLabel = $measurement->type_label;
                    // echo "Measurement Type: $typeLabel" . PHP_EOL;

                    // Iterating over values within the measurement
                    foreach ($measurement->values as $currentValue) {
                        if ($currentValue->size == $requestedSize) {
                            if (property_exists($currentValue, "value")) {
                                $sizeValue = $currentValue->value;
                                // echo "Value: $sizeValue" . PHP_EOL;
                            } else {
                                $sizeValueMin = $currentValue->min_value;
                                $sizeValueMax = $currentValue->max_value;
                                $sizeValue = "$sizeValueMin - $sizeValueMax";
                            }
                            $measurements[] = new MeasurementDTO($typeLabel, $sizeValue);
                        }
                    }
                }
                $sizeTables[] = new SizeTableDTO($sizeTableType, $sizeTableUnit, $sizeTableDescription, $measurements);
            }

            // Map all of it to a DTO.
            $product = new ProductDTO($id, $title, $description, $sizeTables);

            // Push to cache.
            // $cache->set("$productId", $product, 300);
        }
        return $product;
    }

    public function set(string $key, $value, int $duration): void {
        $data = [
            "expires_at" => time() + $duration,
            "value" => $value,
        ];
        file_put_contents($this->cachePath . "/" . $key . ".cache", serialize($data));
    }

    public function get(string $key) {
        $file = $this->cachePath . "/" . $key . ".cache";
        if (file_exists($file)) {
            $data = unserialize(file_get_contents($file));
            if ($data["expires_at"] >= time()) {
                return $data["value"];
            } else {
                unlink($file);
            }
        }
        return null;
    }
}