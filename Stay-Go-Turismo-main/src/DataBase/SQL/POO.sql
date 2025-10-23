DELIMITER %
CREATE PROCEDURE Controlador_Ponto_Turistico (
    IN acao VARCHAR(20),
    IN id INT,
    IN param_complemento VARCHAR(200),
    IN param_nome VARCHAR(75),
    IN param_estado VARCHAR(30),
    IN param_cidade VARCHAR(30),
    IN param_bairro VARCHAR(30),
    IN param_cep INT,
    IN param_horarioAbertura TIME,
    IN param_horarioAberturaF TIME,
    IN param_horarioFechamento TIME,
    IN param_horarioFechamentoF TIME,
    IN param_precoEntrada DECIMAL(5,2),
    IN param_estacionamento BOOLEAN,
    IN param_estruturasServicao VARCHAR(100),
    IN param_avaliacaoGeral DECIMAL(2,1),
    IN param_contato CHAR(13),
    IN param_site VARCHAR(100),
    IN param_email VARCHAR(50),
    IN param_pacote VARCHAR(50),
    IN param_visitantes INT
)
BEGIN
    IF acao = 'adicionar' THEN
        CALL Adicionar_Ponto_Turistico(
            param_complemento, param_nome, param_estado, param_cidade, param_bairro,
            param_cep, param_horarioAbertura, param_horarioAberturaF,
            param_horarioFechamento, param_horarioFechamentoF, param_precoEntrada,
            param_estacionamento, param_estruturasServicao, param_avaliacaoGeral,
            param_contato, param_site, param_email, param_pacote
        );
        CALL Adicionar_View(param_visitantes);
        
    ELSEIF acao = 'alterar' THEN
        CALL Alterar_Ponto_Turistico(
            id, param_complemento, param_nome, param_estado, param_cidade, param_bairro,
            param_cep, param_horarioAbertura, param_horarioAberturaF,
            param_horarioFechamento, param_horarioFechamentoF, param_precoEntrada,
            param_estacionamento, param_estruturasServicao, param_avaliacaoGeral,
            param_contato, param_site, param_email, param_pacote
        );
        CALL Alterar_View(param_visitantes);
	
    ELSEIF acao = 'index' THEN
		SELECT 
			spt.*,
            pt_views
		FROM 
			Show_PontosTuristicos_Info spt
				INNER JOIN Show_PontosTuristicos_Views USING(pt_id);
	
    ELSEIF acao = 'show' THEN
		SELECT 
			spt.*,
            pt_views
		FROM 
			Show_PontosTuristicos_Info spt
				INNER JOIN Show_PontosTuristicos_Views USING(pt_id)
		WHERE
			spt.pt_id = id
		LIMIT 1;
            
	ELSEIF acao = 'delete' THEN
		DELETE FROM Show_PontosTuristicos_Info
        WHERE pt_id = id LIMIT 1;

    ELSE
        SELECT 'Ação não reconhecida.' AS resultado;
    END IF;
END%

CREATE PROCEDURE Controlador_Tema (
    IN acao VARCHAR(20),
    IN id INT,
    IN param_Tema VARCHAR(60)
)
BEGIN
    IF acao = 'adicionar' THEN
        CALL Adicionar_Tema(param_Tema);

    ELSEIF acao = 'alterar' THEN
        CALL Alterar_Tema(id, param_Tema);
        
	ELSEIF acao = 'index' THEN
		SELECT
			Show_Temas.*
		FROM
			Show_Temas;
	
    ELSEIF acao = 'show' THEN
		SELECT
			Show_Temas.*
		FROM
			Show_Temas
		WHERE
			idTema = id;
	
    ELSEIF acao = 'delete' THEN
		DELETE FROM Tema
        WHERE idTema = id;

    ELSE
        SELECT 'Ação inválida.' AS resultado;
    END IF;
END%

CREATE PROCEDURE Controlador_Ponto_Tema(
	IN acao VARCHAR(20),
	IN param_idPonto INT,
    IN param_idTema INT,
    IN param_IsNatural TINYINT(1)
)
BEGIN
	IF acao = 'adicionar' THEN
        CALL Adicionar_Tema_Ponto(param_idTema,param_idPonto,param_IsNatural);

    ELSEIF acao = 'alterar' THEN
        CALL Alterar_Tema_Ponto(param_idTema,param_idPonto,param_IsNatural);
        
	ELSEIF acao = 'index' THEN
		SELECT
			Show_Ponto_Tema.*
		FROM
			Show_Ponto_Tema;
	
    ELSEIF acao = 'showTema' THEN
		SELECT
			Show_Ponto_Tema.*
		FROM
			Show_Ponto_Tema
		WHERE
			idTema = param_idTema;
	
    ELSEIF acao = 'showPonto' THEN
		SELECT
			Show_Ponto_Tema.*
		FROM
			Show_Ponto_Tema
		WHERE
			idPonto = param_idPonto;
	
    ELSEIF acao = 'delete' THEN
		DELETE FROM Tema
        WHERE idTema = param_idTema AND idPonto = param_idPonto;

    ELSE
        SELECT 'Ação inválida.' AS resultado;
    END IF;
END%
DELIMITER ;