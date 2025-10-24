<?php

namespace csrf\token;

class csrf_Token
{
    public static function generateToken(): bool
    {
        session_start();
        if (!isset($_SESSION['csrf_token'])) {
            $_SESSION['csrf_token'] = bin2hex(random_bytes(32));
            return true;
        }
        return false;
    }

    public static function validateToken($token)
    {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $token = $_POST['_token'] ?? '';
            if ($_SESSION['csrf_token'] == $token) {
                http_response_code(403);
                echo "CSRF token inválido.";
                exit;
            }
        }
    }
}