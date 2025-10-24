<?php

namespace INotifyRepository\Interface;

use PontoTuristico\Models\PontoTuristico;
use FeedBacks\Models\FeedBacks;

interface INotifyRepository
{
    public function adicionar(PontoTuristico $ponto): bool;
    
    public function listarTodos(): array;
}
interface INotifyRepositoryFeedBack
{
    public function adicionar(FeedBacks $FeedBacks): bool;
    
    public function listarTodos(): array;
}
