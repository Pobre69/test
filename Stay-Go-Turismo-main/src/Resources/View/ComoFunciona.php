<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Como funciona | Stay-Go-Turismo BH</title>
    <link rel="stylesheet" href="src/Web/css/style.css">
    <style>
        .explicacao-section { margin:32px 0; background: #f9f9fc; border-radius: 9px; padding: 16px; box-shadow: 0 1px 5px #ddd;}
        .demonstracao { display:inline-block; border:1px dashed #aaa; padding:8px 15px; border-radius:7px; background:#fff; margin:6px 0; }
        .icon { vertical-align: middle; margin-right: 3px;}
        .quadro-demo { display: inline-block; background: #f7f7ff; border-radius: 8px; margin: 8px; padding: 10px; width: 205px; vertical-align: top; box-shadow: 0 2px 5px #ddd; }
        .zoomable.demo { cursor: zoom-in; transition: transform 0.3s;}
        .zoomable.demo:active { transform: scale(2);}
        .separador { margin:24px 0 8px 0; padding-bottom:4px; border-bottom:1px solid #e3e3e3;}
    </style>
</head>
<body>
    <header>
        <img src="logoSugestao.jpg" alt="Logo" style="height:70px;">
        <h1>Como funciona?</h1>
        <nav>
            <a href="index.php">Página Inicial</a>
        </nav>
    </header>
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
            <div class="quadro-demo zoomable demo" tabindex="0">
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
            <ul>
                <li><b>1. 10 Maiores Destaques</b>: Pontos mais populares de BH.</li>
                <li><b>2. Pontos Mais Visitados</b>: Locais com maior número de visitas.</li>
                <li><b>3. Melhores Avaliados</b>: Pontos com melhores notas pela comunidade.</li>
                <li><b>4. Patrimônios Históricos</b>: Destaque para nossa história e cultura.</li>
                <li><b>5. Pontos Naturais</b>: Locais ao ar livre e de natureza.</li>
            </ul>
        </div>
        <div class="explicacao-section">
            <h2>Cada ponto turístico tem sua própria página!</h2>
            <p>
                Clique no <b>nome</b> ou <b>imagem</b> do quadro desejado para acessar detalhes completos:
                <ul>
                    <li>Fotos e localização</li>
                    <li>Descrição e curiosidades</li>
                    <li>Horários, avaliações e preço (quando houver)</li>
                </ul>
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
            <ul>
                <li>Ao ampliar um quadro (zoom), clique fora dele ou use a tecla Esc para desfazer.</li>
                <li>Pontos turísticos sempre ordenados por destaque, visitação ou avaliação, de acordo com a seção.</li>
                <li>Se ficar na dúvida, use o botão de feedback na página principal para falar conosco!</li>
            </ul>
        </div>
    </main>
    <footer>
        <small>Stay-Go-Turismo BH © 2025</small>
    </footer>
</body>
</html>