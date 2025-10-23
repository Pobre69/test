<?php

namespace PontoTuristico\Observer;

require_once __DIR__ . "/../Models/PontoTuristico.php";
require_once __DIR__ . "/../../DataBase/DB_Global_Conection/DB_Conection.php";

use PontoTuristico\Models\PontoTuristico;
use DataBase\DB_Global_Conection\DB_Conection;
use PDO;

class PontoTuristicoObserver {
    private PDO $conn;

    public function __construct() {
        $this->conn = DB_Conection::getConnection();
    }

    public function toString(PontoTuristico $ponto): string {
        return "ID: {$ponto->idPonto}, Nome: {$ponto->nome}, Endereço: {$ponto->endereco}, Cidade: {$ponto->cidade}, Estado: {$ponto->estado}";
    }

    public function creating(PontoTuristico $ponto): void {}

    public function created(PontoTuristico $ponto): void {
        $this->conn->prepare("INSERT INTO Auditoria_PHP(id, id_ponto, nome_tabela, detalhamento, data) VALUES (null, :ponto_id, :tabela, :detalhe, current_timestamp())")
            ->execute([
                ':ponto_id' => $ponto->idPonto,
                ':tabela' => 'ponto_turistico',
                ':detalhe' => 'Ponto Turístico criado: ' . toString($ponto)
            ]);
    }

    public function updating(PontoTuristico $ponto): void {}

    public function updated(PontoTuristico $ponto): void {
        $this->conn->prepare("INSERT INTO Auditoria_PHP(id, id_ponto, nome_tabela, detalhamento, data) VALUES (null, :ponto_id, :tabela, :detalhe, current_timestamp())")
            ->execute([
                ':ponto_id' => $ponto->idPonto,
                ':tabela' => 'ponto_turistico',
                ':detalhe' => 'Ponto Turístico atualizado: ' . toString($ponto)
            ]);
    }

    public function deleting(PontoTuristico $ponto): void {}

    public function deleted(PontoTuristico $ponto): void {
        $this->conn->prepare("INSERT INTO Auditoria_PHP(id, id_ponto, nome_tabela, detalhamento, data) VALUES (null, :ponto_id, :tabela, :detalhe, current_timestamp())")
            ->execute([
                ':ponto_id' => $ponto->idPonto,
                ':tabela' => 'ponto_turistico',
                ':detalhe' => 'Ponto Turístico deletado: ' . toString($ponto)
            ]);
    }
}