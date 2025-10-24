<?php

require_once __DIR__ . "/AcessoCompleto.php";

use PastasAcesso\Routes\Acesso;
use FeedBacks\Controller\FeedBacksController;
use PontoTuristico\Controller\PontoTuristicoController;
use Tema\Controller\TemaController;
use View\Controller\ViewController;

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

if ($_SERVER["REQUEST_URI"] === "/" || $_SERVER["REQUEST_URI"] === "/index") {
    ViewController::render("index");
    exit;
}
if ($_SERVER["REQUEST_URI"] === "/citacoes") {
    ViewController::render("Citacoes");
    exit;
}
if ($_SERVER["REQUEST_URI"] === "/comofunciona") {
    ViewController::render("ComoFunciona");
    exit;
}
if ($_SERVER["REQUEST_URI"] === "/quemsomos") {
    ViewController::render("QuemSomos");
    exit;
}

if ($_SERVER["REQUEST_URI"] === "/feedback" && $_SERVER["REQUEST_METHOD"] === "GET") {
    $controller = new FeedBacksController();
    $controller->create();
    exit;
}

if ($_SERVER["REQUEST_URI"] === "/feedback" && $_SERVER["REQUEST_METHOD"] === "POST") {
    $controller = new FeedBacksController();
    $controller->store();
    exit;
}

header("HTTP/1.0 404 Not Found");
echo "Página não encontrada.";
exit;