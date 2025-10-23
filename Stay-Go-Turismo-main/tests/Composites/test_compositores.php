<?php

require_once __DIR__ . '/../../src/App/Buscas/Compositers/TemaSearch.php';
require_once __DIR__ . '/../../src/App/Buscas/Compositers/PontoSearch.php';
require_once __DIR__ . '/../../src/App/Buscas/Compositers/top10Search.php';

use Tema\Composite\TemaSearch;
use Ponto\Composite\PontoSearch;
use top10\Composite\top10Search;

echo "==== Testando Compositores ====" . PHP_EOL;

$ponto = new PontoSearch();
$tema = new TemaSearch();
$top = new top10Search();

var_dump(get_class_methods($ponto));
var_dump(get_class_methods($tema));
var_dump(get_class_methods($top));
?>