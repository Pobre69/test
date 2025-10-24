<?php

namespace ISearchCompositeService\Interface;

use PontoTuristico\Models\PontoTuristico;

interface ISearchCompositeService 
{
    public function execute_search(string $query): array;
}