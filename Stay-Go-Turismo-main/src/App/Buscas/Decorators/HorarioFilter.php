<?php

namespace Horario\Decorator;

require_once __DIR__ . '/../ISearch.php';

use Search\Interface\BaseSearchDecorator;
use Search\Interface\ISearchDecoratorService;

class HorarioFilter extends BaseSearchDecorator {
    private string $openTime;
    private string $closeTime;

    public function __construct(ISearchDecoratorService $search, string $openTime, string $closeTime) {
        parent::__construct($search);
        $this->openTime = $openTime;
        $this->closeTime = $closeTime;
    }

    public function execute_search(): array {
        $results = $this->search->execute_search();
        
        $filteredResults = array_filter($results, function($ponto) {
            return (
                isset($ponto["horarioAbertura"]) && $ponto["horarioAbertura"] <= $this->openTime &&
                isset($ponto["horarioFechamento"]) && $ponto["horarioFechamento"] >= $this->closeTime
            );
        });

        return array_values($filteredResults);
    }
}