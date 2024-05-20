<?php

include_once __DIR__."/../vendor/autoload.php";
include_once __DIR__."/../src/service/FileCacher.php";

use PHPUnit\Framework\TestCase;
use src\service\FileCacher;

class cacheExpiryTest extends TestCase
{
    protected FileCacher $cache;
    protected CatalogAPI $catalogAPI;
    protected string $cachePath = __DIR__ . '/../cache';

    protected function setUp(): void
    {
        // Re-initialize the test cache for each test.
        if (file_exists($this->cachePath)) {
            $this->clearCacheDirectory($this->cachePath);
        } else {
            mkdir($this->cachePath, 0777, true);
        }
        $this->cache = new FileCacher($this->cachePath);
        $this->catalogAPI = new CatalogAPI();
    }

    protected function tearDown(): void {
        if (file_exists($this->cachePath)) {
            $this->clearCacheDirectory($this->cachePath);
        }
    }

    private function clearCacheDirectory(string $directory): void {
        $files = glob($directory . '/*');
        foreach ($files as $file) {
            if (is_file($file)) {
                unlink($file);
            }
        }
    }

    public function testCacheExpiryTest() {
        $duration = 2;
        $this->cache->set('test_key', 'test_value', $duration);
        sleep($duration + 1);
        $expiredItem = $this->cache->get('test_key');
        // Cache returns null if item doesn't exist.
        $this->assertNull($expiredItem);
    }

    public function testCacheFileDelete() {
        $duration = 2;
        $this->cache->set('test_key', 'test_value', $duration);
        sleep($duration + 1);
        // get() will unlink test_key file if it is indeed expired.
        $this->cache->get("test_key");
        $this->assertFalse(file_exists("../cache/test_key.cache"));
    }

    // NOTE: Hard-coded product ID / test_id of value "3" exists as of 2024.04.18.
    // Could write a fancier sudo-random fuzzer if necessary later.
    public function testCatalogAPICacheFileCreated() {
        $duration = 4;
        $test_id = "3";
        $path = __DIR__."/../cache/$test_id.cache";
        $this->cache->set($test_id, $this->catalogAPI->getProductById($test_id), $duration);
        $this->assertTrue(file_exists($path));
    }

    public function testCatalogAPICacheRetrievable() {
        $duration = 2;
        $test_id = "3";
        $this->cache->set($test_id, $this->catalogAPI->getProductById($test_id), $duration);
        $this->assertNotNull($this->cache->get($test_id));
    }



}
