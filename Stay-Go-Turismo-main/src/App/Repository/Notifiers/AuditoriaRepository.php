<?php

namespace Auditoria\Repository;

require_once __DIR__ . '/INotifyRepository.php';
require_once __DIR__ . '/../../../DataBase/DB_Global_Conection/DB_Conection.php';
require_once __DIR__ . '/../../Models/Auditoria.php';

use INotifyRepository\Interface\INotifyRepository;
use Auditoria\Models\Auditoria;
use DataBase\DB_Global_Conection\DB_Conection;
use PDO;

class AuditoriaRepository implements INotifyRepository
{
    private PDO $conn;

    public function __construct()
    {
        $this->conn = DB_Conection::getConnection();
    }

    public function adicionar(PontoTuristico $ponto): bool
    {
        return false;
    }

    public function listarTodos(): array
    {
        $sql = "SELECT * FROM Auditoria_PHP";

        $stmt = $this->conn->prepare($sql);

        return $stmt->fetchAll(PDO::FETCH_CLASS, Auditoria::class);
    }
}