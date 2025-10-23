<?php

require_once __DIR__ . '/../../src/App/Models/Auditoria.php';
require_once __DIR__ . '/../../src/App/Models/DarkMode.php';
require_once __DIR__ . '/../../src/App/Models/FeedBacks.php';
require_once __DIR__ . '/../../src/App/Models/PontoTuristico.php';
require_once __DIR__ . '/../../src/App/Models/Ponto_Tema.php';
require_once __DIR__ . '/../../src/App/Models/Tema.php';

use Auditoria\Models\Auditoria;
use DarkMode\Models\DarkMode;
use FeedBacks\Models\FeedBacks;
use PontoTuristico\Models\PontoTuristico;
use Ponto_Tema\Models\Ponto_Tema;
use Tema\Models\Tema;

echo "==== Testando Models ====" . PHP_EOL;

$models = [
    new Auditoria(['nome_tabela' => 'teste', 'detalhamento' => 'teste', 'data' => date('Y-m-d H:i:s')]),
    new DarkMode(),
    new FeedBacks(['FB_id' => 0, 'FB_autor' => 'Teste', 'FB_comunicado' => 'Teste', 'FB_cidade' => 'Teste', 'FB_data_comunicado' => date('Y-m-d H:i:s'), 'FB_status' => 'teste']),
    new PontoTuristico(['pt_nome' => 'Teste', 'pt_c2' => 'MG', 'pt_c3' => 'BH', 'pt_c6' => 'Rua Teste', 'pt_c7' => '08:00', 'pt_c9' => '18:00']),
    new Ponto_Tema(['pt_id' => 1, 't_id' => 1, 'pt_natural' => true]),
    new Tema(['t_tema' => 'Teste'])
];

foreach ($models as $model) {
    echo "Instanciado: " . get_class($model) . PHP_EOL . "<br>";
    var_dump(get_class_methods($model));
}
?>