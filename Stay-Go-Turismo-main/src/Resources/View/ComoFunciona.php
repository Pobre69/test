<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Stay Go Turismo</title>
    <link rel="stylesheet" href="../../Web/css/index.css">
    <link rel="stylesheet" href="../../Web/css/Texts.css">
    <link rel="stylesheet" href="../../Web/css/comofunciona.css">
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
        <div class="explicacao-section">
            <h2>Como usar o sistema de busca e filtros</h2>
            <p>
                Use a barra de busca avançada do topo da página para localizar qualquer ponto turístico de Belo Horizonte.<br>
                Preencha um ou mais campos: 
                <span class="demonstracao">
                    Nome | Categoria | Horário | Avaliação | Preço | Tema
                </span>
                Depois, clique em <b>Buscar</b> e veja os resultados em quadros criados para rápida visualização.
            </p>
        </div>
        <div class="explicacao-section">
            <h2>Zoom nos quadros!</h2>
            <p>
                Passe o mouse ou toque nos <b>quadros</b> para ampliar detalhes com o recurso <b>zoom</b>.<br>
                Prático para ler informações ou visualizar imagens mais de perto!
            </p>
            <div class="quadro-demo zoomable demo" tabindex="0" style="margin-top:12px;">
                <b>Mercado Central</b><br>
                <img src="MercadoCentral.jpg" style="width:85px;"><br>
                Tema: Gastronomia <br>
                Avaliação: 4.8
            </div>
        </div>
        <div class="explicacao-section">
            <h2>Navegação entre seções e detalhes</h2>
            <p>
                O <b>index</b> traz várias seções principais para facilitar sua exploração:
            </p>
            <div class="DisplayDesign">
                <ul>
                    <li><b>1. 10 Maiores Destaques</b>: Pontos mais populares de BH.</li>
                    <li><b>2. Pontos Mais Visitados</b>: Locais com maior número de visitas.</li>
                    <li><b>3. Melhores Avaliados</b>: Pontos com melhores notas pela comunidade.</li>
                    <li><b>4. Patrimônios Históricos</b>: Destaque para nossa história e cultura.</li>
                    <li><b>5. Pontos Naturais</b>: Locais ao ar livre e de natureza.</li>
                </ul>
            </div>
        </div>
        <div class="explicacao-section">
            <h2>Cada ponto turístico tem sua própria página!</h2>
            <p>
                Clique no <b>nome</b> ou <b>imagem</b> do quadro desejado para acessar detalhes completos:
                <div class="DisplayDesign">
                    <ul>
                        <li>Fotos e localização</li>
                        <li>Descrição e curiosidades</li>
                        <li>Horários, avaliações e preço (quando houver)</li>
                    </ul>
                </div>
            </p>
        </div>
        <div class="explicacao-section">
            <h2>Filtros especiais de temas e categorias</h2>
            <p>
                Experimente filtrar por <b>tema</b> (natural, patrimônio histórico, esportes, museus etc) ou vá direto nas melhores avaliações para ver recomendações dos usuários.<br>
                Você pode combinar diversos filtros para montar seu próprio roteiro!
            </p>
        </div>
        <div class="explicacao-section" style="background:#eefcee;">
            <h2>Dicas extras</h2>
            <div class="DisplayDesign">
                <ul>
                    <li>Ao ampliar um quadro (zoom), clique fora dele ou use a tecla Esc para desfazer.</li>
                    <li>Pontos turísticos sempre ordenados por destaque, visitação ou avaliação, de acordo com a seção.</li>
                    <li>Se ficar na dúvida, use o botão de feedback na página principal para falar conosco!</li>
                </ul>
            </div>
        </div>
    </main>

    <?php
        include_once(__DIR__ . '../../Components/Footer.html');
    ?>

    <script src="../../Web/JavaScript/index.js"></script>
    <script src="../../Web/JavaScript/Global.js"></script>
</body>
</html>