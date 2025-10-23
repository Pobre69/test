<?php

namespace Ponto_Tema\Models;

class Ponto_Tema{
    public int $idPonto;
    public int $idTema;
    public bool $Ponto_Turistico_Natural;

    public function __construct(array $data) {
        $this->idPonto = $data['pt_id'];
        $this->idTema = $data['t_id'];
        $this->Ponto_Turistico_Natural = $data['pt_natural'];
    }
}