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
        
        $results = $stmt->fetchAll(PDO::FETCH_ASSOC);
        $returns = [];

        foreach ($results as $result){
            $Citacao_Referencia = new CitacoesReferencia($result);
            $returns[] = $Citacao_Referencia;
        }

        return $returns;
    }
}