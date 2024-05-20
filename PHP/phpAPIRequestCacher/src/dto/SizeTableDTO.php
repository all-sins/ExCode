<?php

namespace src\dto;

class SizeTableDTO
{
    private $type;
    private $unit;
    private $description;
    private $measurementsList;

    /**
     * @param $type
     * @param $unit
     * @param $description
     * @param $inputMeasurementsList
     */
    public function __construct($type, $unit, $description, $inputMeasurementsList)
    {
        $this->type = $type;
        $this->unit = $unit;
        $this->description = $description;
        if ($inputMeasurementsList == "") {
            $this->measurementsList = array();
        } else {
            $this->measurementsList = $inputMeasurementsList;
        }
    }

    /**
     * @return mixed
     */
    public function getType()
    {
        return $this->type;
    }

    /**
     * @param mixed $type
     */
    public function setType($type)
    {
        $this->type = $type;
    }

    /**
     * @return mixed
     */
    public function getUnit()
    {
        return $this->unit;
    }

    /**
     * @param mixed $unit
     */
    public function setUnit($unit)
    {
        $this->unit = $unit;
    }

    /**
     * @return mixed
     */
    public function getDescription()
    {
        return $this->description;
    }

    /**
     * @param mixed $description
     */
    public function setDescription($description)
    {
        $this->description = $description;
    }

    /**
     * @return mixed
     */
    public function getMeasurementsList()
    {
        return $this->measurementsList;
    }

    /**
     * @param mixed $measurementsList
     */
    public function setMeasurementsList($measurementsList)
    {
        $this->measurementsList = $measurementsList;
    }

    public function addMeasurement(MeasurementDTO $measurement)
    {
        $this->measurementsList[] = $measurement;
    }

    public function removeMeasurement(MeasurementDTO $measurement)
    {
        $measurementsList = $this->getMeasurementsList();
        $index = array_search($measurement, $measurementsList);
        if ($index !== false) {
            unset($measurementsList[$index]);
            $this->setMeasurementsList($measurementsList);
        }
    }

}