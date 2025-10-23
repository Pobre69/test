<?php

namespace Tema\Decorator;

require_once __DIR__ . '/../ISearch.php';

use Search\Interface\BaseSearchDecorator;
use Search\Interface\ISearchDecoratorService;

class TemaFilter extends BaseSearchDecorator {
    private string $tema;

    public function __construct(ISearchDecoratorService $search) {
        parent::__construct($search);
        $this->tema = "patrimonio historico";
    }

    public function execute_search(): array {
        $results = $this->search->execute_search();
        
        $filteredResults = array_filter($results, function($ponto) {
            return isset($ponto["tema"]) && strcasecmp($ponto["tema"],$this->tema) == 0;
        });

        return array_values($filteredResults);
    }
}