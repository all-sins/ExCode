<?php

namespace src\interface;
interface CacheInterface
{
    /**
     * Store a mixed type value in cache for a certain amount of seconds.
     * Supported values should be scalar types and arrays.
     *
     * @param string $key
     * @param mixed $value
     * @param int $duration Duration in seconds
     * @return mixed
     */
    public function set(string $key, $value, int $duration);

    /**
     * Retrieve stored item.
     * Returns the same type as it was stored in.
     * Returns null if entry has expired.
     *
     * @param string $key
     * @return mixed|null
     */
    public function get(string $key);
}