<?php

namespace Natural\Decorator;

use Search\Interface\BaseSearchDecorator;
use Search\Interface\ISearchDecoratorService;

class NaturalFilter extends BaseSearchDecorator {
    private bool $IsNatural;

    public function __construct(ISearchDecoratorService $search, bool $IsNatural) {
        parent::__construct($search);
        $this->IsNatural = $IsNatural;
    }

    public function execute_search(): array {
        $results = $this->search->execute_search();
        
        $filteredResults = array_filter($results, function($ponto_tema) {
            return (
                isset($ponto_tema["Ponto_Turistico_Natural"]) && $ponto_tema["Ponto_Turistico_Natural"] == $this->IsNatural
            );
        });

        return array_values($filteredResults);
    }
}