<?php

use CRUDrepository\Interface\IPonto_TemaRepository;
use Ponto_Tema\Repository\Ponto_TemaRepository;
use Ponto_Tema\Models\Ponto_Tema;

class Ponto_TemaAdapter implements IPonto_TemaRepository 
{
    private Ponto_TemaRepostory $Ponto_Tema;

    public function __construct(Ponto_TemaRepository $Ponto_Tema) {
        $this->Ponto_Tema = $Ponto_Tema;
    }

    public function adicionar(Ponto_Tema $pontoTema): bool {
        return $this->Ponto_Tema->adicionar($pontoTema);
    }
    public function alterar(Ponto_Tema $pontoTema): bool {
        return $this->Ponto_Tema->alterar($pontoTema);
    }
    public function buscarPorId(int $id): ?Ponto_Tema {
        return $this->Ponto_Tema->buscarPorIdPonto($id);
    }
    public function buscarPorIdTema(int $id): ?Ponto_Tema {
        return $this->Ponto_Tema->buscarPorIdTema($id);
    }
    public function listarTodos(): array {
        return $this->Ponto_Tema->listarTodos();
    }
    public function deletar(int $id): bool {
        return $this->Ponto_Tema->deletar($id);
    }
}