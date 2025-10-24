<?php

namespace PastasAcesso\Routes;

class Acesso
{
    public static function getAllBuscas()
    {
        require_once __DIR__ . "/../App/Buscas/FinalSearch.php";
        require_once __DIR__ . "/../App/Buscas/ISearch.php";
        
        require_once __DIR__ . "/../App/Buscas/Compositers/top10Search.php";
        require_once __DIR__ . "/../App/Buscas/Compositers/PontoSearch.php";
        require_once __DIR__ . "/../App/Buscas/Compositers/TemaSearch.php";

        require_once __DIR__ . "/../App/Buscas/Decorators/AvaliacaoFilter.php";
        require_once __DIR__ . "/../App/Buscas/Decorators/CidadeFilter.php";
        require_once __DIR__ . "/../App/Buscas/Decorators/EstacionamentoFilter.php";
        require_once __DIR__ . "/../App/Buscas/Decorators/EstadoFilter.php";
        require_once __DIR__ . "/../App/Buscas/Decorators/HorarioFilter.php";
        require_once __DIR__ . "/../App/Buscas/Decorators/NaturalFilter.php";
        require_once __DIR__ . "/../App/Buscas/Decorators/PatrimonioFilter.php";
        require_once __DIR__ . "/../App/Buscas/Decorators/TemaFilter.php";
        require_once __DIR__ . "/../App/Buscas/Decorators/VisitantesFilter.php";
    }
    public static function getAllModels()
    {
        require_once __DIR__ . "/../App/Models/PontoTuristico.php";
        require_once __DIR__ . "/../App/Models/Tema.php";
        require_once __DIR__ . "/../App/Models/Ponto_Tema.php";
        require_once __DIR__ . "/../App/Models/DarkMode.php";
        require_once __DIR__ . "/../App/Models/FeedBacks.php";
        require_once __DIR__ . "/../App/Models/Auditoria.php";
        require_once __DIR__ . "/../App/Models/Citacoes_Referencias.php";
    }
    public static function getAllRepositories()
    {
        require_once __DIR__ . "/../App/Repository/ICRUDrepository.php";
        require_once __DIR__ . "/../App/Repository/PontoTuristicoRepository.php";
        require_once __DIR__ . "/../App/Repository/TemaRepository.php";
        require_once __DIR__ . "/../App/Repository/Ponto_TemaRepository.php";
        require_once __DIR__ . "/../App/Repository/Ponto_TemaAdapter.php";
        require_once __DIR__ . "/../App/Repository/Notifiers/FeedBackRepository.php";
        require_once __DIR__ . "/../App/Repository/Notifiers/AuditoriaRepository.php";
        require_once __DIR__ . "/../App/Repository/Notifiers/INotifyRepository.php";
        require_once __DIR__ . "/../App/Repository/CitacaoReferenciaRepository.php";
    }
    public static function getAllFacades()
    {
        require_once __DIR__ . "/../App/Facades/PontoTuristicoFacade.php";
    }
    public static function getAllControllers()
    {
        require_once __DIR__ . "/../App/Controller/FeedBacksController.php";
        require_once __DIR__ . "/../App/Controller/PontoTuristicoController.php";
        require_once __DIR__ . "/../App/Controller/TemaController.php";
        require_once __DIR__ . "/../App/Controller/ViewController.php";
        require_once __DIR__ . "/../App/Controller/csrf_Token.php";
        require_once __DIR__ . "/../App/Controller/CitacoesReferenciaController.php";
    }
    public static function getAllObservers()
    {
        require_once __DIR__ . "/../App/Observer/PontoTuristicoObserver.php";
        require_once __DIR__ . "/../App/Observer/TemaObserver.php";
    }
    public static function getDBConnectionRoute()
    {
        require_once __DIR__ . "/../DataBase/DB_Global_Conection/DB_Conection.php";
    }
    public static function getAllRoutes()
    {
        self::getDBConnectionRoute();
        self::getAllModels();
        self::getAllRepositories();
        self::getAllFacades();
        self::getAllControllers();
        self::getAllObservers();
        self::getAllBuscas();
    }
}