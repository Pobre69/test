<?php

namespace Tema\Repository;

require_once __DIR__ . '/../../DataBase/DB_Global_Conection/DB_Conection.php';
require_once __DIR__ . '/../Models/Tema.php';
require_once __DIR__ . '/ICRUDrepository.php';
require_once __DIR__ . '/../Observer/TemaObserver.php';

use CRUDrepository\Interface\ITemaRepository;
use Tema\Models\Tema;
use Tema\Observer\TemaObserver;
use DataBase\DB_Global_Conection\DB_Conection;
use PDO;

class TemaRepository implements ITemaRepository{

    private PDO $conn;

    public function __construct() {
        $this->conn = DB_Conection::getConnection();
    }

    public function adicionar(Tema $tema): bool {
        $sql = "CALL Controlador_Tema(
            :acao, NULL,
            :param_Tema
        )";

        $stmt = $this->conn->prepare($sql);

        return $stmt->execute($this->mapParams($tema, 'adicionar'));

        TemaObserver::created($tema);
    }

    public function alterar(Tema $tema): bool {
        $sql = "CALL Controlador_Tema(
            :acao, :id,
            :param_Tema
        )";

        $stmt = $this->conn->prepare($sql);

        return $stmt->execute($this->mapParams($tema, 'alterar'));

        PontoTuristicoObserver::updated($tema);

        TemaObserver::updated($tema);
    }
    public function listarTodos(): array {
        $sql = "CALL Controlador_Tema(
            :acao, NULL,
            NULL
        )";

        $stmt = $this->conn->prepare($sql);
        $stmt->execute([':acao' => 'index']);

        return $stmt->fetchAll(PDO::FETCH_CLASS, Tema::class);
    }
    public function buscarPorId(int $id): ?Tema {
        $sql = "CALL Controlador_Tema(
            :acao, :id,
            NULL
        )";

        $stmt = $this->conn->prepare($sql);
        $stmt->execute([
            ':acao' => 'show',
            ':id' => $id
        ]);

        $stmt->setFetchMode(PDO::FETCH_CLASS, Tema::class);
        $tema = $stmt->fetch();

        return $tema ?: null;
    }
    public function deletar(int $id): bool {
        $sql = "CALL Controlador_Tema(
            :acao, :id,
            NULL
        )";

        $stmt = $this->conn->prepare($sql);
        return $stmt->execute([':acao' => 'deletar', ':id' => $id]);

        TemaObserver::deleted($this->buscarPorId($id));
    }
    private function mapParams(Tema $tema, string $action): array {
        $params = [
            ':acao' => $action,
            ':param_Tema' => $tema->Tema
        ];

        if ($action === 'alterar') {
            $params[':id'] = $tema->idTema;
        }

        return $params;
    }
}