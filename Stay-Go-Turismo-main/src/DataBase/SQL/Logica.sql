DELIMITER %
CREATE PROCEDURE Adicionar_Ponto_Turistico (
    IN param_complemento VARCHAR(200),
    IN param_nome VARCHAR(75),
    IN param_estado VARCHAR(30),
    IN param_cidade VARCHAR(50),
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
    IN param_contato VARCHAR(20),
    IN param_site VARCHAR(100),
    IN param_email VARCHAR(50),
    IN param_pacote VARCHAR(50)
)
BEGIN
    DECLARE var_endereco VARCHAR(150);

    SET var_endereco = CONCAT(param_estado, ' - ', param_cidade, ', ', param_bairro, ' - ', param_cep);

    IF (Validar_TextoSimples(param_nome) AND
        Validar_NomeCidadeEstado(param_estado) AND
        Validar_NomeCidadeEstado(param_cidade)) THEN
        
        IF (Validar_Email(param_email)) THEN

            INSERT INTO Ponto_Turistico (
                nome, complemento, estado, cidade, bairro, CEP, endereco,
                horarioAbertura, horarioAberturaF, horarioFechamento, horarioFechamentoF,
                contato, site, email, precoEntrada, estacionamento, estruturasServicao,
                avaliacaoGeral, pacote
            )
            VALUES (
                param_nome, param_complemento, param_estado, param_cidade, param_bairro, param_cep, var_endereco,
                param_horarioAbertura, param_horarioAberturaF, param_horarioFechamento, param_horarioFechamentoF,
                param_contato, param_site, param_email, param_precoEntrada, param_estacionamento, param_estruturasServicao,
                param_avaliacaoGeral, param_pacote
            );
            
            SELECT 'Ponto turístico adicionado com sucesso!' AS resultado;

        ELSE
            SELECT 'Erro: E-mail inválido' AS resultado;
        END IF;

    ELSE
        SELECT 'Erro: Nome, cidade ou estado inválidos' AS resultado;
    END IF;
END%
CREATE PROCEDURE Alterar_Ponto_Turistico (
    IN param_idPonto INT,
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
    IN param_pacote VARCHAR(50)
)
BEGIN
    DECLARE var_endereco VARCHAR(150);
    DECLARE var_total INT;

    SET var_endereco = CONCAT(param_estado, ' - ', param_cidade, ', ', param_bairro, ' - ', param_cep);

    SELECT COUNT(*) INTO var_total FROM Ponto_Turistico WHERE idPonto = param_idPonto;

    IF var_total = 0 THEN
        SELECT 'Erro: ID do ponto turístico não encontrado.' AS resultado;
    ELSE
        IF (Validar_TextoSimples(param_nome) AND
            Validar_NomeCidadeEstado(param_estado) AND
            Validar_NomeCidadeEstado(param_cidade)) THEN
            
            IF (Validar_Email(param_email)) THEN

                UPDATE Ponto_Turistico
                SET
                    nome = param_nome,
                    complemento = param_complemento,
                    estado = param_estado,
                    cidade = param_cidade,
                    bairro = param_bairro,
                    CEP = param_cep,
                    endereco = var_endereco,
                    horarioAbertura = param_horarioAbertura,
                    horarioAberturaF = param_horarioAberturaF,
                    horarioFechamento = param_horarioFechamento,
                    horarioFechamentoF = param_horarioFechamentoF,
                    contato = param_contato,
                    site = param_site,
                    email = param_email,
                    precoEntrada = param_precoEntrada,
                    estacionamento = param_estacionamento,
                    estruturasServicao = param_estruturasServicao,
                    avaliacaoGeral = param_avaliacaoGeral,
                    pacote = param_pacote
                WHERE idPonto = param_idPonto;

                SELECT 'Ponto turístico atualizado com sucesso!' AS resultado;

            ELSE
                SELECT 'Erro: E-mail inválido' AS resultado;
            END IF;

        ELSE
            SELECT 'Erro: Nome, cidade ou estado inválidos' AS resultado;
        END IF;
    END IF;
END%

CREATE PROCEDURE Adicionar_View(IN param_idPonto INT,IN param_TotalVisitantes INT)
BEGIN
    DECLARE var_Verificar INT DEFAULT 0;
    SELECT COUNT(idPonto) INTO var_Verificar FROM Ponto_Turistico WHERE idPonto = param_idPonto;
    IF (var_Verificar > 0) THEN
        IF (param_TotalVisitantes > 0) THEN
            INSERT INTO Ponto_View(idPonto,TotalVisitantes) VALUE (param_idPonto, param_TotalVisitantes);
        ELSE
            SELECT 'Erro ao passar o Total de Visitantes' AS RESULTADO;
        END IF;
    ELSE
        SELECT 'Ponto não encontrado' AS RESULTADO;
    END IF;
