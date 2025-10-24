<?php

namespace Visitantes\Decorator;

use Search\Interface\BaseSearchDecorator;
use Search\Interface\ISearchDecoratorService;

class VisitantesFilter extends BaseSearchDecorator {
    private int $minVisitantes;

    public function __construct(ISearchDecoratorService $search, int $minVisitantes) {
        parent::__construct($search);
        $this->minVisitantes = $minVisitantes;
    }

    public function execute_search(): array {
        $results = $this->search->execute_search();
        
        $filteredResults = array_filter($results, function($ponto) {
            return isset($ponto["visitantes"]) && $ponto["visitantes"] >= $this->minVisitantes;
        });

        return array_values($filteredResults);
    }
}