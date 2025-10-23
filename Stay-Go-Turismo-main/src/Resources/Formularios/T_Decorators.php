<input type="hidden" name="_token" value="<?php echo htmlspecialchars($_SESSION["csrf_token"]); ?>">

<div id="Tema_Box">
    <label for="tema">Tema:</label><br>
    <select id="T_tema" name="T_tema">
        <option value="">Selecione um Tema</option>
        <?php if(isset($themes) && is_array($themes)): ?>
            <?php foreach ($themes as $theme): ?>
                <option value="<?php echo htmlspecialchars($theme["Tema"]); ?>"><?php echo htmlspecialchars($theme["Tema"]); ?></option>
            <?php endforeach; ?>
        <?php endif; ?>
    </select>
</div>