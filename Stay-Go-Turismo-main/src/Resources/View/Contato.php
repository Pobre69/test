<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Stay Go Turismo</title>
    <link rel="stylesheet" href="../../Web/css/index.css">
    <link rel="stylesheet" href="../../Web/css/Texts.css">
    <link rel="stylesheet" href="../../Web/css/contato.css">
    <?php if($DarkMode ?? false == true): ?>
        <link rel="stylesheet" href="../../Web/css/DarkMode.css">
    <?php else: ?>
        <link rel="stylesheet" href="../../Web/css/LightMode.css">
    <?php endif ?>
</head>
<body>
    <?php 
        include_once(__DIR__ . '../../Components/Menu.php');
        include_once(__DIR__ . '../../Components/Header.php');
        include_once(__DIR__ . '../../Components/Black_BackGround.html');
    ?>

    <div class="container">
        <div class="box contatos">
            <h2>Meus Contatos</h2>

            <a href="22400311@aluno.cotemig.com.br" target="_blank">
                <img src="https://img.icons8.com/color/48/gmail-new.png" alt="Gmail" width="24" height="24">
                Enviar e-mail
            </a>

            <a href="https://youtube.com/@arthurvictor-hp8cv?si=Ol3q14ADBymiBaDS" target="_blank">
                <img src="https://img.icons8.com/color/48/youtube-play.png" alt="YouTube" width="24" height="24">
                Visite meu canal no YouTube
            </a>

            <a href="https://www.instagram.com/arthurvictor_gv/" target="_blank">
                <img src="https://img.icons8.com/color/48/instagram-new--v1.png" alt="Instagram" width="24" height="24">
                Me siga no Instagram
            </a>
        </div>

        <div class="box">
            <h2>Envie seu feedback</h2>
            <form method="POST" action="/feedBack">
                <input type="hidden" name="_token" value="<?php echo htmlspecialchars($_SESSION['csrf_token']); ?>">
                <label for="nome">Nome</label>
                <input type="text" id="nome" name="nome" required>

                <label for="cidade">Cidade</label>
                <input type="text" id="cidade" name="cidade" required>

                <label for="mensagem">Feedback</label>
                <textarea id="mensagem" name="mensagem" rows="6" required></textarea>

                <button type="submit">Enviar</button>
            </form>
        </div>
    </div>

    <?php
        include_once(__DIR__ . '../../Components/Footer.html');
    ?>

    <script src="../../Web/JavaScript/index.js"></script>
    <script src="../../Web/JavaScript/Global.js"></script>
</body>
</html>