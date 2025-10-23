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
    <style>
        .zoomable { transition: transform 0.3s; cursor: zoom-in; }
        .zoomable:active, .zoomable:focus { transform: scale(2); z-index: 99; }
        .quadro { background: #f7f7ff; border-radius: 10px; margin: 10px; padding: 12px; box-shadow: 0 2px 6px #ccc; display:inline-block; width:250px; vertical-align:top;}
        .section { margin: 36px 0; }
        .quadro a { text-decoration:none; color:#1a5fb4;}
    </style>
</head>
<body>
    <?php 
        include_once(__DIR__ . '../../Components/Menu.php');
        include_once(__DIR__ . '../../Components/Header.php');
        include_once(__DIR__ . '../../Components/Black_BackGround.html');
    ?>
    
    <main>
        <!-- Sistema de Busca Avançada -->
        <form method="GET" class="section quadro">
            <h3>Encontrar ponto turístico</h3>
            <input type="text" name="nome" placeholder="Nome do ponto">
            <select name="categoria">
                <option value="">Categoria...</option>
                <option value="esportes">Esportes</option>
                <option value="museu">Museus</option>
                <option value="natural">Ponto Natural</option>
                <option value="historico">Edifício Histórico</option>
            </select>
            <input type="time" name="horario_min" placeholder="Abertura">
            <input type="time" name="horario_max" placeholder="Fechamento">
            <input type="number" step="0.1" name="avaliacao_min" placeholder="Avaliação mín">
            <input type="number" step="0.1" name="avaliacao_max" placeholder="Avaliação máx">
            <input type="number" name="preco_min" placeholder="Preço mín">
            <input type="number" name="preco_max" placeholder="Preço máx">
            <select name="tema">
                <option value="">Tema...</option>
                <option value="patrimonio historico">Patrimônio Histórico</option>
                <option value="natural">Natural</option>
            </select>
            <button type="submit">Buscar</button>
        </form>
        <?php if ($resultadosBusca): ?>
        <section class="section">
            <h2>Resultados da Busca:</h2>
            <?php foreach ($resultadosBusca as $ponto): ?>
            <div class="quadro zoomable" tabindex="0">
                <a href="ponto.php?id=<?= urlencode($ponto['pt_id']) ?>">
                    <b><?= htmlspecialchars($ponto['pt_nome']) ?></b>
                </a><br>
                Categoria: <?= htmlspecialchars($ponto['tema']) ?><br>
                Avaliação: <?= htmlspecialchars($ponto['avaliacaoGeral'] ?? '-') ?><br>
                Preço: R$<?= htmlspecialchars($ponto['preco']) ?? '-' ?><br>
            </div>
            <?php endforeach; ?>
        </section>
        <?php endif;?>
        
        <section class="section">
            <h2>1. 10 Maiores Destaques</h2>
            <?php foreach ($destaques as $ponto): ?>
            <div class="quadro zoomable" tabindex="0">
                <a href="ponto.php?id=<?= urlencode($ponto['pt_id']) ?>">
                    <img src="src/Web/Imagens/<?= htmlspecialchars($ponto['imagem'] ?? 'logoSugestao.jpg') ?>" style="width:100px"><br>
                    <b><?= htmlspecialchars($ponto['pt_nome']) ?></b>
                </a><br>
                Acessos: <?= htmlspecialchars($ponto['pt_views'] ?? '-') ?>
            </div>
            <?php endforeach; ?>
        </section>
        
        <section class="section">
            <h2>2. Pontos Mais Visitados</h2>
            <?php foreach ($pontosMaisVisitados as $ponto): ?>
            <div class="quadro zoomable" tabindex="0">
                <a href="ponto.php?id=<?= urlencode($ponto['pt_id']) ?>">
                    <b><?= htmlspecialchars($ponto['pt_nome']) ?></b>
                </a><br>
                Visitantes: <?= htmlspecialchars($ponto['pt_views'] ?? '-') ?>
            </div>
            <?php endforeach; ?>
        </section>
        
        <section class="section">
            <h2>3. Melhores Avaliados</h2>
            <?php foreach ($avaliados as $ponto): ?>
            <div class="quadro zoomable" tabindex="0">
                <a href="ponto.php?id=<?= urlencode($ponto['pt_id']) ?>">
                    <b><?= htmlspecialchars($ponto['pt_nome']) ?></b>
                </a><br>
                Avaliação: <?= htmlspecialchars($ponto['avaliacaoGeral'] ?? '-') ?>
            </div>
            <?php endforeach; ?>
        </section>
        
        <section class="section">
            <h2>4. Patrimônios Históricos</h2>
            <?php foreach ($patrimonios as $patrimonio): ?>
            <div class="quadro zoomable" tabindex="0">
                <a href="ponto.php?id=<?= urlencode($patrimonio['pt_id']) ?>">
                    <b><?= htmlspecialchars($patrimonio['pt_nome']) ?></b>
                </a><br>
                Tema: <?= htmlspecialchars($patrimonio['tema']) ?>
            </div>
            <?php endforeach; ?>
        </section>
        
        <section class="section">
            <h2>5. Pontos Naturais</h2>
            <?php foreach ($pontosNaturais as $natural): ?>
            <div class="quadro zoomable" tabindex="0">
                <a href="ponto.php?id=<?= urlencode($natural['pt_id']) ?>">
                    <b><?= htmlspecialchars($natural['pt_nome']) ?></b>
                </a><br>
                Tema: <?= htmlspecialchars($natural['tema']) ?>
            </div>
            <?php endforeach; ?>
        </section>
    </main>

    <?php
        include_once(__DIR__ . '../../Components/Footer.html');
    ?>

    <script src="../../Web/JavaScript/index.js"></script>
    <script src="../../Web/JavaScript/Global.js"></script>
</body>
</html>