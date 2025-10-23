<?php

namespace Tema\Models;

class Tema{
    public ?int $idTema;
    public string $Tema;

    public function __construct(array $data) {
        $this->idTema = $data['t_id'] ?? null;
        $this->Tema = $data['t_tema'];
    }
}