<?php

namespace Search\Interface;

require_once __DIR__ . "/../Models/PontoTuristico.php";

use PontoTuristico\Models\PontoTuristico;

interface ISearchCompositeService {
    public function execute_search(string $query): array;
}
interface ISearchDecoratorService {
    public function execute_search(string $query): array;
}
abstract class BaseSearchDecorator implements ISearchDecoratorService {
    protected ISearchDecoratorService $search;

    public function __construct(ISearchDecoratorService $search) {
        $this->search = $search;
    }

    public function execute_search(string $query): array {
        return $this->search->execute_search($query);
    }
}