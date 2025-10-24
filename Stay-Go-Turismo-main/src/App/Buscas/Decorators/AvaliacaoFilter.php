<?php

namespace Avaliacao\Decorator;

use ISearch\Interface\ISearchDecoratorService;
use Abstract\Interface\BaseSearchDecorator;

class AvaliacaoFilter extends BaseSearchDecorator {
    private float $minRating;
    private float $maxRating;

    public function __construct(ISearchDecoratorService $search, float $minRating, float $maxRating) {
        parent::__construct($search);
        $this->minRating = $minRating;
        $this->maxRating = $maxRating;
    }

    public function execute_search(string $query): array {
        $results = $this->search->execute_search();
        
        $filteredResults = array_filter($results, function($ponto) {
            return (
                isset($ponto["avaliacaoGeral"]) && $ponto["avaliacaoGeral"] <= $this->minRating &&
                isset($ponto["avaliacaoGeral"]) && $ponto["avaliacaoGeral"] >= $this->maxRating
            );
        });

        return array_values($filteredResults);
    }
}