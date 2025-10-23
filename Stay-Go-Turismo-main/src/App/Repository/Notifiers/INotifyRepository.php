<?php

namespace INotifyRepository\Interface;

interface INotifyRepository
{
    public function adicionar(PontoTuristico $ponto): bool;
    
    public function listarTodos(): array;
}
