<?php

namespace Estado\Decorator;

require_once __DIR__ . '/../ISearch.php';

use Search\Interface\BaseSearchDecorator;
use Search\Interface\ISearchDecoratorService;

class EstadoFilter extends BaseSearchDecorator {
    private string $estadoSelected;

    public function __construct(ISearchDecoratorService $search, string $estadoSelected) {
        parent::__construct($search);
        $this->estadoSelected = $estadoSelected;
    }

    public function execute_search(): array {
        $results = $this->search->execute_search();
        
        $filteredResults = array_filter($results, function($ponto) {
            return isset($ponto["estado"]) && $ponto["estado"] == $this->estadoSelected;
        });

        return array_values($filteredResults);
    }
}