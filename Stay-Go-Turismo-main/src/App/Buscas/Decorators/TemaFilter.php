<?php

namespace Tema\Decorator;

use Search\Interface\BaseSearchDecorator;
use Search\Interface\ISearchDecoratorService;

class TemaFilter extends BaseSearchDecorator {
    private string $tema;

    public function __construct(ISearchDecoratorService $search, string $tema) {
        parent::__construct($search);
        $this->tema = $tema;
    }

    public function execute_search(): array {
        $results = $this->search->execute_search();
        
        $filteredResults = array_filter($results, function($ponto) {
            return isset($ponto["tema"]) && $ponto["tema"] == $this->tema;
        });

        return array_values($filteredResults);
    }
}