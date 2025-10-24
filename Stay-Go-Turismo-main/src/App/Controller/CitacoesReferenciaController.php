<?php

namespace CitacoesReferencia\Controller;

use csrf\token\csrf_Token;
use CitacoesReferencia\Models\CitacoesReferencia;
use CitacoesReferencia\Repository\CitacoesReferenciaRepository;
use DarkMode\Models\DarkMode;

class CitacoesReferenciaController
{
    public function index() 
    { 
        $repository = new CitacoesReferenciaRepository();
        $citacoes_referencias = $repository->listarTodos();
        $DarkMode = new DarkMode();
        $DarkMode = $DarkMode->getMode();
        $First_url = '/Sites/Stay-Go-Turismo-main/src/Routes/Web.php';
        $viewPath = __DIR__ . "/../../Resources/View/Citacoes.php";
        if (file_exists($viewPath)) {
            include_once($viewPath);
        } else {
            header("HTTP/1.0 404 Not Found");
            echo "View not found.";
        }
    }

    public function create() { }

    public function store() { }

    public function show() { }

    public function edit() { }

    public function update() { }

    public function destroy() { }
}