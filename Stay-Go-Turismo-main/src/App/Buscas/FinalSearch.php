<?php

namespace Final\Composite;

require_once __DIR__ . "/ISearch.php";

use Search\Interface\ISearchCompositeService;

class FinalSearch implements ISearchCompositeService {
    private array $searchServices = [];

    public function addSearchService(ISearchCompositeService $service): void {
        $this->searchServices[] = $service;
    }

    public function removeSearchService(ISearchCompositeService $service): void {
        $index = array_search($service, $this->searchServices, true);
        if ($index !== false) {
            unset($this->searchServices[$index]);
        }
    }

    public function execute_search(string $query): array {
        $results = [];

        foreach ($this->searchServices as $service) {
            $partialResults = $service->execute_search($query);
            $results = array_merge($results, $partialResults);
        }

        return $results;
    }
}