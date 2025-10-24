<?php

namespace PontoTuristico\Facade;



use PontoTuristico\Repository\PontoTuristicoRepository;
use Ponto\Compositers\PontoSearch;
use Avaliacao\Decorators\AvaliacaoFilter;
use Cidades\Decorators\CidadeFilter;
use Estado\Decorators\EstadoFilter;
use Estacionamento\Decorators\EstacionamentoFilter;
use Horario\Decorators\HorarioFilter;
use Natural\Decorators\NaturalFilter;
use TemaFilter\Decorators\TemaFilter;
use Visitantes\Decorators\VisitantesFilter;

class PontoTuristicoFacade
{
    public static function filtrar(array $input): array
    {
        $repo = new PontoTuristicoRepository();
        $search = new PontoSearch($repo);

        if (isset($input["avaliacaoMin"]) || isset($input["avaliacaoMax"])) {
            $search = new AvaliacaoFilter($search, $input["avaliacaoMin"] ?? null, $input["avaliacaoMax"] ?? null);
        }

        if (isset($input["cidade"])) {
            $search = new CidadeFilter($search, $input["cidade"]);
        }

        if (isset($input["estado"])) {
            $search = new EstadoFilter($search, $input["estado"]);
        }

        if (isset($input["estacionamento"])) {
            $search = new EstacionamentoFilter($search, $input["estacionamento"]);
        }

        if (isset($input["horarioAberturaMin"]) || isset($input["horarioFechamentoMax"])) {
            $search = new HorarioFilter($search, $input["horarioAberturaMin"] ?? null, $input["horarioFechamentoMax"] ?? null);
        }

        if (isset($input["natural"])) {
            $search = new NaturalFilter($search, $input["natural"]);
        }

        if (isset($input["patrimonio"])) {
            $search = new PatrimonioFilter($search, $input["patrimonio"]);
        }

        if (isset($input["visitantesMin"]) || isset($input["visitantesMax"])) {
            $search = new VisitantesFilter($search, $input["visitantesMin"] ?? null, $input["visitantesMax"] ?? null);
        }

        return $search->execute_search($input["nome"] ?? "");
    }
}