<?php

namespace CitacoesReferencia\Models;

class CitacoesReferencia{
    public ?int $id;
    public bool $IsCitacao;
    public string $nome;
    public string $comentario;
    public ?string $profissao;
    public string $data;

    public function __construct(array $data) {
        $this->id = $data['ID'] ?? null;
        $this->IsCitacao = $data['IsCitacao'];
        $this->nome = $data['NOME'];
        $this->comentario = $data['COMENTARIO'];
        $this->profissao = $data['PROFISSAO'] ?? null;
        $this->data = $data['DATA'];
    }
}