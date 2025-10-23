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
                    <p class="member-role Color6">Criador do Banco de Dados</p>
                    <p class="member-contribution Color7 BorderColor2">Responsável pela modelagem, criação e implementação do banco de dados, bem como pela inserção inicial dos dados necessários para o funcionamento do sistema.</p>
                </div>
            </div>
            <div class="team-member BColor5">
                <img src="../../Web/Imagens/Integrantes/kayque.jpg" class="member-image">
                <div class="member-info">
                    <h2 class="member-name Color3">Kayque</h2>
                    <p class="member-role Color6">Gerente do Banco de Dados</p>
                    <p class="member-contribution Color7 BorderColor2">Responsável pela administração e controle das informações armazenadas no banco de dados, assegurando a integridade e segurança dos dados, além de disponibilizá-los de forma adequada para a equipe de desenvolvimento back-end.</p>
                </div>
            </div>
            <div class="team-member BColor5">
                <img src="../../Web/Imagens/Integrantes/davi.jpg" class="member-image">
                <div class="member-info">
                    <h2 class="member-name Color3">Davi</h2>
                    <p class="member-role Color6">Desenvolvedor Front-End</p>
                    <p class="member-contribution Color7 BorderColor2">Responsável pelo desenvolvimento das páginas da aplicação e pela criação dos respectivos elementos de design e interface com o usuário.</p>
                </div>
            </div>
            <div class="team-member BColor5">
                <img src="../../Web/Imagens/Integrantes/lopes.jpg" class="member-image">
                <div class="member-info">
                    <h2 class="member-name Color3">Arthur Lopes</h2>
                    <p class="member-role Color6">Desenvolvedor Back-End</p>
                    <p class="member-contribution Color7 BorderColor2">Responsável pela implementação da arquitetura baseada no padrão MVC (Model-View-Controller) e pela criação das rotas utilizadas na aplicação.</p>
                </div>
            </div>
            <div class="team-member BColor5">
                <img src="../../Web/Imagens/Integrantes/pedroV.jpg" class="member-image">
                <div class="member-info">
                    <h2 class="member-name Color3">Pedro</h2>
                    <p class="member-role Color6">Gerente de Equipe</p>
                    <p class="member-contribution Color7 BorderColor2">Responsável pela coordenação geral do desenvolvimento do projeto, pela gestão das atividades de cada integrante e pela administração da hospedagem do site e de suas informações.</p>
                </div>
            </div>
            <div class="team-member BColor5">
                <img src="../../Web/Imagens/Integrantes/china.jpg" class="member-image">
                <div class="member-info">
                    <h2 class="member-name Color3">Arthur Victor</h2>
                    <p class="member-role Color6">Desenvolvedor Back-End</p>
                    <p class="member-contribution Color7 BorderColor2">Responsável pela definição e aplicação de design patterns, além do aprimoramento e ajuste da estrutura baseada no padrão MVC.</p>
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