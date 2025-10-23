<?php

namespace PontoTuristico\Models;

class PontoTuristico{
    public ?int $idPonto;
    public string $nome;
    public ?string $complemento;
    public string $estado;
    public string $cidade;
    public ?string $bairro;
    public ?int $CEP;
    public string $endereco;
    
    public string $horarioAbertura;
    public ?string $horarioAberturaF;
    public string $horarioFechamento;
    public ?string $horarioFechamentoF;

    public ?string $contato;
    public ?string $site;
    public ?string $email;

    public ?float $precoEntrada;
    public bool $estacionamento;
    public ?string $estruturasServico;
    public float $avaliacaoGeral;
    public ?string $pacote;
    public ?int $visitantes;

    public function __construct(array $data) {
        $this->idPonto = $data['pt_id'] ?? null;
        $this->nome = $data['pt_nome'] ?? '';
        $this->complemento = $data['pt_c1'] ?? null;
        $this->estado = $data['pt_c2'] ?? '';
        $this->cidade = $data['pt_c3'] ?? '';
        $this->bairro = $data['pt_c4'] ?? null;
        $this->CEP = $data['pt_c5'] ?? null;
        $this->endereco = $data['pt_c6'] ?? '';

        $this->horarioAbertura = $data['pt_c7'] ?? '';
        $this->horarioAberturaF = $data['pt_c8'] ?? null;
        $this->horarioFechamento = $data['pt_c9'] ?? '';
        $this->horarioFechamentoF = $data['pt_c10'] ?? null;

        $this->contato = $data['pt_c11'] ?? null;
        $this->site = $data['pt_c12'] ?? null;
        $this->email = $data['pt_c13'] ?? null;

        $this->precoEntrada = $data['pt_c14'] ?? null;
        $this->estacionamento = $data['pt_c15'] ?? false;
        $this->estruturasServicao = $data['pt_c16'] ?? null;
        $this->avaliacaoGeral = $data['pt_c17'] ?? 0.0;
        $this->pacote = $data['pt_c18'] ?? null;
    }
}