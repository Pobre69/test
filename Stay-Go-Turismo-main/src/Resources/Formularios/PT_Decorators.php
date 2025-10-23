<input type="hidden" name="_token" value="<?php echo htmlspecialchars($_SESSION['csrf_token']); ?>">

<div id="Nome_Box">
    <label for="nome">Nome do Ponto Turístico:</label><br>
    <input type="text" id="PT_nome" name="PT_nome">
</div>

<div id="Estado_Box">
    <label for="estado">Estado:</label><br>
    <select id="PT_estado" name="PT_estado">
        <option value="">Selecione um Estado</option>
        <?php if(isset($estados) && is_array($estados)): ?>
            <?php foreach ($estados as $state): ?>
                <option value="<?php echo $state['nome']; ?>"><?php echo $state['nome']; ?></option>
            <?php endforeach; ?>
        <?php endif; ?>
    </select>
</div>

<div id="Cidade_Box">
    <label for="cidade">Cidade:</label><br>
    <select id="PT_cidade" name="PT_cidade">
        <option value="">Selecione uma Cidade</option>
        <?php if(isset($cidades) && is_array($cidades)): ?>
            <?php foreach ($cidades as $state): ?>
                <option value="<?php echo $state['nome']; ?>"><?php echo $state['nome']; ?></option>
            <?php endforeach; ?>
        <?php endif; ?>
    </select>
</div>

<div id="Avaliacao_Box">
    <label for="avaliacao">Avaliacao Geral:</label><br>
    <label for="a_min">Valor Min - </label>
    <input type="number" id="PT_avaliacaoMin" name="PT_avaliacaoMin" step="0.1" min="0" max="5">
    <label for="a_max">Valor Max - </label>
    <input type="number" id="PT_avaliacaoMax" name="PT_avaliacaoMax" step="0.1" min="0" max="5">
</div>

<div id="Estacionamento_Box">
    <label for="estacionamento">Estacionamento:</label><br>
    <select id="PT_estacionamento" name="PT_estacionamento">
        <option value="">Ambos</option>
        <option value="1">Sim</option>
        <option value="0">Não</option>
    </select>
</div>

<div id="Horario_Box">
    <label for="horarioAbertura">Horário de Abertura (Min):</label><br>
    <input type="time" id="PT_horarioAberturaMin" name="PT_horarioAberturaMin">
    <label for="horarioFechamento">Horário de Fechamento (Max):</label><br>
    <input type="time" id="PT_horarioFechamentoMax" name="PT_horarioFechamentoMax">
</div>

<div id="Natural_Box">
    <label for="natural">Ponto Turístico Natural:</label><br>
    <select id="PT_natural" name="PT_natural">
        <option value="">Ambos</option>
        <option value="1">Sim</option>
        <option value="0">Não</option>
    </select>
</div>

<div id="Patrimonio_Box">
    <label for="patrimonio">Patrimônio Histórico/Cultural:</label><br>
    <select id="PT_patrimonio" name="PT_patrimonio">
        <option value="">Ambos</option>
        <option value="1">Sim</option>
        <option value="0">Não</option>
    </select>
</div>

<div id="Visitantes_Box">
    <label for="visitantes">Total de Visitantes:</label><br>
    <label for="v_min">Valor Min - </label>
    <input type="number" id="PT_visitantesMin" name="PT_visitantesMin" min="0">
    <label for="v_max">Valor Max - </label>
    <input type="number" id="PT_visitantesMax" name="PT_visitantesMax" min="0">
</div>

<div id="PrecoEntrada_Box">
    <label for="precoEntrada">Preço de Entrada:</label><br>
    <label for="p_min">Valor Min - </label>
    <input type="number" id="PT_precoEntradaMin" name="PT_precoEntradaMin" step="0.01" min="0">
    <label for="p_max">Valor Max - </label>
    <input type="number" id="PT_precoEntradaMax" name="PT_precoEntradaMax" step="0.01" min="0">
</div>