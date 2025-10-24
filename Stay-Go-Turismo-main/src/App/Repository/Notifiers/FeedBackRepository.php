<?php

namespace FeedBacks\Repository;

require_once __DIR__ . '/INotifyRepository.php';
require_once __DIR__ . '/../../../DataBase/DB_Global_Conection/DB_Conection.php';
require_once __DIR__ . '/../../Models/FeedBacks.php';

use INotifyRepository\Interface\INotifyRepositoryFeedBack;
use FeedBacks\Models\FeedBacks;
use DataBase\DB_Global_Conection\DB_Conection;
use PontoTuristico\Models\PontoTuristico;
use PDO;

class FeedBackRepository implements INotifyRepositoryFeedBack
{
    private PDO $conn;

    public function __construct()
    {
        $this->conn = DB_Conection::getConnection();
    }

    public function adicionar(FeedBacks $FeedBacks): bool
    {
        $sql = "CALL Adicionar_FeedBack(:comunicado, :autor, :cidade)";

        $stmt = $this->conn->prepare($sql);
        $stmt->execute([
            ':comunicado' => $FeedBacks->comunicado, 
            ':autor' => $FeedBacks->autor, 
            ':cidade' => $FeedBacks->cidade
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