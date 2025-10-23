<?php

require_once __DIR__ . "/../App/Controller/FeedBacksController.php";
require_once __DIR__ . "/../App/Controller/PontoTuristicoController.php";
require_once __DIR__ . "/../App/Controller/TemaController.php";
require_once __DIR__ . "/../App/Controller/ViewController.php";

use FeedBacks\Controller\FeedBacksController;
use PontoTuristico\Controller\PontoTuristicoController;
use Tema\Controller\TemaController;
use View\Controller\ViewController;

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
    require_once __DIR__ . "/../App/Controller/FeedBacksController.php";
    $controller = new FeedBacksController();
    $controller->create();
    exit;
}

if ($_SERVER["REQUEST_URI"] === "/feedback" && $_SERVER["REQUEST_METHOD"] === "POST") {
    require_once __DIR__ . "/../App/Controller/FeedBacksController.php";
    $controller = new FeedBacksController();
    $controller->store();
    exit;
}

if ($_SERVER["REQUEST_URI"] === "/pontoTuristico" && $_SERVER["REQUEST_METHOD"] === "GET") {
    require_once __DIR__ . "/../App/Controller/PontoTuristicoController.php";
    $controller = new PontoTuristicoController();
    $controller->showFilterForm();
    exit;
}

if ($_SERVER["REQUEST_URI"] === "/pontoTuristico" && $_SERVER["REQUEST_METHOD"] === "POST") {
    require_once __DIR__ . "/../App/Controller/PontoTuristicoController.php";
    $controller = new PontoTuristicoController();
    $controller->filterPontosTuristico();
    exit;
}

if ($_SERVER["REQUEST_URI"] === "/tema" && $_SERVER["REQUEST_METHOD"] === "GET") {
    require_once __DIR__ . "/../App/Controller/TemaController.php";
    $controller = new TemaController();
    $controller->showFilterForm();
    exit;
}

if ($_SERVER["REQUEST_URI"] === "/tema" && $_SERVER["REQUEST_METHOD"] === "POST") {
    require_once __DIR__ . "/../App/Controller/TemaController.php";
    $controller = new TemaController();
    $controller->filterTemas();
    exit;
}

header("HTTP/1.0 404 Not Found");
echo "Página não encontrada.";
exit;