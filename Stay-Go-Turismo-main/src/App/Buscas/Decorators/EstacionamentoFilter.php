<?php

namespace Estacionamento\Decorator;

use Search\Interface\BaseSearchDecorator;
use Search\Interface\ISearchDecoratorService;

class EstacionamentoFilter extends BaseSearchDecorator {
    private bool $estacionamento;

    public function __construct(ISearchDecoratorService $search, bool $estacionamento) {
        parent::__construct($search);
        $this->estacionamento = $estacionamento;
    }

    public function execute_search(string $query): array {
        $results = $this->search->execute_search();
        
        $filteredResults = array_filter($results, function($ponto) {
            return isset($ponto["estacionamento"]) && $ponto["estacionamento"] == $this->estacionamento;
        });

        return array_values($filteredResults);
    }
}