<?php

namespace CitacoesReferencia\Models;

class CitacoesReferencia{
    public ?int $id;
    public bool $IsCitacao;
    public string $nome;
    public string $comentario;
    public ?string $profissao;
    public string $data;

    public function __construct(array $data = null) {
        if ($data === null) {
            return;
        }
        $this->id = $data['id'] ?? null;
        $this->IsCitacao = $data['IsCitacao'];
        $this->nome = $data['nome'];
        $this->comentario = $data['comentario'];
        $this->profissao = $data['profissao'] ?? null;
        $this->data = $data['data'];
    }
}