<?php

namespace INotifyRepository\Interface;

use PontoTuristico\Models\PontoTuristico;

interface INotifyRepository
{
    public function adicionar(PontoTuristico $ponto): bool;
    
    public function listarTodos(): array;
}
