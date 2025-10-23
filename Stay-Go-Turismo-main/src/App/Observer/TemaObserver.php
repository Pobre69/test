<?php

namespace Tema\Observer;

require_once __DIR__ . "/../Models/Tema.php";
require_once __DIR__ . "/../../DataBase/DB_Global_Conection/DB_Conection.php";

use Tema\Models\Tema;
use DataBase\DB_Global_Conection\DB_Conection;
use PDO;

class TemaObserver {
    private PDO $conn;

    public function __construct() {
        $this->conn = DB_Conection::getConnection();
    }

    public function toString(Tema $tema): string {
        return "ID: {$tema->idTema}, Tema: {$tema->Tema}";
    }

    public function creating(Tema $tema): void {}

    public function created(Tema $tema): void {
        $this->conn->prepare("INSERT INTO Auditoria_PHP(id, id_tema, nome_tabela, detalhamento, data) VALUES (null, :tema_id, :tabela, :detalhe, current_timestamp())")
            ->execute([
                ':tema_id' => $tema->idTema,
                ':tabela' => 'tema',
                ':detalhe' => 'Tema criado: ' . $this->toString($tema)
            ]);
    }

    public function updating(Tema $tema): void {}

    public function updated(Tema $tema): void {
        $this->conn->prepare("INSERT INTO Auditoria_PHP(id, id_tema, nome_tabela, detalhamento, data) VALUES (null, :tema_id, :tabela, :detalhe, current_timestamp())")
            ->execute([
                ':tema_id' => $tema->idTema,
                ':tabela' => 'tema',
                ':detalhe' => 'Tema atualizado: ' . $this->toString($tema)
            ]);
    }

    public function deleting(Tema $tema): void {}

    public function deleted(Tema $tema): void {
        $this->conn->prepare("INSERT INTO Auditoria_PHP(id, id_tema, nome_tabela, detalhamento, data) VALUES (null, :tema_id, :tabela, :detalhe, current_timestamp())")
            ->execute([
                ':tema_id' => $tema->idTema,
                ':tabela' => 'tema',
                ':detalhe' => 'Tema deletado: ' . $this->toString($tema)
            ]);
    }
}