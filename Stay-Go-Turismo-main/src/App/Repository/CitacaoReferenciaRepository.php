<?php

namespace CitacoesReferencia\Repository;

use CitacoesReferencia\Models\CitacoesReferencia;
use DataBase\DB_Global_Conection\DB_Conection;
use PDO;

class CitacoesReferenciaRepository {

    private PDO $conn;

    public function __construct() {
        $this->conn = DB_Conection::getConnection();
    }

    public function listarTodos(): array {
        $sql = "SELECT * FROM Show_Citacoes_Referencias;";

        $stmt = $this->conn->prepare($sql);
        $stmt->execute();

        return $stmt->fetchAll(PDO::FETCH_CLASS, CitacoesReferencia::class);
    }
}