<?php

require_once __DIR__ . "/AcessoCompleto.php";

use PastasAcesso\Routes\Acesso;
use FeedBacks\Controller\FeedBacksController;
use PontoTuristico\Controller\PontoTuristicoController;
use Tema\Controller\TemaController;
use View\Controller\ViewController;
use CitacoesReferencia\Controller\CitacoesReferenciaController;

Acesso::getAllRoutes();

if (preg_match("#^/darkmode/set#", $_SERVER["REQUEST_URI"])) {
    require_once __DIR__ . "/../App/Controller/DarkModeController.php";
    if (isset($_GET["toggle"])) {
        DarkModeController::toggle();
    } else {
        $isDark = isset($_GET["dark"]) && $_GET["dark"] == "1";
        DarkModeController::set($isDark);
    }
    http_response_code(204);
    exit;
}

$fullurl = $_SERVER['REQUEST_URI'];
$urlBase = basename(rtrim($fullurl, '/'));
$url = explode('?', $urlBase)[0];

if ($url === 'Web.php' || empty($url) || !isset($url)) { $url = 'index'; }

if ($url === 'index') { ViewController::render('index'); exit; }
if ($url === 'citacoes') { 
    $CRC = new CitacoesReferenciaController();
    $CRC->index(); 
    exit; 
}
if ($url === 'comofunciona') { ViewController::render('ComoFunciona'); exit; }
if ($url === 'quemsomos') { ViewController::render('QuemSomos'); exit; }
if ($url === 'contato') { ViewController::render('Contato'); exit; }
if ($url === 'feedBack' && $_SERVER['REQUEST_METHOD'] === 'POST') {
    $FB_Controller = new FeedBacksController();
    $FB_Controller->store($_POST);
    header("Location: /contato");
    exit;
}

header("HTTP/1.0 404 Not Found");
echo "Página não encontrada.";
exit;
