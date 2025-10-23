<?php

namespace Tema\Composite;

require_once __DIR__ . '/../../../DataBase/DB_Global_Conection/DB_Conection.php';
require_once __DIR__ . '/../ISearch.php';

use DataBase\DB_Global_Conection\DB_Conection;
use Search\Interface\ISearchCompositeService;
use PDO;

class TemaSearch implements ISearchCompositeService {
    private PDO $conn;
    private array $searchServices = [];

    public function __construct() {
        $this->conn = DB_Conection::getConnection();
    }

    public function execute_search(string $query): array {
        $sql = "SELECT * FROM Show_All WHERE t_tema LIKE :query";
        $stmt = $this->conn->prepare($sql);
        $stmt->bindValue(':query', '%' . $query . '%');
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }
}