END%
CREATE PROCEDURE Alterar_View(IN param_idPonto INT,IN param_TotalVisitantes INT,IN param_IsDeleting TINYINT(1))
BEGIN
    DECLARE var_Verificar INT DEFAULT 0;
    SELECT COUNT(idPonto) INTO var_Verificar FROM Ponto_Turistico WHERE idPonto = param_idPonto;
    IF (var_Verificar > 0) THEN
        IF (param_TotalVisitantes > 0) THEN
			IF (param_IsDeleting = 0) THEN
				UPDATE Ponto_View 
				SET idPonto = param_idPonto AND TotalVisitantes = param_TotalVisitantes
				WHERE idPonto = param_idPonto;
            ELSE
				DELETE FROM Ponto_View WHERE id = param_idPonto;
			END IF;
        ELSE
            SELECT 'Erro ao passar o Total de Visitantes' AS RESULTADO;
        END IF;
    ELSE
        SELECT 'Ponto não encontrado' AS RESULTADO;
    END IF;
END%

CREATE PROCEDURE Adicionar_Tema(IN param_Tema VARCHAR(60)) 
BEGIN
	IF (param_Tema REGEXP '^[A-Za-z0-9 ]+$') THEN
		INSERT INTO Tema(idTema,Tema) VALUES
			(NULL,param_Tema);
    ELSE
		SELECT 'ERRO AO PASSAR PARAMETRO' AS RESULTADO;
	END IF;
END%
CREATE PROCEDURE Alterar_Tema(IN param_ID INT, IN param_Tema VARCHAR(60))
BEGIN
    DECLARE VAR_VERIFICAR INT DEFAULT 0;

    SELECT COUNT(idTema)
    INTO VAR_VERIFICAR
    FROM Tema
    WHERE idTema = param_ID;

    IF (VAR_VERIFICAR > 0) THEN
        IF (Validar_TextoTema(param_Tema)) THEN
            UPDATE Tema
            SET Tema = param_Tema
            WHERE idTema = param_ID;

            SELECT 'Tema atualizado com sucesso!' AS resultado;
        ELSE
            SELECT 'Erro: Tema inválido' AS resultado;
        END IF;
    ELSE
        SELECT 'Erro: Tema não encontrado' AS resultado;
    END IF;
END%

CREATE PROCEDURE Adicionar_Tema_Ponto(IN param_idTema INT,IN param_idPonto INT,IN param_IsNatural TINYINT(1))
BEGIN
	DECLARE VAR_VERIFICAR INT DEFAULT 0;
    SELECT (SELECT COUNT(idTema) FROM Tema WHERE idTema = param_idTema) * (SELECT COUNT(idPonto) FROM Ponto_Turistico WHERE idPonto = param_idPonto);
    
    IF (VAR_VERIFICAR > 0) THEN
		INSERT INTO Tema_Ponto(idTema,idPonto,Ponto_Turistico_Natural) VALUES
			(param_idTema,param_idPonto,param_IsNatural);
    ELSE
		SELECT 'ERRO AO PASSAR PARAMETROS' AS RESULTADO;
	END IF;
END%
CREATE PROCEDURE Alterar_Tema_Ponto(IN param_idTema INT,IN param_idPonto INT,IN param_IsNatural TINYINT(1))
BEGIN
    DECLARE VAR_VALOR_IDENTICO INT DEFAULT 0;
    SELECT 
		CASE 
			WHEN paramIsNatural = Ponto_Turistico_Natural THEN 1 
            ELSE 0 
		END INTO VAR_VALOR_IDENTICO 
	FROM 
		Tema_Ponto 
	WHERE 
		idTema = param_idTema 
        AND idPonto = param_idPonto;
    
    IF (VAR_VALOR_IDENTICO > 0) THEN
		SELECT 'NÃO POSSUI NENHUMA ALTERAÇÃO' AS RESULTADO;
	ELSE
		UPDATE Tema_Ponto
		SET Ponto_Turistico_Natural = param_IsNatural
		WHERE idTema = param_idTema AND idPonto = param_idPonto;
	END IF;
END%

CREATE PROCEDURE Adicionar_FeedBack(IN param_Comunicado TEXT,IN param_Autor VARCHAR(50),IN param_Cidade VARCHAR(30))
BEGIN
    INSERT INTO FeedBacks(ID,AUTOR,COMUNICADO,CIDADE,DATA_COMUNICADO,STATUS) VALUES
        (NULL,param_Autor,param_Comunicado,param_Cidade,CURRENT_TIMESTAMP(),'EM ESPERA');
END%
CREATE PROCEDURE Alterar_FeedBack(IN param_ID INT,IN param_Status VARCHAR(20))
BEGIN
    UPDATE FeedBacks
    SET STATUS = param_Status
    WHERE ID = param_ID;
END%
DELIMITER ;