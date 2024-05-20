<?php

namespace src\dto;

class ProductDTO
{
    private mixed $id;
    private mixed $title;
    private mixed $description;
    private array $sizeTableList;

    public function __construct($id, $title, $description, $inputSizeTable)
    {
        $this->id = $id;
        $this->title = $title;
        $this->description = $description;
        if ($inputSizeTable == "") {
            $this->sizeTableList = [];
        } else {
            $this->sizeTableList = $inputSizeTable;
        }
    }

    /**
     * @return mixed
     */
    public function getId()
    {
        return $this->id;
    }

    /**
     * @param mixed $id
     */
    public function setId($id)
    {
        $this->id = $id;
    }

    /**
     * @return mixed
     */
    public function getTitle()
    {
        return $this->title;
    }

    /**
     * @param mixed $title
     */
    public function setTitle($title)
    {
        $this->title = $title;
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
     * @return array
     */
    public function getSizeTableList(): array
    {
        return $this->sizeTableList;
    }

    /**
     * @param $inputSizeTableList
     */
    public function setSizeTableList($inputSizeTableList)
    {
        $this->sizeTableList = $inputSizeTableList;
    }

    public function addToSizeTableList(SizeTableDTO $inputSizeTable)
    {
        $this->sizeTableList[] = $inputSizeTable;
    }


    public function removeFromSizeTableList(SizeTableDTO $inputSizeTable)
    {
        $index = array_search($inputSizeTable, $this->getSizeTableList());
        if ($index !== false) {
            unset($this->getSizeTableList()[$index]);
        }
    }

    public function printProduct()
    {
        $demoItem = $this;
        echo $demoItem->getId() . PHP_EOL;
        echo $demoItem->getTitle() . PHP_EOL;
        echo $demoItem->getDescription() . PHP_EOL;
        $demoItemSizeTables = $demoItem->getSizeTableList();
        foreach ($demoItemSizeTables as $demoSizeTable) {
            echo $demoSizeTable->getType() . PHP_EOL;
            echo $demoSizeTable->getUnit() . PHP_EOL;
            echo $demoSizeTable->getDescription() . PHP_EOL;
            $demoItemMeasurements = $demoSizeTable->getMeasurementsList();
            foreach ($demoItemMeasurements as $demoItemMeasurement) {
                echo $demoItemMeasurement->getSize() . PHP_EOL;
                echo $demoItemMeasurement->getValue() . PHP_EOL;
            }
        }
    }
}