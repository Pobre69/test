<?php

namespace PontoTuristico\Controller;

use csrf\token\csrf_Token;
use DarkMode\Models\DarkMode;
use PontoTuristico\Facade\PontoTuristicoFacade;
use PontoTuristico\Repository\PontoTuristicoRepository;
use top10\Composite\top10Search;

class PontoTuristicoController
{
    public function index()
    {
        csrf_Token::generateToken();
        DarkMode::getMode();
        $pontos = new top10Search();
        $pontos::execute_search("");
    }

    public function filterPontosTuristico()
    {
        csrf_Token::validateToken($_POST["_token"] ?? "");

        $filters = [
            "nome" => $_POST["PT_nome"] ?? null,
            "estado" => $_POST["PT_estado"] ?? null,
            "cidade" => $_POST["PT_cidade"] ?? null,
            "avaliacaoMin" => isset($_POST["PT_avaliacaoMin"]) ? (float)$_POST["PT_avaliacaoMin"] : null,
            "avaliacaoMax" => isset($_POST["PT_avaliacaoMax"]) ? (float)$_POST["PT_avaliacaoMax"] : null,
            "estacionamento" => isset($_POST["PT_estacionamento"]) && $_POST["PT_estacionamento"] !== "" ? (bool)$_POST["PT_estacionamento"] : null,
            "horarioAberturaMin" => $_POST["PT_horarioAberturaMin"] ?? null,
            "horarioFechamentoMax" => $_POST["PT_horarioFechamentoMax"] ?? null,
            "natural" => isset($_POST["PT_natural"]) && $_POST["PT_natural"] !== "" ? (bool)$_POST["PT_natural"] : null,
            "patrimonio" => isset($_POST["PT_patrimonio"]) && $_POST["PT_patrimonio"] !== "" ? (bool)$_POST["PT_patrimonio"] : null,
            "visitantesMin" => isset($_POST["PT_visitantesMin"]) ? (int)$_POST["PT_visitantesMin"] : null,
            "visitantesMax" => isset($_POST["PT_visitantesMax"]) ? (int)$_POST["PT_visitantesMax"] : null,
            "precoEntradaMin" => isset($_POST["PT_precoEntradaMin"]) ? (float)$_POST["PT_precoEntradaMin"] : null,
            "precoEntradaMax" => isset($_POST["PT_precoEntradaMax"]) ? (float)$_POST["PT_precoEntradaMax"] : null,
        ];

        $filters = array_filter($filters, fn($v) => $v !== null);

        $pontos = PontoTuristicoFacade::filtrar($filters);

        include_once(__DIR__ . "/../../Resources/Views/pontosFiltrados.php");
    }
}
