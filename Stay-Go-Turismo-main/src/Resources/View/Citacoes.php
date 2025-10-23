<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Stay Go Turismo</title>
    <link rel="stylesheet" href="../../Web/css/index.css">
    <link rel="stylesheet" href="../../Web/css/Texts.css">
    <link rel="stylesheet" href="../../Web/css/citacoes.css">
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

    <main class="main-container">
        <h1 class="titulo">Citações de Quem Indicou o Site</h1>
        <section class="citacoes-container">
            <?php if(isset($citacoes) && is_array($citacoes)): ?>
                <?php foreach ($citacoes as $citacao): ?>
                    <article class="BColor4 BorderColor layout-artigo">
                        <p class="Color3 texto-comentario">
                            “<?= htmlspecialchars($citacao['comentario'] ?? '') ?>”
                        </p>
                        <p class="Color3 texto-nome">
                            <?= htmlspecialchars($citacao['nome'] ?? '') ?>
                        </p>
                        <p class="Color3 texto-profissao">
                            <?= htmlspecialchars($citacao['profissao'] ?? '') ?>
                        </p>
                    </article>
                <?php endforeach; ?>
            <?php else: ?>
                <div id="NoContentMessageBox">
                    <p class="Color3">Nenhuma citação disponível no momento.</p>
                </div>
            <?php endif; ?>
        </section>
    </main>


    <?php
        include_once(__DIR__ . '../../Components/Footer.html');
    ?>

    <script src="../../Web/JavaScript/index.js"></script>
    <script src="../../Web/JavaScript/Global.js"></script>
</body>
</html>