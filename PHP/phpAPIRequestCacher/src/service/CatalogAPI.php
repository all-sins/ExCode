<?php

use GuzzleHttp\Client;

class CatalogAPI
{
    private Client $httpClient;

    // Define API endpoint, URL paths and parameters.
    private string $apiEndpoint = "https://api.printful.com";

    public function __construct()
    {
        // Pass a newer CA bundle to the HTTP client to fix SSL issue.
        $this->httpClient = new Client(['verify' => __DIR__."/../../manual_dep/cacert.pem"]);
    }

    public function getProductById(int $productId)
    {
        $productsURLPath = "/products/$productId";
        $response = $this->httpClient->get($this->apiEndpoint . $productsURLPath);
        return json_decode($response->getBody(), false);
    }

    public function getSizeTables(int $productId)
    {
        $sizeURLPath = "/products/$productId/sizes";
        $response = $this->httpClient->get($this->apiEndpoint . $sizeURLPath);
        return json_decode($response->getBody(), false);
    }
}