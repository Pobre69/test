<?php

namespace FeedBacks\Models;

class FeedBacks{
    public ?int $id;
    public string $autor;
    public string $comunicado;
    public string $cidade;
    public string $data_comunicado;
    public string $status;

    public function __construct(array $data) {
        $this->id = $data['FB_id'] ?? null;
        $this->autor = $data['FB_autor'];
        $this->comunicado = $data['FB_comunicado'];
        $this->cidade = $data['FB_cidade'];
        $this->data_comunicado = $data['FB_data_comunicado'];
        $this->status = $data['FB_status'];
    }
}