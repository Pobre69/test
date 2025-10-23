<?php

namespace Auditoria\Models;

class Auditoria{
    public ?int $id;
    public string $nome_tabela;
    public string $detalhamento;
    public string $data;

    public function __construct(array $data) {
        $this->id = $data['id'] ?? null;
        $this->nome_tabela = $data['nome_tabela'];
        $this->detalhamento = $data['detalhamento'];
        $this->data = $data['data'];
    }
}