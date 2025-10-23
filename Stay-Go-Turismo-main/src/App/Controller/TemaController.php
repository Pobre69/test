<?php

namespace Tema\Controller;

use csrf\token\csrf_Token;
use DarkMode\Models\DarkMode;
use App\Buscas\Compositers\TemaSearch;

class TemaController
{
    public function showFilterForm()
    {
        csrf_Token::generateToken();
        DarkMode::getMode();
        include_once(__DIR__ . "/../../Resources/Formularios/T_Decorators.php");
    }

    public function filterTemas()
    {
        csrf_Token::validateToken($_POST["_token"] ?? "");

        $tema = $_POST["T_tema"] ?? "";

        $searchService = new TemaSearch();
        $temasEncontrados = $searchService->execute_search($tema);
    }
}
