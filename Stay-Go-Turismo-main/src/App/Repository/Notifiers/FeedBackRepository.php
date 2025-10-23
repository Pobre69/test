<?php

namespace FeedBacks\Repository;

require_once __DIR__ . '/INotifyRepository.php';
require_once __DIR__ . '/../../../DataBase/DB_Global_Conection/DB_Conection.php';
require_once __DIR__ . '/../../Models/FeedBacks.php';

use INotifyRepository\Interface\INotifyRepository;
use FeedBacks\Models\FeedBacks;
use DataBase\DB_Global_Conection\DB_Conection;
use PDO;

class FeedBackRepository implements INotifyRepository
{
    private PDO $conn;

    public function __construct()
    {
        $this->conn = DB_Conection::getConnection();
    }

    public function adicionar(PontoTuristico $ponto): bool
    {
        $sql = "CALL Adicionar_FeedBack(:comunicado, :autor, :cidade, @dataCriacao, @status)";

        $stmt = $this->conn->prepare($sql);
        $stmt->execute([
            ':comunicado' => $ponto->comunicado, 
            ':autor' => $ponto->autor, 
            ':cidade' => $ponto->cidade
        ]);

        return true;
    }

    public function listarTodos(): array
    {
        $sql = "SELECT * FROM Show_FeedBacks";

        $stmt = $this->conn->prepare($sql);

        return $stmt->fetchAll(PDO::FETCH_CLASS, FeedBacks::class);
    }
}