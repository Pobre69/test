<?php

namespace DataBase\DB_Global_Conection;

use PDO;
use PDOException;

class DB_Conection {

    private static ?PDO $conn = null;

    public static function getConnection(): PDO {
        if (self::$conn === null) {
            $host = "localhost";
            $usuario = "root";
            $senha = "arthurpro4";
            $banco = "stayGoTurismo";

            $dsn = "mysql:host=$host;dbname=$banco;charset=utf8mb4";

            try {
                self::$conn = new PDO($dsn, $usuario, $senha, [
                    PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
                    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
                    PDO::ATTR_EMULATE_PREPARES => false
                ]);
            } catch (PDOException $e) {
                throw new \RuntimeException("Erro na conexão com o banco de dados: " . $e->getMessage());
            }
        }

        return self::$conn;
    }
}
