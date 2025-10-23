<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Stay Go Turismo</title>
    <link rel="stylesheet" href="../../Web/css/index.css">
    <link rel="stylesheet" href="../../Web/css/Texts.css">
    <link rel="stylesheet" href="../../Web/css/quemsomos.css">
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
    
    <main>
        <h1 class="page-title Color4">Quem Somos</h1>

        <section class="team-container">
            <div class="team-member BColor5">
                <img src="../../Web/Imagens/Integrantes/enzo.jpg" class="member-image">
                <div class="member-info">
                    <h2 class="member-name Color3">Enzo</h2>
                    <p class="member-role Color6">Desenvolvedor Backend</p>
                    <p class="member-contribution Color7 BorderColor2">Responsável pela arquitetura e desenvolvimento do backend do projeto, implementando APIs robustas e gerenciamento de banco de dados.</p>
                </div>
            </div>
            <div class="team-member BColor5">
                <img src="../../Web/Imagens/Integrantes/img.jpg" class="member-image">
                <div class="member-info">
                    <h2 class="member-name Color3">Kayque</h2>
                    <p class="member-role Color6">Desenvolvedor Backend</p>
                    <p class="member-contribution Color7 BorderColor2">Responsável pela arquitetura e desenvolvimento do backend do projeto, implementando APIs robustas e gerenciamento de banco de dados.</p>
                </div>
            </div>
            <div class="team-member BColor5">
                <img src="../../Web/Imagens/Integrantes/img.jpg" class="member-image">
                <div class="member-info">
                    <h2 class="member-name Color3">Davi</h2>
                    <p class="member-role Color6">Desenvolvedor Backend</p>
                    <p class="member-contribution Color7 BorderColor2">Responsável pela arquitetura e desenvolvimento do backend do projeto, implementando APIs robustas e gerenciamento de banco de dados.</p>
                </div>
            </div>
            <div class="team-member BColor5">
                <img src="../../Web/Imagens/Integrantes/lopes.jpg" class="member-image">
                <div class="member-info">
                    <h2 class="member-name Color3">Arthur Lopes</h2>
                    <p class="member-role Color6">Desenvolvedor Backend</p>
                    <p class="member-contribution Color7 BorderColor2">Responsável pela arquitetura e desenvolvimento do backend do projeto, implementando APIs robustas e gerenciamento de banco de dados.</p>
                </div>
            </div>
            <div class="team-member BColor5">
                <img src="../../Web/Imagens/Integrantes/pedroV.jpg" class="member-image">
                <div class="member-info">
                    <h2 class="member-name Color3">Pedro</h2>
                    <p class="member-role Color6">Desenvolvedor Backend</p>
                    <p class="member-contribution Color7 BorderColor2">Responsável pela arquitetura e desenvolvimento do backend do projeto, implementando APIs robustas e gerenciamento de banco de dados.</p>
                </div>
            </div>
            <div class="team-member BColor5">
                <img src="../../Web/Imagens/Integrantes/china.jpg" class="member-image">
                <div class="member-info">
                    <h2 class="member-name Color3">Arthur Victor</h2>
                    <p class="member-role Color6">Desenvolvedor Backend</p>
                    <p class="member-contribution Color7 BorderColor2">Responsável pela arquitetura e desenvolvimento do backend do projeto, implementando APIs robustas e gerenciamento de banco de dados.</p>
                </div>
            </div>
        </section>
    </main>

    <?php
        include_once(__DIR__ . '../../Components/Footer.html');
    ?>

    <script src="../../Web/JavaScript/index.js"></script>
    <script src="../../Web/JavaScript/Global.js"></script>
</body>
</html>