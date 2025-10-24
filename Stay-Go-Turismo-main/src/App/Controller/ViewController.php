<?php

namespace View\Controller;

use DarkMode\Models\DarkMode;

class ViewController
{
    public static function render(string $viewName)
    {
        DarkMode::getMode();
        $viewPath = __DIR__ . "/../../Resources/View/" . $viewName . ".php";
        if (file_exists($viewPath)) {
            include_once(__DIR__ . "/../../Resources/View/" . $viewName . ".php");
        } else {

            header("HTTP/1.0 404 Not Found");
            echo "View not found.";
        }
    }
}