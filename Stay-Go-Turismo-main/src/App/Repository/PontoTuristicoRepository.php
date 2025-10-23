<?php

namespace PontoTuristico\Repository;

require_once __DIR__ . '/../../DataBase/DB_Global_Conection/DB_Conection.php';
require_once __DIR__ . '/../Models/PontoTuristico.php';
require_once __DIR__ . '/ICRUDrepository.php';
require_once __DIR__ . '/../Observer/PontoTuristicoObserver.php';

use CRUDrepository\Interface\IPontoRepository;
use PontoTuristico\Models\PontoTuristico;
use PontoTuristico\Observer\PontoTuristicoObserver;
use DataBase\DB_Global_Conection\DB_Conection;
use PDO;

class PontoTuristicoRepository implements IPontoRepository{

    private PDO $conn;

    public function __construct() {
        $this->conn = DB_Conection::getConnection();
    }

    public function adicionar(PontoTuristico $ponto): bool {
        $sql = "CALL Controlador_Ponto_Turistico(
            :acao, NULL,
            :param_complemento, :param_nome, :param_estado, :param_cidade, :param_bairro, :param_cep,
            :param_horarioAbertura, :param_horarioAberturaF, :param_horarioFechamento, :param_horarioFechamentoF,
            :param_precoEntrada, :param_estacionamento, :param_estruturasServicao, :param_avaliacaoGeral,
            :param_contato, :param_site, :param_email, :param_pacote, :param_visitantes
        )";

        $stmt = $this->conn->prepare($sql);

        return $stmt->execute($this->mapParams($ponto, 'adicionar'));

        PontoTuristicoObserver::created($ponto);
    }

    public function alterar(PontoTuristico $ponto): bool {
        $sql = "CALL Controlador_Ponto_Turistico(
            :acao, :id,
            :param_complemento, :param_nome, :param_estado, :param_cidade, :param_bairro, :param_cep,
            :param_horarioAbertura, :param_horarioAberturaF, :param_horarioFechamento, :param_horarioFechamentoF,
            :param_precoEntrada, :param_estacionamento, :param_estruturasServicao, :param_avaliacaoGeral,
            :param_contato, :param_site, :param_email, :param_pacote, :param_visitantes
        )";

        $stmt = $this->conn->prepare($sql);

        return $stmt->execute($this->mapParams($ponto, 'alterar'));

        PontoTuristicoObserver::updated($ponto);
    }

    public function listarTodos(): array {
        $sql = "CALL Controlador_Ponto_Turistico(
            :acao, NULL,
            NULL, NULL, NULL, NULL, NULL, NULL,
            NULL, NULL, NULL, NULL,
            NULL, NULL, NULL, NULL,
            NULL, NULL, NULL, NULL, NULL
        )";

        $stmt = $this->conn->prepare($sql);
        $stmt->execute([':acao' => 'index']);

        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
        $pontos = [];

        foreach ($result as $row) {
            $pontos[] = new PontoTuristico($row);
        }

        return $pontos;
    }

    public function buscarPorId(int $id): ?PontoTuristico {
        $sql = "CALL Controlador_Ponto_Turistico(
            :acao, :id,
            NULL, NULL, NULL, NULL, NULL, NULL,
            NULL, NULL, NULL, NULL,
            NULL, NULL, NULL, NULL,
            NULL, NULL, NULL, NULL, NULL
        )";

        $stmt = $this->conn->prepare($sql);
        $stmt->execute([':acao' => 'show', ':id' => $id]);

        $result = $stmt->fetch(PDO::FETCH_ASSOC);

        return $result ? new PontoTuristico($result) : null;
    }

    public function deletar(int $id): bool {
        $sql = "CALL Controlador_Ponto_Turistico(
            :acao, :id,
            NULL, NULL, NULL, NULL, NULL, NULL,
            NULL, NULL, NULL, NULL,
            NULL, NULL, NULL, NULL,
            NULL, NULL, NULL, NULL, NULL
        )";

        $stmt = $this->conn->prepare($sql);
        return $stmt->execute([':acao' => 'delete', ':id' => $id]);

        PontoTuristicoObserver::deleted($this->buscarPorId($id));
    }

    private function mapParams(PontoTuristico $ponto, string $acao): array {
        return [
            ':acao' => $acao,
            ':id' => $ponto->idPonto ?? null,
            ':param_complemento' => $ponto->complemento,
            ':param_nome' => $ponto->nome,
            ':param_estado' => $ponto->estado,
            ':param_cidade' => $ponto->cidade,
            ':param_bairro' => $ponto->bairro,
            ':param_cep' => $ponto->CEP,
            ':param_horarioAbertura' => $ponto->horarioAbertura,
            ':param_horarioAberturaF' => $ponto->horarioAberturaF,
            ':param_horarioFechamento' => $ponto->horarioFechamento,
            ':param_horarioFechamentoF' => $ponto->horarioFechamentoF,
            ':param_precoEntrada' => $ponto->precoEntrada,
            ':param_estacionamento' => $ponto->estacionamento,
            ':param_estruturasServicao' => $ponto->estruturasServicao,
            ':param_avaliacaoGeral' => $ponto->avaliacaoGeral,
            ':param_contato' => $ponto->contato,
            ':param_site' => $ponto->site,
            ':param_email' => $ponto->email,
            ':param_pacote' => $ponto->pacote,
            ':param_visitantes' => $ponto->visitantes
        ];
    }
}
