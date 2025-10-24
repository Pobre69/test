<?php

namespace top10\Composite;

use DataBase\DB_Global_Conection\DB_Conection;
use Search\Interface\ISearchCompositeService;
use PDO;

class top10Search implements ISearchCompositeService 
{
    private PDO $conn;
    private array $searchServices = [];

    public function __construct() {
        $this->conn = DB_Conection::getConnection();
    }

    public function execute_search(string $query): array {
        $sql = "SELECT * FROM Show_All WHERE pt_nome LIKE :query ORDER BY pt_views ASC LIMIT 10";
        $stmt = $this->conn->prepare($sql);
        $stmt->bindValue(':query', '%' . $query . '%');
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }
}