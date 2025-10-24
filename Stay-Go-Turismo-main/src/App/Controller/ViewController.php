<?php

namespace View\Controller;

use DarkMode\Models\DarkMode;
use FeedBacks\Controller\FeedBacksController;
use csrf\token\csrf_Token;

class ViewController
{
    public static function render(string $viewName)
    {
        $csrf = new csrf_Token();
        $csrf->generateToken();
        $DarkMode = new DarkMode();
        $DarkMode = $DarkMode->getMode();
        $First_ulr = '/Sites/Stay-Go-Turismo-main/src/Routes/Web.php';
        $viewPath = __DIR__ . "/../../Resources/View/" . $viewName . ".php";
        if (file_exists($viewPath)) {
            include_once($viewPath);
        } else {
            header("HTTP/1.0 404 Not Found");
            echo "View not found.";
        }
    }
}