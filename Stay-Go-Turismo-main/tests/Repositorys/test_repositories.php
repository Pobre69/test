<?php

require_once __DIR__ . '/../../src/App/Repository/PontoTuristicoRepository.php';
require_once __DIR__ . '/../../src/App/Repository/TemaRepository.php';
require_once __DIR__ . '/../../src/App/Repository/Notifiers/FeedBackRepository.php';
require_once __DIR__ . '/../../src/App/Repository/Notifiers/AuditoriaRepository.php';
require_once __DIR__ . '/../../src/App/Repository/Ponto_TemaAdapter.php';
require_once __DIR__ . '/../../src/App/Repository/Ponto_TemaRepository.php';

use PontoTuristico\Repository\PontoTuristicoRepository;
use Tema\Repository\TemaRepository;
use FeedBacks\Repository\FeedBackRepository;
use Auditoria\Repository\AuditoriaRepository;
use Ponto_Tema\Repository\Ponto_TemaAdapter;
use Ponto_Tema\Repository\Ponto_TemaRepository;

echo "==== Testando Repositories ====" . PHP_EOL;

$repo1 = new PontoTuristicoRepository();
$repo2 = new TemaRepository();
$repo3 = new FeedBackRepository();
$repo4 = new AuditoriaRepository();
$repo5 = new Ponto_TemaAdapter();
$repo6 = new Ponto_TemaRepository();

var_dump(get_class_methods($repo1));
var_dump(get_class_methods($repo2));
var_dump(get_class_methods($repo3));
var_dump(get_class_methods($repo4));
var_dump(get_class_methods($repo5));
var_dump(get_class_methods($repo6));
?>