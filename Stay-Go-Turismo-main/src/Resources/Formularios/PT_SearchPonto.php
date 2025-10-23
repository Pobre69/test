<input type="hidden" name="_token" value="<?php echo htmlspecialchars($_SESSION['csrf_token']); ?>">

<label for="nome">Ponto Turistico</label>
<input type="text" id="pt_nome" name="pt_nome" required>

<div id="PT_Search_submit_button"></div>