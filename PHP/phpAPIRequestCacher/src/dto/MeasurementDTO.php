<?php

namespace src\dto;
class MeasurementDTO
{
    private $size;
    private $value;

    /**
     * @param string $size
     * @param string $value
     */
    public function __construct(string $size = "", string $value = "")
    {
        $this->size = $size;
        $this->value = $value;
    }

    /**
     * @return string
     */
    public function getSize()
    {
        return $this->size;
    }

    /**
     * @param mixed $size
     */
    public function setSize($size)
    {
        $this->size = $size;
    }

    /**
     * @return string
     */
    public function getValue()
    {
        return $this->value;
    }

    /**
     * @param mixed $value
     */
    public function setValue($value)
    {
        $this->value = $value;
    }

}