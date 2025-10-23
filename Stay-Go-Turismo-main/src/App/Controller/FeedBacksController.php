<?php

namespace FeedBacks\Controllers;

use csrf\token\csrf_Token;
use FeedBacks\Models\FeedBacks;
use FeedBacks\Repository\FeedBackRepository;
use DarkMode\Models\DarkMode;

class FeedBacksController
{
    public function index() { }

    public function create() 
    { 
        csrf_Token::generateToken();
        DarkMode::getMode();
        include_once (__DIR__ . '/../../../Resources/View/contato.php');
    }

    public function store() 
    { 
        csrf_Token::validateToken($_POST['_token'] ?? '');

        $feedBackRepository = new FeedBackRepository();

        $comunicado = $_POST['mensagem'] ?? '';
        $autor = $_POST['nome'] ?? '';
        $cidade = $_POST['cidade'] ?? '';

        $feedBack = new FeedBacks([
            'FB_autor' => $autor,
            'FB_comunicado' => $comunicado,
            'FB_cidade' => $cidade,
            'FB_data_comunicado' => date('Y-m-d H:i:s'),
            'FB_status' => 0
        ]);

        $feedBackRepository->adicionar($feedBack);

        header('Location: /contato?success=1');
        exit();
    }

    public function show() { }

    public function edit() { }

    public function update() { }

    public function destroy() { }
}