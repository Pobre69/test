<?php

namespace Ponto_Tema\Repository;

require_once __DIR__ . '/../../DataBase/DB_Global_Conection/DB_Conection.php';
require_once __DIR__ . '/../Models/Ponto_Tema.php';
require_once __DIR__ . '/ICRUDrepository.php';

use CRUDrepository\Interface\IPonto_TemaRepository;
use Ponto_Tema\Models\Ponto_Tema;
use DataBase\DB_Global_Conection\DB_Conection;
use PDO;

class Ponto_TemaRepository implements IPonto_TemaRepository{

    private PDO $conn;

    public function __construct() {
        $this->conn = DB_Conection::getConnection();
    }

    public function adicionar(Ponto_Tema $pontoTema): bool {
        $sql = "CALL Controlador_Ponto_Tema(
            :acao, :idPonto, 
            :idTema, :Ponto_Turistico_Natural
        )";

        $stmt = $this->conn->prepare($sql);

        return $stmt->execute($this->mapParams($pontoTema, 'adicionar'));
    }
    public function alterar(Ponto_Tema $pontoTema): bool {
        $sql = "CALL Controlador_Ponto_Tema(
            :acao, :idPonto, 
            :idTema, :Ponto_Turistico_Natural
        )";

        $stmt = $this->conn->prepare($sql);

        return $stmt->execute($this->mapParams($pontoTema, 'alterar'));
    }
    public function listarTodos(): array {
        $sql = "CALL Controlador_Ponto_Tema(
            :acao, NULL,
            NULL, NULL
        )";

        $stmt = $this->conn->prepare($sql);
        $stmt->execute([':acao' => 'index']);

        return $stmt->fetchAll(PDO::FETCH_CLASS, Ponto_Tema::class);
    }
    public function buscarPorIdPonto(int $id): ?Ponto_Tema {
        $sql = "CALL Controlador_Ponto_Tema(
            :acao, :idPonto,
            NULL, NULL
        )";

        $stmt = $this->conn->prepare($sql);
        $stmt->execute([':acao' => 'showPonto', ':idPonto' => $id]);

        $result = $stmt->fetchObject(Ponto_Tema::class);
        return $result ?: null;
    }
    public function buscarPorIdTema(int $id): ?Ponto_Tema {
        $sql = "CALL Controlador_Ponto_Tema(
            :acao, NULL,
            :idTema, NULL
        )";

        $stmt = $this->conn->prepare($sql);
        $stmt->execute([':acao' => 'showTema', ':idTema' => $id]);

        $result = $stmt->fetchObject(Ponto_Tema::class);
        return $result ?: null;
    } 
    public function deletar(int $id): bool {
        $sql = "CALL Controlador_Ponto_Tema(
            :acao, NULL,
            :idPonto, NULL, NULL
        )";

        $stmt = $this->conn->prepare($sql);

        return $stmt->execute([':acao' => 'delete', ':idPonto' => $id]);
    }
    private function mapParams(Ponto_Tema $pontoTema, string $action): array {
        $params = [
            ':acao' => $action,
            ':idPonto' => $pontoTema->idPonto,
            ':idTema' => $pontoTema->idTema,
            ':Ponto_Turistico_Natural' => $pontoTema->Ponto_Turistico_Natural
        ];

        return $params;
    }
}