<?php

namespace CRUDrepository\Interface;

interface IPontoRepository
{
    public function adicionar(PontoTuristico $ponto): bool;

    public function alterar(PontoTuristico $ponto): bool;

    public function buscarPorId(int $id): ?PontoTuristico;

    public function listarTodos(): array;

    public function deletar(int $id): bool;
}
interface ITemaRepository
{
    public function adicionar(Tema $ponto): bool;

    public function alterar(Tema $ponto): bool;

    public function buscarPorId(int $id): ?Tema;

    public function listarTodos(): array;

    public function deletar(int $id): bool;
}
interface IPonto_TemaRepository
{
    public function adicionar(Ponto_Tema $ponto): bool;

    public function alterar(Ponto_Tema $ponto): bool;

    public function buscarPorId(int $id): ?Ponto_Tema;

    public function listarTodos(): array;

    public function deletar(int $id): bool;
}