<?php

namespace Cidades\Decorator;

use Search\Interface\BaseSearchDecorator;
use Search\Interface\ISearchDecoratorService;

class CidadeFilter extends BaseSearchDecorator {
    private string $cidadeSelected;

    public function __construct(ISearchDecoratorService $search, string $cidadeSelected) {
        parent::__construct($search);
        $this->cidadeSelected = $cidadeSelected;
    }

    public function execute_search(string $query): array {
        $results = $this->search->execute_search();
        
        $filteredResults = array_filter($results, function($ponto) {
            return isset($ponto["cidade"]) && $ponto["cidade"] == $this->cidadeSelected;
        });

        return array_values($filteredResults);
    }
}