CREATE DATABASE IF NOT EXISTS stayGoTurismo;
USE stayGoTurismo;

CREATE TABLE IF NOT EXISTS Ponto_Turistico(
    idPonto INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(75) NOT NULL UNIQUE,
    complemento varchar(200),
    
    -- Localização
    estado VARCHAR(30) NOT NULL,
    cidade VARCHAR(50) NOT NULL,
    bairro VARCHAR(30),
    CEP INT,
    endereco VARCHAR(100) NOT NULL,
    
    -- Horário de Abertura Feriados e Fim de Semana
    horarioAbertura TIME NOT NULL,
    horarioAberturaF TIME,
    
    -- Horário de Fechamento Feriados e Fim de Semana
    horarioFechamento TIME NOT NULL,
    horarioFechamentoF TIME,
    
    -- Contato
    contato VARCHAR(20),
    site VARCHAR(100),
    email VARCHAR(50),
    
    -- Complemento
    precoEntrada DECIMAL(5,2),
    estacionamento BOOLEAN NOT NULL,
    estruturasServicao VARCHAR(100),
    avaliacaoGeral DECIMAL(2,1) NOT NULL,
    pacote VARCHAR(50)
);
CREATE TABLE IF NOT EXISTS Ponto_View(
    idPonto INT NOT NULL PRIMARY KEY,
    TotalVisitantes INT NOT NULL,
    FOREIGN KEY (idPonto) REFERENCES Ponto_Turistico(idPonto)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=INNODB;
CREATE TABLE IF NOT EXISTS Tema(
	idTema INT AUTO_INCREMENT PRIMARY KEY,
    Tema VARCHAR(60) NOT NULL
)ENGINE=INNODB;
CREATE TABLE IF NOT EXISTS Ponto_Tema(
    idTema INT NOT NULL,
    idPonto INT NOT NULL,
    Ponto_Turistico_Natural TINYINT(1) NOT NULL,
    FOREIGN KEY (idPonto) REFERENCES Ponto_Turistico(idPonto)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
	FOREIGN KEY (idTema) REFERENCES Tema(idTema)
        ON UPDATE CASCADE
) ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS FeedBacks(
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Autor VARCHAR(50) NOT NULL,
    CIDADE VARCHAR(30) NOT NULL,
    COMUNICADO TEXT NOT NULL,
    DATA_COMUNICADO DATE,
    STATUS VARCHAR(20)
)ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS Auditoria(
	ID INT AUTO_INCREMENT PRIMARY KEY,
    NOME_TABELA VARCHAR(50) NOT NULL,
    DETALHAMENTO TEXT NOT NULL,
    DATA DATETIME NOT NULL
)ENGINE=INNODB;
CREATE TABLE IF NOT EXISTS Auditoria_PHP(
	ID INT AUTO_INCREMENT PRIMARY KEY,
    ID_PONTO INT NOT NULL,
    NOME_TABELA VARCHAR(50) NOT NULL,
    DETALHAMENTO TEXT NOT NULL,
    DATA DATETIME NOT NULL
)ENGINE=INNODB;

CREATE OR REPLACE VIEW Show_PontosTuristicos_Views AS
SELECT
	idPonto				AS pt_id,
    TotalVisitantes		AS pt_views
FROM
	Ponto_View;
    
CREATE OR REPLACE VIEW Show_Temas AS
SELECT
	idTema				AS t_id,
    Tema				AS t_tema
FROM
	Tema;

CREATE OR REPLACE VIEW Show_Ponto_Tema AS
SELECT
	idTema						AS t_id,
    idPonto						AS pt_id,
    Ponto_Turistico_Natural		AS pt_natural
FROM
	Ponto_Tema;

CREATE OR REPLACE VIEW Show_PontosTuristicos_Info AS
SELECT
    idPonto              AS pt_id,
    nome                 AS pt_nome,
    complemento          AS pt_c1,
    estado               AS pt_c2,
    cidade               AS pt_c3,
    bairro               AS pt_c4,
    CEP                  AS pt_c5,
    endereco             AS pt_c6,
    horarioAbertura      AS pt_c7,
    horarioAberturaF     AS pt_c8,
    horarioFechamento    AS pt_c9,
    horarioFechamentoF   AS pt_c10,
    contato              AS pt_c11,
    site                 AS pt_c12,
    email                AS pt_c13,
    precoEntrada         AS pt_c14,
    estacionamento       AS pt_c15,
    estruturasServicao   AS pt_c16,
    avaliacaoGeral       AS pt_c17,
    pacote               AS pt_c18
FROM 
	Ponto_Turistico;

CREATE OR REPLACE VIEW Show_FeedBacks AS
SELECT
	ID AS FB_id,
    AUTOR AS FB_autor,
    COMUNICADO AS FB_comunicado,
    CIDADE AS FB_cidade,
    DATA_COMUNICADO AS FB_data_comunicado,
    STATUS AS FB_status
FROM
	FeedBacks;
    
CREATE OR REPLACE VIEW Show_All AS
SELECT
	Show_PontosTuristicos_Info.*,
    Show_Ponto_Tema.pt_natural,
    Show_PontosTuristicos_Views.pt_views,
    Show_Temas.*
FROM
	Show_PontosTuristicos_Info
        INNER JOIN Show_Ponto_Tema USING(pt_id)
        INNER JOIN Show_PontosTuristicos_Views USING(pt_id)
        INNER JOIN Show_Temas USING(t_id);

DELIMITER %
CREATE FUNCTION Validar_Email(email VARCHAR(100))
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    RETURN (LOCATE('@', email) > 0 AND LOCATE('.', email) > 0);
END%

CREATE FUNCTION Validar_TextoSimples(texto VARCHAR(100))
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    RETURN texto REGEXP '^[A-Za-zÀ-ÿ0-9 ]+$';
END%

CREATE FUNCTION Validar_NomeCidadeEstado(texto VARCHAR(50))
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    RETURN texto REGEXP '^[A-Za-zÀ-ÿ ]+$';
END%
DELIMITER %

DELIMITER %
CREATE TRIGGER Inserindo_Ponto
AFTER INSERT ON Ponto_Turistico
FOR EACH ROW
BEGIN
	DECLARE VAR_TEXTO TEXT;
    DECLARE VAR_NOME_TABELA VARCHAR(50) DEFAULT 'Ponto_Turistico';
    
    SELECT CONCAT('Foi INSERIDO um novo Ponto turistico: ','\n','ID - ',NEW.idPonto,'\n','NOME - ',NEW.nome,'\n','COMPLEMENTO - ',NEW.complemento) INTO VAR_TEXTO;
    
    INSERT INTO Auditoria (ID,NOME_TABELA,DETALHAMENTO,DATA) VALUES
		(NULL,VAR_NOME_TABELA,VAR_TEXTO,CURRENT_TIMESTAMP());
END%
CREATE TRIGGER Inserindo_View
AFTER INSERT ON Ponto_View
FOR EACH ROW
BEGIN
	DECLARE VAR_TEXTO TEXT;
    DECLARE VAR_NOME_TABELA VARCHAR(50) DEFAULT 'Ponto_View';
    
    SELECT CONCAT('Foi INSERIDO uma nova quantidade de visitantes no Ponto turistico: ','\n','ID - ',NEW.idPonto,'\n','VISITANTES TOTAIS - ',NEW.TotalVisitantes) INTO VAR_TEXTO;
    
    INSERT INTO Auditoria (ID,NOME_TABELA,DETALHAMENTO,DATA) VALUES
		(NULL,VAR_NOME_TABELA,VAR_TEXTO,CURRENT_TIMESTAMP());
END%
CREATE TRIGGER Inserindo_Tema
AFTER INSERT ON Tema
FOR EACH ROW
BEGIN
	DECLARE VAR_TEXTO TEXT;
    DECLARE VAR_NOME_TABELA VARCHAR(50) DEFAULT 'Tema';
    
    SELECT CONCAT('Foi INSERIDO um novo tema: ','\n','ID - ',NEW.idTema,'\n','TEMA - ',NEW.Tema) INTO VAR_TEXTO;
    
    INSERT INTO Auditoria (ID,NOME_TABELA,DETALHAMENTO,DATA) VALUES
		(NULL,VAR_NOME_TABELA,VAR_TEXTO,CURRENT_TIMESTAMP());
END%

CREATE TRIGGER Alterando_Ponto
BEFORE UPDATE ON Ponto_Turistico
FOR EACH ROW
BEGIN
	DECLARE VAR_TEXTO TEXT DEFAULT '';
    DECLARE VAR_QTDE_ALTERACOES INT DEFAULT 0;
    DECLARE VAR_NOME_TABELA VARCHAR(50) DEFAULT 'Ponto_Turistico';
    
    IF NOT (NEW.idPonto <=> OLD.idPonto) THEN
		SET VAR_TEXTO = CONCAT(VAR_TEXTO,'\nID: Antigo -',OLD.idPonto,', Novo - ',NEW.idPonto);
        SET VAR_QTDE_ALTERACOES = VAR_QTDE_ALTERACOES + 1;
    END IF;
    IF NOT (NEW.nome <=> OLD.nome) THEN
		SET VAR_TEXTO = CONCAT(VAR_TEXTO,'\nNOME: Antigo -',OLD.nome,', Novo - ',NEW.nome);
        SET VAR_QTDE_ALTERACOES = VAR_QTDE_ALTERACOES + 1;
    END IF;
    IF NOT (NEW.estado <=> OLD.estado) THEN
		SET VAR_TEXTO = CONCAT(VAR_TEXTO,'\nESTADO: Antigo -',OLD.estado,', Novo - ',NEW.estado);
        SET VAR_QTDE_ALTERACOES = VAR_QTDE_ALTERACOES + 1;
    END IF;
    IF NOT (NEW.cidade <=> OLD.cidade) THEN
        SET VAR_TEXTO = CONCAT(VAR_TEXTO, '\nCIDADE: Antigo - ', OLD.cidade, ', Novo - ', NEW.cidade);
        SET VAR_QTDE_ALTERACOES = VAR_QTDE_ALTERACOES + 1;
    END IF;
    IF NOT (NEW.bairro <=> OLD.bairro) THEN
        SET VAR_TEXTO = CONCAT(VAR_TEXTO, '\nBAIRRO: Antigo - ', OLD.bairro, ', Novo - ', NEW.bairro);
        SET VAR_QTDE_ALTERACOES = VAR_QTDE_ALTERACOES + 1;
    END IF;
    IF NOT (NEW.CEP <=> OLD.CEP) THEN
        SET VAR_TEXTO = CONCAT(VAR_TEXTO, '\nCEP: Antigo - ', OLD.CEP, ', Novo - ', NEW.CEP);
        SET VAR_QTDE_ALTERACOES = VAR_QTDE_ALTERACOES + 1;
    END IF;
    IF NOT (NEW.endereco <=> OLD.endereco) THEN
        SET VAR_TEXTO = CONCAT(VAR_TEXTO, '\nENDEREÇO: Antigo - ', OLD.endereco, ', Novo - ', NEW.endereco);
        SET VAR_QTDE_ALTERACOES = VAR_QTDE_ALTERACOES + 1;
    END IF;
    IF NOT (NEW.horarioAbertura <=> OLD.horarioAbertura) THEN
        SET VAR_TEXTO = CONCAT(VAR_TEXTO, '\nHORÁRIO ABERTURA: Antigo - ', OLD.horarioAbertura, ', Novo - ', NEW.horarioAbertura);
        SET VAR_QTDE_ALTERACOES = VAR_QTDE_ALTERACOES + 1;
    END IF;
    IF NOT (NEW.horarioAberturaF <=> OLD.horarioAberturaF) THEN
        SET VAR_TEXTO = CONCAT(VAR_TEXTO, '\nHORÁRIO ABERTURA FERIADO: Antigo - ', OLD.horarioAberturaF, ', Novo - ', NEW.horarioAberturaF);
        SET VAR_QTDE_ALTERACOES = VAR_QTDE_ALTERACOES + 1;
    END IF;
    IF NOT (NEW.horarioFechamento <=> OLD.horarioFechamento) THEN
        SET VAR_TEXTO = CONCAT(VAR_TEXTO, '\nHORÁRIO FECHAMENTO: Antigo - ', OLD.horarioFechamento, ', Novo - ', NEW.horarioFechamento);
        SET VAR_QTDE_ALTERACOES = VAR_QTDE_ALTERACOES + 1;
    END IF;
    IF NOT (NEW.horarioFechamentoF <=> OLD.horarioFechamentoF) THEN
        SET VAR_TEXTO = CONCAT(VAR_TEXTO, '\nHORÁRIO FECHAMENTO FERIADO: Antigo - ', OLD.horarioFechamentoF, ', Novo - ', NEW.horarioFechamentoF);
        SET VAR_QTDE_ALTERACOES = VAR_QTDE_ALTERACOES + 1;
    END IF;
    IF NOT (NEW.contato <=> OLD.contato) THEN
        SET VAR_TEXTO = CONCAT(VAR_TEXTO, '\nCONTATO: Antigo - ', OLD.contato, ', Novo - ', NEW.contato);
        SET VAR_QTDE_ALTERACOES = VAR_QTDE_ALTERACOES + 1;
    END IF;
    IF NOT (NEW.site <=> OLD.site) THEN
        SET VAR_TEXTO = CONCAT(VAR_TEXTO, '\nSITE: Antigo - ', OLD.site, ', Novo - ', NEW.site);
        SET VAR_QTDE_ALTERACOES = VAR_QTDE_ALTERACOES + 1;
    END IF;
    IF NOT (NEW.email <=> OLD.email) THEN
        SET VAR_TEXTO = CONCAT(VAR_TEXTO, '\nEMAIL: Antigo - ', OLD.email, ', Novo - ', NEW.email);
        SET VAR_QTDE_ALTERACOES = VAR_QTDE_ALTERACOES + 1;
    END IF;
    IF NOT (NEW.precoEntrada <=> OLD.precoEntrada) THEN
        SET VAR_TEXTO = CONCAT(VAR_TEXTO, '\nPREÇO ENTRADA: Antigo - ', OLD.precoEntrada, ', Novo - ', NEW.precoEntrada);
        SET VAR_QTDE_ALTERACOES = VAR_QTDE_ALTERACOES + 1;
    END IF;
    IF NOT (NEW.estacionamento <=> OLD.estacionamento) THEN
        SET VAR_TEXTO = CONCAT(VAR_TEXTO, '\nESTACIONAMENTO: Antigo - ', OLD.estacionamento, ', Novo - ', NEW.estacionamento);
        SET VAR_QTDE_ALTERACOES = VAR_QTDE_ALTERACOES + 1;
    END IF;
    IF NOT (NEW.estruturasServicao <=> OLD.estruturasServicao) THEN
        SET VAR_TEXTO = CONCAT(VAR_TEXTO, '\nESTRUTURAS: Antigo - ', OLD.estruturasServicao, ', Novo - ', NEW.estruturasServicao);
        SET VAR_QTDE_ALTERACOES = VAR_QTDE_ALTERACOES + 1;
    END IF;
    IF NOT (NEW.avaliacaoGeral <=> OLD.avaliacaoGeral) THEN
        SET VAR_TEXTO = CONCAT(VAR_TEXTO, '\nAVALIAÇÃO GERAL: Antigo - ', OLD.avaliacaoGeral, ', Novo - ', NEW.avaliacaoGeral);
        SET VAR_QTDE_ALTERACOES = VAR_QTDE_ALTERACOES + 1;
    END IF;
    IF NOT (NEW.pacote <=> OLD.pacote) THEN
        SET VAR_TEXTO = CONCAT(VAR_TEXTO, '\nPACOTE: Antigo - ', OLD.pacote, ', Novo - ', NEW.pacote);
        SET VAR_QTDE_ALTERACOES = VAR_QTDE_ALTERACOES + 1;
    END IF;
    
    IF (VAR_TEXTO != '') THEN
		SET VAR_TEXTO = CONCAT('Houve ',VAR_QTDE_ALTERACOES,' MODIFICAÇÕES no Ponto Turistico ',OLD.nome,' (ID: ',OLD.idPonto,') com as seguintes ALTERAÇÕES:',VAR_TEXTO);
		INSERT INTO Auditoria (ID,NOME_TABELA,DETALHAMENTO,DATA) VALUES
			(NULL,VAR_NOME_TABELA,VAR_TEXTO,CURRENT_TIMESTAMP());
	ELSE
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Nenhuma informação alterada';
	END IF;
END%
CREATE TRIGGER Alterando_Tema
BEFORE UPDATE ON Tema
FOR EACH ROW
BEGIN
	DECLARE VAR_TEXTO TEXT;
    DECLARE VAR_NOME_TABELA VARCHAR(50) DEFAULT 'Tema';
    
	IF (NEW.Tema <=> OLD.Tema) THEN
		SELECT CONCAT('O Tema ',OLD.Tema,' (ID: ',NEW.idTema,') foi ALTERADO para ,',NEW.Tema) INTO VAR_TEXTO;
	ELSE
		SET VAR_TEXTO = '';
    END IF;
    
    IF (VAR_TEXTO = '') THEN
		INSERT INTO Auditoria (ID,NOME_TABELA,DETALHAMENTO,DATA) VALUES
			(NULL,VAR_NOME_TABELA,VAR_TEXTO,CURRENT_TIMESTAMP());
	ELSE
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tema não se alterou';
	END IF;
END%

CREATE TRIGGER Deletando_Ponto
BEFORE DELETE ON Ponto_Turistico
FOR EACH ROW
BEGIN
	DECLARE VAR_TEXTO TEXT;
    DECLARE VAR_NOME_TABELA VARCHAR(50) DEFAULT 'Ponto_Turistico';
    
    SELECT CONCAT('Foi DELETADO o Ponto turistico: ','\n','ID - ',OLD.idPonto,'\n','NOME - ',OLD.nome) INTO VAR_TEXTO;
    
    INSERT INTO Auditoria (ID,NOME_TABELA,DETALHAMENTO,DATA) VALUES
		(NULL,VAR_NOME_TABELA,VAR_TEXTO,CURRENT_TIMESTAMP());
END%
CREATE TRIGGER Deletando_View
AFTER DELETE ON Ponto_View
FOR EACH ROW
BEGIN
	DECLARE VAR_TEXTO TEXT;
    DECLARE VAR_NOME_TABELA VARCHAR(50) DEFAULT 'Ponto_View';
    
    SELECT CONCAT('Foi DELETADO a quantidade de visitantes no Ponto turistico: ','\n','ID - ',OLD.idPonto,'\n','VISITANTES TOTAIS - ',OLD.TotalVisitantes) INTO VAR_TEXTO;
    
    INSERT INTO Auditoria (ID,NOME_TABELA,DETALHAMENTO,DATA) VALUES
		(NULL,VAR_NOME_TABELA,VAR_TEXTO,CURRENT_TIMESTAMP());
END%
CREATE TRIGGER Deletando_Tema
AFTER DELETE ON Tema
FOR EACH ROW
BEGIN
	DECLARE VAR_TEXTO TEXT;
    DECLARE VAR_NOME_TABELA VARCHAR(50) DEFAULT 'Tema';
    
    SELECT CONCAT('Foi DELETADO o tema: ','\n','ID - ',OLD.idTema,'\n','TEMA - ',OLD.Tema) INTO VAR_TEXTO;
    
    INSERT INTO Auditoria (ID,NOME_TABELA,DETALHAMENTO,DATA) VALUES
		(NULL,VAR_NOME_TABELA,VAR_TEXTO,CURRENT_TIMESTAMP());
END%
DELIMITER ;

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
    SELECT COUNT(idPonto) INTO var_Verificar FROM pontoTuristico WHERE idPonto = param_idPonto;
    IF (var_Verificar > 0) THEN
        IF (param_TotalVisitantes > 0) THEN
            INSERT INTO Ponto_View(id,TotalVisitantes) VALUE (param_idPonto, param_TotalVisitantes);
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
    SELECT COUNT(idPonto) INTO var_Verificar FROM pontoTuristico WHERE idPonto = param_idPonto;
    IF (var_Verificar > 0) THEN
        IF (param_TotalVisitantes > 0) THEN
			IF (param_IsDeleting = 0) THEN
				UPDATE Ponto_View 
				SET id = param_idPonto AND TotalVisitantes = param_TotalVisitantes
				WHERE id = param_idPonto;
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
    SELECT (SELECT COUNT(idTema) FROM Tema WHERE idTema = param_idTema) * (SELECT COUNT(idPonto) FROM Ponto_Turistico WHERE idPonto = param_Ponto);
    
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

CREATE PROCEDURE Adicionar_FeedBack(IN param_Comunicado TEXT,IN param_Autor VARCHAR(50),IN param_Cidade VARCHAR(30),OUT param_Data DATE,OUT param_Status VARCHAR(20))
BEGIN
    INSERT INTO FeedBacks(ID,AUTOR,COMUNICADO,CIDADE,DATA_COMUNICADO,STATUS) VALUES
        (NULL,param_Autor,param_Comunicado,param_Cidade,CURRENT_TIMESTAMP(),'EM ESPERA');
    SET param_Data = CURRENT_TIMESTAMP();
    SET param_Status = 'EM ESPERA';
END%
CREATE PROCEDURE Alterar_FeedBack(IN param_ID INT,IN param_Status VARCHAR(20))
BEGIN
    UPDATE FeedBacks
    SET STATUS = param_Status
    WHERE ID = param_ID;
END%
DELIMITER ;

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

/*
DROP DATABASE IF EXISTS stayGoTurismo;

DROP TABLE IF EXISTS Ponto_Horarios;
DROP TABLE IF EXISTS Ponto_Localizacao;
DROP TABLE IF EXISTS Ponto_Contato;
DROP TABLE IF EXISTS Ponto_Complemento;
DROP TABLE IF EXISTS Ponto_View;
DROP TABLE IF EXISTS Ponto_Tema;
DROP TABLE IF EXISTS pontoTuristico;
DROP TABLE IF EXISTS FeedBacks;
DROP TABLE IF EXISTS Auditoria;

DROP VIEW IF EXISTS Show_Tema;
DROP VIEW IF EXISTS MostrarPontoTuristico;
DROP VIEW IF EXISTS MostrarPonto;
DROP VIEW IF EXISTS MostrarPontoComplemento;
DROP VIEW IF EXISTS MostrarPontoLocalizacao;
DROP VIEW IF EXISTS MostrarPontoHorario;
DROP VIEW IF EXISTS MostrarPontoContatos;
DROP VIEW IF EXISTS Show_Visitantes;

DROP PROCEDURE IF EXISTS AdicionarPontoTuristico;
DROP PROCEDURE IF EXISTS AtualizarPontoComplemento;
DROP PROCEDURE IF EXISTS AtualizarPontoContato;
DROP PROCEDURE IF EXISTS AtualizarPontoHorarios;
DROP PROCEDURE IF EXISTS AtualizarPontoLocalizacao;
DROP PROCEDURE IF EXISTS AtualizarPontoTuristico;
DROP PROCEDURE IF EXISTS Adicionar_Views;
DROP PROCEDURE IF EXISTS Alterar_Views;
DROP PROCEDURE IF EXISTS Adicionar_Tema;
DROP PROCEDURE IF EXISTS Alterar_Tema;

# */

-- PEDRO
CALL Adicionar_Ponto_Turistico( 'Uniao dos rios Negro e Solimoes formando o Amazonas','Encontro das Aguas','Amazonas','Manaus','Colonia Antonio Aleixo',69083000,'08:00:00','08:00:00','17:00:00','17:00:00',0.00,TRUE,'Mirante, estacionamento, banheiros, guias turisticos',4.9,'(92)3652-4362','https://visitamazonas.com/encontrodasaguas','info@visitamazonas.com','Amazonia Natural');
CALL Adicionar_Ponto_Turistico( 'Principal simbolo cultural de Manaus', 'Teatro Amazonas', 'Amazonas', 'Manaus', 'Centro', 69005090, '09:00:00', '09:00:00', '17:00:00', '17:00:00', 20.00, TRUE, 'Banheiros, loja de souvenirs, cafeteria, acessibilidade', 4.8, '(92)3622-1880', 'https://teatroamazonas.com.br', 'contato@teatroamazonas.com.br', 'Amazonia Cultural' );
CALL Adicionar_Ponto_Turistico( 'Arquipelago com mais de 400 ilhas no Rio Negro', 'Parque Nacional de Anavilhanas', 'Amazonas', 'Novo Airao', 'Zona Rural', 69730000, '07:00:00', '07:00:00', '18:00:00', '18:00:00', 0.00, TRUE, 'Centro de visitantes, estacionamento, banheiros, trilhas', 4.9, '(92)3379-1206', 'https://www.icmbio.gov.br/anavilhanas', 'anavilhanas@icmbio.gov.br', 'Amazonia Natural' );
CALL Adicionar_Ponto_Turistico( 'Mercado historico as margens do Rio Negro', 'Mercado Municipal Adolpho Lisboa', 'Amazonas', 'Manaus', 'Centro', 69005110, '06:00:00', '06:00:00', '17:00:00', '17:00:00', 0.00, TRUE, 'Banheiros, lanchonetes, caixas eletronicos, estacionamento', 4.6, '(92)3625-0081', 'https://manauscult.manaus.am.gov.br', 'mercado@manaus.am.gov.br', 'Amazonia Cultural' );
CALL Adicionar_Ponto_Turistico( 'Destino conhecido como o Caribe Amazonico', 'Alter do Chao', 'Para', 'Santarem', 'Alter do Chao', 68109000, '07:00:00', '07:00:00', '18:00:00', '18:00:00', 0.00, TRUE, 'Quiosques, estacionamento, banheiros, guias turisticos', 4.8, '(93)3522-1191', 'https://turismo.pa.gov.br', 'contato@turismo.pa.gov.br', 'Amazonia Natural' );
CALL Adicionar_Ponto_Turistico( 'Maior ilha fluviomarinha do mundo', 'Ilha de Marajo', 'Para', 'Soure', 'Centro', 68870000, '08:00:00', '08:00:00', '17:00:00', '17:00:00', 10.00, TRUE, 'Pousadas, restaurantes, trilhas, guias turisticos', 4.7, '(91)3741-1314', 'https://visitmarajo.com.br', 'info@visitmarajo.com.br', 'Amazonia Natural' );
CALL Adicionar_Ponto_Turistico( 'Maior parque de floresta tropical do mundo', 'Parque Nacional Montanhas do Tumucumaque', 'Amapa', 'Oiapoque', 'Zona Rural', 68980000, '08:00:00', '08:00:00', '16:00:00', '16:00:00', 0.00, FALSE, 'Centro de visitantes, trilhas, guias especializados', 4.9, '(96)3242-1206', 'https://www.icmbio.gov.br/tumucumaque', 'tumucumaque@icmbio.gov.br', 'Amazonia Natural' );
CALL Adicionar_Ponto_Turistico( 'Queda d agua de aguas azul-turquesa', 'Cachoeira de Santa Barbara', 'Tocantins', 'Mateiros', 'Chapada dos Veadeiros', 77393000, '08:00:00', '08:00:00', '17:00:00', '17:00:00', 20.00, TRUE, 'Estacionamento, trilhas, banheiros, guias', 4.9, '(63)3534-1256', 'https://turismo.to.gov.br', 'info@turismo.to.gov.br', 'Cerrado e Amazonia' );
CALL Adicionar_Ponto_Turistico( 'Regiao de montanhas, cachoeiras e trilhas ecologicas', 'Serra do Tepequem', 'Roraima', 'Amajari', 'Vila do Tepequem', 69343000, '07:00:00', '07:00:00', '18:00:00', '18:00:00', 0.00, TRUE, 'Pousadas, estacionamento, trilhas, restaurantes', 4.7, '(95)99972-4411', 'https://visitroraima.com.br', 'contato@visitroraima.com.br', 'Amazonia Natural' );
CALL Adicionar_Ponto_Turistico( 'Reserva de biodiversidade e nascentes de rios importantes', 'Parque Nacional Pacaas Novos', 'Rondonia', 'Guajara-Mirim', 'Zona Rural', 76850000, '07:00:00', '07:00:00', '17:00:00', '17:00:00', 0.00, FALSE, 'Centro de visitantes, trilhas, mirantes', 4.8, '(69)3541-2001', 'https://www.icmbio.gov.br/pacaasnovos', 'pacaasnovos@icmbio.gov.br', 'Amazonia Natural' );
CALL Adicionar_Ponto_Turistico( 'Montanha sagrada e marco geologico na fronteira Brasil-Venezuela-Guiana', 'Monte Roraima', 'Roraima', 'Pacaraima', 'Serra do Tepequem', 69345000, '06:00:00', '06:00:00', '18:00:00', '18:00:00', 0.00, FALSE, 'Trilhas, guias, camping controlado', 5.0, '(95)3621-1200', 'https://visitroraima.com.br', 'info@visitroraima.com.br', 'Amazonia Natural' );
CALL Adicionar_Ponto_Turistico( 'Piscina natural de aguas cristalinas no Jalapao', 'Cachoeira do Formiga', 'Tocantins', 'Mateiros', 'Zona Rural', 77393000, '07:00:00', '07:00:00', '17:00:00', '17:00:00', 20.00, TRUE, 'Estacionamento, banheiros, quiosques', 4.9, '(63)3534-1256', 'https://turismo.to.gov.br', 'contato@turismo.to.gov.br', 'Cerrado e Amazonia' );
CALL Adicionar_Ponto_Turistico( 'Reserva de biodiversidade e pesquisa cientifica na Amazonia', 'Floresta Nacional de Caxiuana', 'Para', 'Melgaco', 'Zona Rural', 68490000, '08:00:00', '08:00:00', '16:00:00', '16:00:00', 0.00, FALSE, 'Centro de pesquisa, trilhas, mirante', 4.7, '(91)3224-3541', 'https://www.museu-goeldi.br', 'caxiuana@museu-goeldi.br', 'Amazonia Cientifica' );
CALL Adicionar_Ponto_Turistico( 'Instituicao cientifica e museu de historia natural mais antigo do Brasil', 'Museu Paraense Emilio Goeldi', 'Para', 'Belem', 'Nazare', 66060000, '09:00:00', '09:00:00', '17:00:00', '17:00:00', 10.00, TRUE, 'Banheiros, cafeteria, estacionamento, loja', 4.8, '(91)3075-6000', 'https://www.museu-goeldi.br', 'museu@museu-goeldi.br', 'Amazonia Cultural' );
CALL Adicionar_Ponto_Turistico( 'Beira-rio urbana as margens do Rio Amazonas', 'Orla de Macapa', 'Amapa', 'Macapa', 'Centro', 68900000, '06:00:00', '06:00:00', '23:00:00', '23:00:00', 0.00, TRUE, 'Estacionamento, quiosques, banheiros, ciclovia', 4.6, '(96)3223-1234', 'https://macapa.ap.gov.br', 'turismo@macapa.ap.gov.br', 'Amazonia Urbana' );
CALL Adicionar_Ponto_Turistico( 'Forte historico construido no seculo XVIII', 'Fortaleza de Sao Jose de Macapa', 'Amapa', 'Macapa', 'Centro', 68900000, '09:00:00', '09:00:00', '18:00:00', '18:00:00', 5.00, TRUE, 'Banheiros, guias, estacionamento, loja de artesanato', 4.8, '(96)3223-1204', 'https://fortalezadesaojose.ap.gov.br', 'fortaleza@ap.gov.br', 'Amazonia Historica' );
CALL Adicionar_Ponto_Turistico( 'Cachoeira colorida devido aos minerais da rocha', 'Cachoeira do Arco-Iris', 'Amazonas', 'Presidente Figueiredo', 'Zona Rural', 69735000, '08:00:00', '08:00:00', '17:00:00', '17:00:00', 10.00, TRUE, 'Estacionamento, banheiros, quiosques, guias', 4.7, '(92)3324-1551', 'https://presidentefigueiredo.am.gov.br', 'turismo@presidentefigueiredo.am.gov.br', 'Amazonia Natural' );
CALL Adicionar_Ponto_Turistico( 'Praia extensa com aguas mornas e bares rusticos', 'Praia do Pesqueiro', 'Para', 'Soure', 'Pesqueiro', 68870000, '08:00:00', '08:00:00', '18:00:00', '18:00:00', 0.00, TRUE, 'Estacionamento, quiosques, banheiros, redes', 4.6, '(91)3741-1221', 'https://visitmarajo.com.br', 'info@visitmarajo.com.br', 'Amazonia Natural' );
CALL Adicionar_Ponto_Turistico( 'Unidade de conservacao com rica biodiversidade', 'Parque Nacional da Serra do Pardo', 'Para', 'Sao Felix do Xingu', 'Zona Rural', 68380000, '07:00:00', '07:00:00', '16:00:00', '16:00:00', 0.00, FALSE, 'Centro de visitantes, trilhas, observacao de fauna', 4.8, '(91)3223-2555', 'https://www.icmbio.gov.br/serradopardo', 'serradopardo@icmbio.gov.br', 'Amazonia Natural' );
CALL Adicionar_Ponto_Turistico( 'Jardim botanico com mais de 16 hectares no centro de Belem', 'Bosque Rodrigues Alves', 'Para', 'Belem', 'Marco', 66095000, '08:00:00', '08:00:00', '17:00:00', '17:00:00', 5.00, TRUE, 'Banheiros, lanchonete, trilhas, playground', 4.7, '(91)3249-3499', 'https://belem.pa.gov.br', 'bosque@belem.pa.gov.br', 'Amazonia Cultural' );
CALL Adicionar_Ponto_Turistico( 'Mercado publico historico e simbolo de Belem', 'Ver-o-Peso', 'Para', 'Belem', 'Cidade Velha', 66010000, '05:00:00', '05:00:00', '18:00:00', '18:00:00', 0.00, TRUE, 'Banheiros, lanchonetes, estacionamento, banca de ervas', 4.6, '(91)3242-1234', 'https://belem.pa.gov.br', 'turismo@belem.pa.gov.br', 'Amazonia Cultural' );
CALL Adicionar_Ponto_Turistico( 'Museu a ceu aberto dedicado a biodiversidade amazonica', 'Museu da Amazonia (MUSA)', 'Amazonas', 'Manaus', 'Cidade de Deus', 69099000, '08:00:00', '08:00:00', '17:00:00', '17:00:00', 15.00, TRUE, 'Banheiros, trilhas, torres de observacao, loja', 4.9, '(92)3582-3188', 'https://museudaamazonia.org.br', 'contato@museudaamazonia.org.br', 'Amazonia Cientifica' );
CALL Adicionar_Ponto_Turistico( 'Queda d agua de facil acesso em meio a floresta', 'Cachoeira do Mutum', 'Amazonas', 'Presidente Figueiredo', 'Zona Rural', 69735000, '07:00:00', '07:00:00', '17:00:00', '17:00:00', 10.00, TRUE, 'Banheiros, estacionamento, trilhas, guias', 4.7, '(92)3324-1551', 'https://presidentefigueiredo.am.gov.br', 'info@presidentefigueiredo.am.gov.br', 'Amazonia Natural' );
CALL Adicionar_Ponto_Turistico( 'Principal templo religioso de Belem e ponto central do Cirio de Nazare', 'Catedral de Nossa Senhora de Nazare', 'Para', 'Belem', 'Nazare', 66035000, '06:00:00', '06:00:00', '20:00:00', '20:00:00', 0.00, TRUE, 'Banheiros, estacionamento, loja religiosa', 4.8, '(91)4006-9199', 'https://basilicadenazare.com.br', 'contato@basilicadenazare.com.br', 'Amazonia Religiosa' );
CALL Adicionar_Ponto_Turistico( 'Regiao de cerrado com dunas, fervedouros e cachoeiras', 'Parque Estadual do Jalapao', 'Tocantins', 'Mateiros', 'Zona Rural', 77393000, '06:00:00', '06:00:00', '18:00:00', '18:00:00', 0.00, FALSE, 'Trilhas, guias, areas de camping', 4.9, '(63)3534-1256', 'https://turismo.to.gov.br', 'jalapao@turismo.to.gov.br', 'Cerrado e Amazonia' );
CALL Adicionar_Ponto_Turistico( 'Area de preservacao ambiental e lazer urbano', 'Parque Ambiental Chico Mendes', 'Acre', 'Rio Branco', 'Distrito Industrial', 69917000, '08:00:00', '08:00:00', '17:00:00', '17:00:00', 0.00, TRUE, 'Banheiros, trilhas, lanchonete, estacionamento', 4.6, '(68)3224-7580', 'https://riobranco.ac.gov.br', 'turismo@riobranco.ac.gov.br', 'Amazonia Urbana' );
CALL Adicionar_Ponto_Turistico( 'Rio famoso por praias de agua doce e pesca esportiva', 'Rio Araguaia', 'Tocantins', 'Araguaina', 'Beira Rio', 77803000, '07:00:00', '07:00:00', '18:00:00', '18:00:00', 0.00, TRUE, 'Estacionamento, quiosques, banheiros, guias de pesca', 4.8, '(63)3412-1200', 'https://turismo.to.gov.br', 'info@turismo.to.gov.br', 'Cerrado e Amazonia' );
CALL Adicionar_Ponto_Turistico( 'Cachoeira em meio a paredoes de pedra e mata fechada', 'Cachoeira de Iracema', 'Amazonas', 'Presidente Figueiredo', 'Zona Rural', 69735000, '07:00:00', '07:00:00', '17:00:00', '17:00:00', 10.00, TRUE, 'Banheiros, estacionamento, trilhas, restaurante', 4.8, '(92)3324-1551', 'https://presidentefigueiredo.am.gov.br', 'turismo@presidentefigueiredo.am.gov.br', 'Amazonia Natural' );
CALL Adicionar_Ponto_Turistico( 'Maior praca urbana da America Latina', 'Praca dos Girassois', 'Tocantins', 'Palmas', 'Plano Diretor Sul', 77015000, '00:00:00', '00:00:00', '23:59:00', '23:59:00', 0.00, TRUE, 'Estacionamento, fontes, monumentos, banheiros', 4.6, '(63)3212-7000', 'https://palmas.to.gov.br', 'turismo@palmas.to.gov.br', 'Amazonia Urbana' );
CALL Adicionar_Ponto_Turistico( 'Reserva natural com grande diversidade de fauna e flora','Parque Nacional da Serra da Cutia','Rondonia','Guajara-Mirim','Zona Rural',76850000,'07:00:00','07:00:00','17:00:00','17:00:00',0.00,FALSE,'Trilhas, centro de visitantes, mirante natural',4.9,'(69)3541-2001','https://www.icmbio.gov.br/serradacutia','serradacutia@icmbio.gov.br','Amazonia Natural');


-- Enzo
CALL Adicionar_Ponto_Turistico('Parque nacional com cachoeiras e trilhas famosas', 'Parque Nacional da Chapada dos Veadeiros', 'Goiás', 'Alto Paraíso de Goiás', 'Zona Rural', 73770000, '08:00:00', '08:00:00', '18:00:00', '18:00:00', 30.00, TRUE, 'Trilhas guiadas, estacionamento, centro de visitantes', 4.9, '62987654321', 'https://www.icmbio.gov.br/chapadadosveadeiros/', 'contato@chapada.gov.br', 'Pacote Ecoturismo GO');
CALL Adicionar_Ponto_Turistico('Formações rochosas e piscinas naturais', 'Vale da Lua', 'Goiás', 'São Jorge (Chapada dos Veadeiros)', 'Zona Rural', 73770500, '08:00:00', '08:00:00', '17:00:00', '17:00:00', 10.00, TRUE, 'Trilhas, mirantes, estacionamento', 4.7, '62981234567', 'https://visitgoias.com/valedalua', 'info@valedalua.com', 'Pacote Natureza GO');
CALL Adicionar_Ponto_Turistico('Cachoeira de águas claras e turismo de aventura', 'Cachoeira Santa Bárbara', 'Goiás', 'Cavalcante', 'Zona Rural', 73790000, '07:00:00', '07:00:00', '17:00:00', '17:00:00', 20.00, FALSE, 'Trilhas, guias locais', 4.8, '62983456789', 'https://santabarbara.com.br', 'contato@santabarbara.com.br', 'Pacote Aventura GO');
CALL Adicionar_Ponto_Turistico('Complexo de grutas e cavernas', 'Gruta do Índio', 'Goiás', 'Posse', 'Centro', 73600000, '08:00:00', '08:00:00', '16:30:00', '16:30:00', 5.00, FALSE, 'Visitas guiadas, iluminação interna', 4.4, '62980011223', 'https://grutasgoias.com', 'contato@grutasgoias.com', 'Pacote Cultura GO');
CALL Adicionar_Ponto_Turistico('Lagoa e mirantes em cidade turística', 'Lagoa Formosa', 'Goiás', 'Cavalcante', 'Zona Rural', 73790500, '08:00:00', '08:00:00', '17:00:00', '17:00:00', 0.00, TRUE, 'Mirante, estacionamento', 4.2, '62989900112', 'https://goias.tur.br/lagoa', 'info@lagoaformosa.com', 'Pacote Relax GO');
CALL Adicionar_Ponto_Turistico('Sítio arqueológico e trilhas', 'Sítio Arqueológico de São Jorge', 'Goiás', 'São Jorge', 'Zona Rural', 73770501, '09:00:00', '09:00:00', '16:00:00', '16:00:00', 8.00, FALSE, 'Visitas guiadas, trilhas educativas', 4.3, '62987700111', 'https://arqueologia.go.gov.br', 'contato@arqueologia.go', 'Pacote Cultura GO');
CALL Adicionar_Ponto_Turistico('Parque estadual com cânions', 'Parque Estadual de Terra Ronca', 'Goiás', 'Alto Paraíso de Goiás', 'Zona Rural', 73770001, '07:30:00', '07:30:00', '17:30:00', '17:30:00', 25.00, TRUE, 'Cânions, grutas, camping', 4.6, '62980033445', 'https://terraronca.gov.br', 'info@terraronca.gov.br', 'Pacote Aventura GO');
CALL Adicionar_Ponto_Turistico('Praça histórica e centro cultural', 'Centro Histórico de Goiás Velho', 'Goiás', 'Goiás Velho', 'Centro', 76600000, '08:00:00', '08:00:00', '18:00:00', '18:00:00', 0.00, FALSE, 'Museus, igrejas, guias', 4.5, '62412345678', 'https://goiasvelho.tur.br', 'contato@goiasvelho.gov.br', 'Pacote Histórico GO');
CALL Adicionar_Ponto_Turistico('Balneário com formações rochosas', 'Parque Estadual de Pirenópolis', 'Goiás', 'Pirenópolis', 'Centro', 72980000, '09:00:00', '09:00:00', '18:00:00', '18:00:00', 12.00, TRUE, 'Cachoeiras, centro histórico', 4.7, '62981230000', 'https://pirenopolis.tur.br', 'info@pirenopolis.gov.br', 'Pacote Cultural GO');
CALL Adicionar_Ponto_Turistico('Roteiro religioso e arquitetura colonial', 'Santuário de Nossa Senhora do Rosário', 'Goiás', 'Cidade de Goiás', 'Centro', 76600001, '07:00:00', '07:00:00', '19:00:00', '19:00:00', 0.00, FALSE, 'Igreja, visita guiada', 4.4, '62412345999', 'https://santuario.go.gov.br', 'contato@santuario.gov.br', 'Pacote Religioso GO');
CALL Adicionar_Ponto_Turistico('Complexo natural e passeios de barco', 'Ilhas do Araguaia', 'Goiás', 'Santa Isabel', 'Zona Rural', 76300000, '06:00:00', '06:00:00', '17:00:00', '17:00:00', 15.00, TRUE, 'Passeios de barco, pesca esportiva', 4.6, '62970011223', 'https://araguaia.tur.br', 'contato@araguaia.com', 'Pacote Aventura GO');
CALL Adicionar_Ponto_Turistico('Observação de aves e ecoturismo', 'Reserva Ecológica Serra de Jaraguá', 'Goiás', 'Goiânia', 'Zona Rural', 74000000, '08:00:00', '08:00:00', '17:00:00', '17:00:00', 5.00, TRUE, 'Trilhas, observação de aves', 4.3, '62981112233', 'https://jaragua.eco.br', 'info@serradejaragua.org', 'Pacote Natureza GO');
CALL Adicionar_Ponto_Turistico('Cachoeira e turismo rural', 'Cachoeira do Label', 'Goiás', 'Formosa', 'Zona Rural', 73800000, '08:00:00', '08:00:00', '17:00:00', '17:00:00', 6.00, TRUE, 'Piscinas naturais, estacionamento', 4.1, '62979998877', 'https://label.tur.br', 'contato@label.com', 'Pacote Rural GO');
CALL Adicionar_Ponto_Turistico('Paisagens de cerrado e paredões', 'Parque Nacional da Chapada dos Guimarães', 'Mato Grosso', 'Chapada dos Guimarães', 'Centro', 78195000, '08:00:00', '08:00:00', '17:00:00', '17:00:00', 20.00, TRUE, 'Trilhas, mirantes, centro de visitantes', 4.8, '65981234567', 'https://chapadaguimaraes.icmbio.gov.br', 'contato@chapada.mt', 'Pacote Natureza MT');
CALL Adicionar_Ponto_Turistico('Recanto de águas cristalinas e mergulho', 'Nobres - Aquário Natural', 'Mato Grosso', 'Nobres', 'Zona Rural', 78600000, '07:00:00', '07:00:00', '16:00:00', '16:00:00', 45.00, TRUE, 'Mergulho, flutuação, guias', 4.9, '65987655444', 'https://nobres.tur.br', 'info@nobres.com.br', 'Pacote Ecoturismo MT');
CALL Adicionar_Ponto_Turistico('Pantanal mato-grossense, observação de fauna', 'Pantanal Norte (MT)', 'Mato Grosso', 'Poconé', 'Zona Rural', 78480000, '06:00:00', '06:00:00', '18:00:00', '18:00:00', 120.00, TRUE, 'Passeios de barco, hospedagem em fazendas', 5.0, '65990011223', 'https://pantanalmt.com', 'contato@pantanalmt.com', 'Pacote Pantanal MT');
CALL Adicionar_Ponto_Turistico('Cachoeira e turismo de aventura', 'Cachoeira Véu de Noiva', 'Mato Grosso', 'Parque Nacional da Chapada', 'Zona Rural', 78195100, '08:00:00', '08:00:00', '17:00:00', '17:00:00', 10.00, FALSE, 'Trilhas, mirantes', 4.5, '65981239999', 'https://veudenoiva.mt', 'contato@veudenoiva.com', 'Pacote Aventura MT');
CALL Adicionar_Ponto_Turistico('Sítio arqueológico e história', 'Sítio Arqueológico de São Benedito', 'Mato Grosso', 'Cáceres', 'Centro', 78200000, '09:00:00', '09:00:00', '16:00:00', '16:00:00', 5.00, FALSE, 'Museu, visita guiada', 4.2, '65981230001', 'https://cacres.tur.br', 'contato@sao.benedito.com', 'Pacote Histórico MT');
CALL Adicionar_Ponto_Turistico('Lago e atividades náuticas', 'Lago de Chapada', 'Mato Grosso', 'Chapada dos Guimarães', 'Zona Rural', 78195200, '07:00:00', '07:00:00', '18:00:00', '18:00:00', 0.00, TRUE, 'Passeios de barco, pesca', 4.1, '65981110022', 'https://lagochapada.mt', 'info@lagochapada.com', 'Pacote Lazer MT');
CALL Adicionar_Ponto_Turistico('Mirantes e formações rochosas', 'Morro de São Jerônimo', 'Mato Grosso', 'Rondonópolis', 'Zona Rural', 78700000, '06:30:00', '06:30:00', '17:30:00', '17:30:00', 8.00, TRUE, 'Mirante, trilhas', 4.0, '65980044556', 'https://rondonopolis.tur.br', 'contato@morrojeronimo.com', 'Pacote Natureza MT');
CALL Adicionar_Ponto_Turistico('Caverna e turismo subterrâneo', 'Gruta da Lagoa Azul', 'Mato Grosso', 'Diamantino', 'Zona Rural', 78500000, '08:00:00', '08:00:00', '16:00:00', '16:00:00', 12.00, FALSE, 'Visitas guiadas, iluminação especial', 4.3, '65980000111', 'https://grutasdiamantino.br', 'contato@grutasdiamantino.br', 'Pacote Aventura MT');
CALL Adicionar_Ponto_Turistico('Sítio histórico e cultura local', 'Centro Histórico de Cuiabá', 'Mato Grosso', 'Cuiabá', 'Centro', 78000000, '08:00:00', '08:00:00', '18:00:00', '18:00:00', 0.00, TRUE, 'Museus, igrejas, tours', 4.4, '65981112233', 'https://cuiaba.tur.br', 'info@cuiaba.gov.br', 'Pacote Cultural MT');
CALL Adicionar_Ponto_Turistico('Trilhas e cachoeiras preservadas', 'Parque Municipal Mãe Bonifácia', 'Mato Grosso', 'Cuiabá', 'Centro', 78005000, '06:00:00', '06:00:00', '18:00:00', '18:00:00', 0.00, TRUE, 'Trilhas urbanas, área verde', 4.2, '65981224455', 'https://maebonifacia.cuiaba', 'contato@maebonifacia.org', 'Pacote Lazer MT');
CALL Adicionar_Ponto_Turistico('Reserva ecológica e observação de aves', 'Reserva do Xingu (trecho Mato Grosso)', 'Mato Grosso', 'São Félix do Araguaia', 'Zona Rural', 78550000, '06:00:00', '06:00:00', '17:00:00', '17:00:00', 10.00, FALSE, 'Observação de fauna e flora', 4.1, '65989977665', 'https://xingu.org', 'contato@xingu.org', 'Pacote Ecoturismo MT');
CALL Adicionar_Ponto_Turistico('Cachoeira de grande queda', 'Cachoeira dos Namorados', 'Mato Grosso', 'Juara', 'Zona Rural', 78300000, '08:00:00', '08:00:00', '17:00:00', '17:00:00', 7.00, TRUE, 'Trilhas, mirante', 4.0, '65979900123', 'https://cachoeirasmt.com', 'contato@namorados.com', 'Pacote Aventura MT');
CALL Adicionar_Ponto_Turistico('Roteiro de pesca esportiva', 'Rio Teles Pires', 'Mato Grosso', 'Sinop', 'Zona Rural', 78530000, '05:00:00', '05:00:00', '18:00:00', '18:00:00', 0.00, TRUE, 'Pesca esportiva, pousadas', 4.5, '65978811223', 'https://telespires.mt', 'info@telespires.mt', 'Pacote Pesca MT');
CALL Adicionar_Ponto_Turistico('Recanto de águas cristalinas e turismo de mergulho', 'Rio da Prata', 'Mato Grosso do Sul', 'Bonito', 'Centro', 79200000, '06:30:00', '06:30:00', '17:30:00', '17:30:00', 120.00, TRUE, 'Flutuação, trilhas, centro de visitantes', 5.0, '67999887766', 'https://visitbonito.com.br', 'contato@visitbonito.com.br', 'Pacote Bonito MS');
CALL Adicionar_Ponto_Turistico('Gruta com lago azul e formação calcária', 'Gruta do Lago Azul', 'Mato Grosso do Sul', 'Bonito', 'Zona Rural', 79200001, '08:00:00', '08:00:00', '16:00:00', '16:00:00', 80.00, FALSE, 'Visitas guiadas, área protegida', 4.9, '67990011234', 'https://grutalagoazul.com.br', 'info@grutaazul.com', 'Pacote Natureza MS');
CALL Adicionar_Ponto_Turistico('Maior planície alagável do mundo, safáris fotográficos', 'Pantanal Sul (MS)', 'Mato Grosso do Sul', 'Corumbá', 'Zona Rural', 79300000, '06:00:00', '06:00:00', '18:00:00', '18:00:00', 150.00, TRUE, 'Passeios de barco, hospedagem em fazendas', 5.0, '67987654321', 'https://pantanalms.com.br', 'contato@pantanalms.com', 'Pacote Pantanal MS');
CALL Adicionar_Ponto_Turistico('Cachoeiras e cânions preservados', 'Parque Nacional da Serra da Bodoquena', 'Mato Grosso do Sul', 'Bodoquena', 'Zona Rural', 79280000, '08:00:00', '08:00:00', '17:00:00', '17:00:00', 25.00, TRUE, 'Trilhas, cachoeiras, mirantes', 4.8, '67981234567', 'https://serradabodoquena.ms.gov.br', 'contato@serradabodoquena.ms', 'Pacote Aventura MS');
CALL Adicionar_Ponto_Turistico('Complexo de águas e lagoas cristalinas', 'Aquário Natural', 'Mato Grosso do Sul', 'Bonito', 'Zona Rural', 79200002, '06:00:00', '06:00:00', '17:00:00', '17:00:00', 100.00, TRUE, 'Flutuação, observação subaquática', 4.9, '67982223344', 'https://aquarionatural.com', 'info@aquarionatural.com', 'Pacote Ecoturismo MS');
CALL Adicionar_Ponto_Turistico('Cavernas e passeios guiados', 'Gruta do Lago Azul (região alternativa)', 'Mato Grosso do Sul', 'Bonito', 'Zona Rural', 79200003, '08:00:00', '08:00:00', '16:00:00', '16:00:00', 75.00, FALSE, 'Visita guiada, degraus e iluminação', 4.7, '67981112233', 'https://grutasms.com', 'contato@grutasms.com', 'Pacote Cultura MS');
CALL Adicionar_Ponto_Turistico('Roteiros de aventura e rapel', 'Parque das Cachoeiras', 'Mato Grosso do Sul', 'Bonito', 'Zona Rural', 79200004, '07:00:00', '07:00:00', '17:00:00', '17:00:00', 35.00, TRUE, 'Rapel, trilhas, mirantes', 4.6, '67980044556', 'https://parquecachoeiras.com', 'contato@parquecachoeiras.com', 'Pacote Aventura MS');
CALL Adicionar_Ponto_Turistico('Sitio histórico indígena e observação de fauna', 'Ilha do Padre (Pantanal)', 'Mato Grosso do Sul', 'Corumbá', 'Zona Rural', 79300001, '06:00:00', '06:00:00', '17:00:00', '17:00:00', 0.00, TRUE, 'Observação de aves, tours', 4.5, '67989911223', 'https://pantanalilhadopadre.com', 'contato@ilhadopadre.com', 'Pacote Pantanal MS');
CALL Adicionar_Ponto_Turistico('Cachoeira com piscinas naturais', 'Cachoeira do Rio Formoso', 'Mato Grosso do Sul', 'Bodoquena', 'Zona Rural', 79280001, '08:00:00', '08:00:00', '17:00:00', '17:00:00', 10.00, TRUE, 'Piscinas naturais, trilhas', 4.4, '67982220011', 'https://rioformoso.ms', 'info@rioformoso.ms', 'Pacote Natureza MS');
CALL Adicionar_Ponto_Turistico('Cânion e turismo de aventura', 'Cânion do Rio Salobra', 'Mato Grosso do Sul', 'Bonito', 'Zona Rural', 79200005, '06:00:00', '06:00:00', '17:00:00', '17:00:00', 40.00, FALSE, 'Cânion, trilhas técnicas', 4.3, '67983334455', 'https://canyonsms.com', 'contato@canyonsms.com', 'Pacote Aventura MS');
CALL Adicionar_Ponto_Turistico('Praia de água doce e lazer', 'Balneário Municipal de Corumbá', 'Mato Grosso do Sul', 'Corumbá', 'Centro', 79300002, '08:00:00', '08:00:00', '19:00:00', '19:00:00', 0.00, TRUE, 'Banho de rio, quiosques', 4.0, '67984445566', 'https://corumba.ms', 'contato@corumba.ms', 'Pacote Lazer MS');
CALL Adicionar_Ponto_Turistico('Observação de vida silvestre e fazendas', 'Fazenda de Ecoturismo em Miranda', 'Mato Grosso do Sul', 'Miranda', 'Zona Rural', 79290000, '05:30:00', '05:30:00', '18:00:00', '18:00:00', 90.00, TRUE, 'Safáris fotográficos, hospedagem', 4.8, '67987776655', 'https://miranda.ms', 'info@fazendaecoturismo.com', 'Pacote Pantanal MS');
CALL Adicionar_Ponto_Turistico('Roteiro arqueológico e cavernas', 'Caverna do Diabo (trecho MS)', 'Mato Grosso do Sul', 'Aquidauana', 'Zona Rural', 79210000, '08:00:00', '08:00:00', '16:00:00', '16:00:00', 20.00, FALSE, 'Visitas guiadas, formações', 4.2, '67981237899', 'https://cavernasms.com', 'contato@cavernasms.com', 'Pacote Cultura MS');
CALL Adicionar_Ponto_Turistico('Obra-prima de Oscar Niemeyer e ponto turístico icônico', 'Catedral Metropolitana de Brasília', 'Distrito Federal', 'Brasília', 'Esplanada dos Ministérios', 70050000, '08:00:00', '08:00:00', '18:00:00', '18:00:00', 0.00, FALSE, 'Arquitetura, visitas guiadas', 4.7, '61981234567', 'https://www.catedral.org.br', 'contato@catedral.org.br', 'Pacote Cultural DF');
CALL Adicionar_Ponto_Turistico('Sede do poder legislativo e arquitetura moderna', 'Congresso Nacional', 'Distrito Federal', 'Brasília', 'Esplanada dos Ministérios', 70060000, '09:00:00', '09:00:00', '17:00:00', '17:00:00', 0.00, TRUE, 'Visitas guiadas, exposições', 4.6, '61981112233', 'https://www2.congressonacional.leg.br', 'info@congresso.gov.br', 'Pacote Cultural DF');
CALL Adicionar_Ponto_Turistico('Residência oficial do presidente', 'Palácio da Alvorada', 'Distrito Federal', 'Brasília', 'Zona Sul', 70040900, '09:00:00', '09:00:00', '16:00:00', '16:00:00', 0.00, TRUE, 'Visitas externas, jardins', 4.4, '61980011223', 'https://palacioalvorada.gov.br', 'contato@alvorada.gov.br', 'Pacote Histórico DF');
CALL Adicionar_Ponto_Turistico('Parque urbano com grande área verde', 'Parque da Cidade Sarah Kubitschek', 'Distrito Federal', 'Brasília', 'Lago Sul', 70700000, '05:00:00', '05:00:00', '20:00:00', '20:00:00', 0.00, TRUE, 'Parques, pistas, eventos', 4.5, '61987770011', 'https://parquedacidade.df.gov.br', 'info@parquedacidade.df', 'Pacote Lazer DF');
CALL Adicionar_Ponto_Turistico('Lago artificial e esportes náuticos', 'Lago Paranoá e Pontão do Lago Sul', 'Distrito Federal', 'Brasília', 'Lago Sul', 70660000, '06:00:00', '06:00:00', '21:00:00', '21:00:00', 0.00, TRUE, 'Esportes náuticos, restaurantes', 4.6, '61989990022', 'https://lagoparanoa.df.gov.br', 'contato@lagoparanoa.df', 'Pacote Lazer DF');
CALL Adicionar_Ponto_Turistico('Museu e arquitetura modernista', 'Museu Nacional Honestino Guimarães', 'Distrito Federal', 'Brasília', 'Esplanada', 70055900, '09:00:00', '09:00:00', '17:00:00', '17:00:00', 0.00, TRUE, 'Exposições, acervo histórico', 4.3, '61981113344', 'https://museunacional.gov.br', 'info@museu.df', 'Pacote Cultural DF');
CALL Adicionar_Ponto_Turistico('Torre de TV com vista panorâmica', 'Torre de TV de Brasília', 'Distrito Federal', 'Brasília', 'Centro', 70707000, '08:00:00', '08:00:00', '22:00:00', '22:00:00', 5.00, TRUE, 'Mirante, feiras de artesanato', 4.2, '61982223344', 'https://torredetv.df.gov.br', 'contato@torredetv.df', 'Pacote Visita DF');
CALL Adicionar_Ponto_Turistico('Sítio histórico de Oscar Niemeyer', 'Palácio do Itamaraty (visita externa)', 'Distrito Federal', 'Brasília', 'Esplanada', 70067900, '09:00:00', '09:00:00', '17:00:00', '17:00:00', 0.00, TRUE, 'Arquitetura, jardins', 4.4, '61983334455', 'https://itamaraty.gov.br', 'info@itamaraty.gov.br', 'Pacote Cultural DF');
CALL Adicionar_Ponto_Turistico('Lago e centro de eventos ao ar livre', 'Parque Nacional de Brasília (Águas Emendadas)', 'Distrito Federal', 'Formosa', 'Área Rural', 73800001, '06:00:00', '06:00:00', '18:00:00', '18:00:00', 10.00, TRUE, 'Trilhas, observação de fauna', 4.1, '61984445566', 'https://parquenacionalbrasilia.gov.br', 'contato@parquenacional.df', 'Pacote Natureza DF');
CALL Adicionar_Ponto_Turistico('Complexo cultural e centro de exposições', 'Centro Cultural Banco do Brasil - Brasília (CCBB)', 'Distrito Federal', 'Brasília', 'Esplanada', 70060010, '09:00:00', '09:00:00', '19:00:00', '19:00:00', 0.00, TRUE, 'Exposições, teatro, cinema', 4.5, '61985556677', 'https://ccbb.com.br/brasilia', 'info@ccbb.df', 'Pacote Cultural DF');
CALL Adicionar_Ponto_Turistico('Memorial e museu', 'Memorial JK', 'Distrito Federal', 'Brasília', 'Esplanada dos Ministérios', 70050010, '09:00:00', '09:00:00', '17:00:00', '17:00:00', 0.00, TRUE, 'Exposições sobre Juscelino Kubitschek', 4.4, '61986667788', 'https://memorialjk.gov.br', 'contato@memorialjk.gov.br', 'Pacote Histórico DF');
CALL Adicionar_Ponto_Turistico('Praça e arte urbana', 'Praça dos Três Poderes', 'Distrito Federal', 'Brasília', 'Esplanada', 70060011, '00:00:00', '00:00:00', '23:59:00', '23:59:00', 0.00, TRUE, 'Monumentos, eventos públicos', 4.2, '61987778899', 'https://brasiliaturismo.df.gov.br', 'info@praca3poderes.df', 'Pacote Cultural DF');
CALL Adicionar_Ponto_Turistico('Roteiro de arquitetura e modernismo', 'Itinerário Niemeyer', 'Distrito Federal', 'Brasília', 'Centro', 70060012, '09:00:00', '09:00:00', '17:00:00', '17:00:00', 0.00, TRUE, 'Tours arquitetônicos, guia especializado', 4.6, '61981239900', 'https://itinerarioniemeyer.br', 'contato@niemeyer.it', 'Pacote Arquitetura DF');


-- Lopes
CALL Adicionar_Ponto_Turistico( 'Parque nacional de dunas, lagoas e rios', 'Lençóis Maranhenses', 'Maranhão', 'Barreirinhas', 'Zona Rural', 65590000, '08:00:00', '08:00:00', '18:00:00', '18:00:00', 0.00, TRUE, 'Passeios de buggy, guias, camping', 4.9, '(98)3349-1200', 'https://www.icmbio.gov.br/lencoismaranhenses', 'lencoismaranhenses@icmbio.gov.br', 'Natureza e Aventura' );
CALL Adicionar_Ponto_Turistico( 'Vila de pescadores com praias paradisíacas e lagoas', 'Jericoacoara', 'Ceará', 'Jijoca de Jericoacoara', 'Centro', 62598000, '06:00:00', '06:00:00', '22:00:00', '22:00:00', 0.00, TRUE, 'Dunas, lagoas, restaurantes, pousadas', 4.8, '(88)3669-1111', 'https://www.jericoacoara.com.br', 'contato@jericoacoara.com.br', 'Praia e Aventura' );
CALL Adicionar_Ponto_Turistico( 'Arquipélago vulcânico com praias e vida marinha exuberante', 'Fernando de Noronha', 'Pernambuco', 'Fernando de Noronha', 'Vila dos Remédios', 53990000, '08:00:00', '08:00:00', '17:00:00', '17:00:00', 100.00, TRUE, 'Mergulho, trilhas, praias, restaurantes', 5.0, '(81)3619-1111', 'https://www.noronha.pe.gov.br', 'info@noronha.pe.gov.br', 'Praia e Natureza' );
CALL Adicionar_Ponto_Turistico( 'Região de serras, vales, cachoeiras e grutas', 'Chapada Diamantina', 'Bahia', 'Lençóis', 'Centro', 46960000, '07:00:00', '07:00:00', '18:00:00', '18:00:00', 0.00, TRUE, 'Trilhas, cachoeiras, grutas, guias', 4.9, '(75)3334-1111', 'https://www.chapadadiamantina.com.br', 'contato@chapadadiamantina.com.br', 'Natureza e Aventura' );
CALL Adicionar_Ponto_Turistico( 'Vila charmosa com praias, piscinas naturais e recifes', 'Porto de Galinhas', 'Pernambuco', 'Ipojuca', 'Porto de Galinhas', 55590000, '08:00:00', '08:00:00', '20:00:00', '20:00:00', 0.00, TRUE, 'Piscinas naturais, jangadas, restaurantes, artesanato', 4.7, '(81)3552-1111', 'https://www.portodegalinhas.com.br', 'info@portodegalinhas.com.br', 'Praia e Lazer' );
CALL Adicionar_Ponto_Turistico( 'Praias de águas cristalinas e coqueiros', 'Maragogi', 'Alagoas', 'Maragogi', 'Centro', 57955000, '07:00:00', '07:00:00', '18:00:00', '18:00:00', 0.00, TRUE, 'Piscinas naturais, mergulho, passeios de catamarã', 4.6, '(82)3296-1111', 'https://www.maragogi.al.gov.br', 'turismo@maragogi.al.gov.br', 'Praia e Natureza' );
CALL Adicionar_Ponto_Turistico( 'Centro histórico colonial e praias urbanas', 'Salvador', 'Bahia', 'Salvador', 'Pelourinho', 40020000, '09:00:00', '09:00:00', '22:00:00', '22:00:00', 0.00, TRUE, 'Pelourinho, Elevador Lacerda, Farol da Barra, culinária', 4.8, '(71)3176-1111', 'https://www.salvador.ba.gov.br', 'turismo@salvador.ba.gov.br', 'Cultura e História' );
CALL Adicionar_Ponto_Turistico( 'Praias urbanas e piscinas naturais', 'Maceió', 'Alagoas', 'Maceió', 'Ponta Verde', 57035000, '08:00:00', '08:00:00', '20:00:00', '20:00:00', 0.00, TRUE, 'Ponta Verde, Pajuçara, Gunga, culinária', 4.7, '(82)3315-1111', 'https://www.maceio.al.gov.br', 'turismo@maceio.al.gov.br', 'Praia e Lazer' );
CALL Adicionar_Ponto_Turistico( 'Capital com praias urbanas e dunas', 'Natal', 'Rio Grande do Norte', 'Natal', 'Ponta Negra', 59090000, '07:00:00', '07:00:00', '22:00:00', '22:00:00', 0.00, TRUE, 'Ponta Negra, Dunas de Genipabu, Forte dos Reis Magos', 4.6, '(84)3232-1111', 'https://www.natal.rn.gov.br', 'turismo@natal.rn.gov.br', 'Praia e Aventura' );
CALL Adicionar_Ponto_Turistico( 'Cidade histórica com praias e arquitetura colonial', 'João Pessoa', 'Paraíba', 'João Pessoa', 'Tambau', 58039000, '08:00:00', '08:00:00', '20:00:00', '20:00:00', 0.00, TRUE, 'Praia de Tambaú, Farol do Cabo Branco, Centro Histórico', 4.5, '(83)3218-1111', 'https://www.joaopessoa.pb.gov.br', 'turismo@joaopessoa.pb.gov.br', 'Praia e Cultura' );
CALL Adicionar_Ponto_Turistico( 'Praias de águas claras e coqueirais', 'Porto Seguro', 'Bahia', 'Porto Seguro', 'Centro', 45810000, '08:00:00', '08:00:00', '22:00:00', '22:00:00', 0.00, TRUE, 'Passarela do Descobrimento, praias, Arraial dAjuda, Trancoso', 4.6, '(73)3288-1111', 'https://www.portoseguro.ba.gov.br', 'turismo@portoseguro.ba.gov.br', 'Praia e História' );
CALL Adicionar_Ponto_Turistico( 'Praia famosa por suas falésias coloridas e jangadas', 'Canoa Quebrada', 'Ceará', 'Aracati', 'Canoa Quebrada', 62800000, '07:00:00', '07:00:00', '23:00:00', '23:00:00', 0.00, TRUE, 'Falésias, passeios de buggy, parapente, vida noturna', 4.5, '(88)3421-1111', 'https://www.canoaquebrada.com.br', 'contato@canoaquebrada.com.br', 'Praia e Aventura' );
CALL Adicionar_Ponto_Turistico( 'Vila charmosa com praias, trilhas e mirantes', 'Morro de São Paulo', 'Bahia', 'Cairu', 'Morro de São Paulo', 45428000, '08:00:00', '08:00:00', '22:00:00', '22:00:00', 0.00, TRUE, 'Praias, tirolesa, farol, vida noturna', 4.7, '(75)3652-1111', 'https://www.morrodesaopaulo.com.br', 'info@morrodesaopaulo.com.br', 'Praia e Lazer' );
CALL Adicionar_Ponto_Turistico( 'Parque Nacional com formações rochosas e sítios arqueológicos', 'Serra da Capivara', 'Piauí', 'São Raimundo Nonato', 'Zona Rural', 64770000, '08:00:00', '08:00:00', '17:00:00', '17:00:00', 0.00, TRUE, 'Sítios arqueológicos, pinturas rupestres, museu', 4.9, '(89)3582-1111', 'https://www.icmbio.gov.br/serradacapivara', 'serradacapivara@icmbio.gov.br', 'História e Natureza' );
CALL Adicionar_Ponto_Turistico( 'Praia urbana com recifes e piscinas naturais', 'Praia do Futuro', 'Ceará', 'Fortaleza', 'Praia do Futuro', 60180000, '08:00:00', '08:00:00', '22:00:00', '22:00:00', 0.00, TRUE, 'Barracas de praia, caranguejo, shows ao vivo', 4.3, '(85)3456-1111', 'https://www.fortaleza.ce.gov.br', 'turismo@fortaleza.ce.gov.br', 'Praia e Lazer' );
CALL Adicionar_Ponto_Turistico('Praia com falésias e areia branca', 'Praia do Gunga', 'Alagoas', 'Roteiro', 'Praia do Gunga', 57246000, '08:00:00', '08:00:00', '17:00:00', '17:00:00', 0.00, TRUE, 'Passeios de buggy, quadriciclo, restaurantes', 4.8, '(82) 3272-1111', 'https://www.praiadogunga.com.br', 'contato@praiadogunga.com.br', 'Praia e Lazer');
CALL Adicionar_Ponto_Turistico("Cidade histórica com casario colonial", "Piranhas", "Alagoas", "Piranhas", "Centro Histórico", 57460000, "09:00:00", "09:00:00", "18:00:00", "18:00:00", 0.00, TRUE, "Passeios de catamarã, museu, artesanato", 4.7, "(82) 3686-1111", "https://www.piranhas.al.gov.br", "turismo@piranhas.al.gov.br", "História e Cultura");
CALL Adicionar_Ponto_Turistico("Praia tranquila com piscinas naturais", "São Miguel dos Milagres", "Alagoas", "São Miguel dos Milagres", "Praia do Toque", 57940000, "08:00:00", "08:00:00", "18:00:00", "18:00:00", 0.00, TRUE, "Passeios de jangada, pousadas de charme, culinária local", 4.8, "(82) 3295-1111", "https://www.saomigueldosmilagres.al.gov.br", "turismo@saomigueldosmilagres.al.gov.br", "Praia e Lazer");
CALL Adicionar_Ponto_Turistico("Praia com grande faixa de areia e mar calmo", "Praia de Carneiros", "Pernambuco", "Tamandaré", "Praia dos Carneiros", 55578000, "08:00:00", "08:00:00", "17:00:00", "17:00:00", 0.00, TRUE, "Passeios de catamarã, igreja histórica, restaurantes", 4.9, "(81) 3676-1111", "https://www.praiadoscarneiros.com.br", "contato@praiadoscarneiros.com.br", "Praia e Lazer");
CALL Adicionar_Ponto_Turistico("Vila de pescadores com praias e dunas", "Itaúnas", "Espírito Santo", "Conceição da Barra", "Vila de Itaúnas", 29960000, "08:00:00", "08:00:00", "22:00:00", "22:00:00", 0.00, TRUE, "Forró, dunas, praias, parque estadual", 4.7, "(27) 3762-1111", "https://www.itaunas.com.br", "contato@itaunas.com.br", "Praia e Cultura");
CALL Adicionar_Ponto_Turistico("Praia com falésias e fontes de água doce", "Praia da Pipa", "Rio Grande do Norte", "Tibau do Sul", "Praia da Pipa", 59178000, "08:00:00", "08:00:00", "22:00:00", "22:00:00", 0.00, TRUE, "Passeios de barco, golfinhos, vida noturna, culinária", 4.8, "(84) 3246-1111", "https://www.pipa.com.br", "contato@pipa.com.br", "Praia e Aventura");
CALL Adicionar_Ponto_Turistico("Praia com dunas e coqueiros", "Mangue Seco", "Bahia", "Jandaíra", "Mangue Seco", 48310000, "08:00:00", "08:00:00", "17:00:00", "17:00:00", 0.00, TRUE, "Passeios de buggy, esquibunda, restaurantes", 4.6, "(75) 3447-1111", "https://www.mangueseco.com.br", "contato@mangueseco.com.br", "Praia e Aventura");
CALL Adicionar_Ponto_Turistico("Ilha com praias e vilarejos tranquilos", "Ilha de Boipeba", "Bahia", "Cairu", "Velha Boipeba", 45426000, "08:00:00", "08:00:00", "18:00:00", "18:00:00", 0.00, TRUE, "Piscinas naturais, trilhas, restaurantes", 4.8, "(75) 3653-1111", "https://www.ilhaboipeba.com.br", "contato@ilhaboipeba.com.br", "Praia e Natureza");
CALL Adicionar_Ponto_Turistico("Praias, rios e cachoeiras", "Itacaré", "Bahia", "Itacaré", "Centro", 45530000, "08:00:00", "08:00:00", "22:00:00", "22:00:00", 0.00, TRUE, "Surf, trilhas, cachoeiras, vida noturna", 4.7, "(73) 3251-1111", "https://www.itacare.com.br", "contato@itacare.com.br", "Praia e Aventura");
CALL Adicionar_Ponto_Turistico("Praia com resorts e complexos de lazer", "Costa do Sauípe", "Bahia", "Mata de São João", "Costa do Sauípe", 48280000, "09:00:00", "09:00:00", "23:00:00", "23:00:00", 0.00, TRUE, "Resorts, golfe, spa, shows", 4.5, "(71) 2104-1111", "https://www.costadosauipe.com.br", "contato@costadosauipe.com.br", "Praia e Lazer");
CALL Adicionar_Ponto_Turistico("Vila de pescadores com praias e recifes", "Barra Grande", "Piauí", "Cajueiro da Praia", "Barra Grande", 64222000, "08:00:00", "08:00:00", "20:00:00", "20:00:00", 0.00, TRUE, "Kitesurf, passeios de barco, culinária local", 4.7, "(86) 3369-1111", "https://www.barragrande.com.br", "contato@barragrande.com.br", "Praia e Aventura");
CALL Adicionar_Ponto_Turistico("Praia com piscinas naturais e falésias", "Taipu de Fora", "Bahia", "Maraú", "Taipu de Fora", 45520000, "08:00:00", "08:00:00", "18:00:00", "18:00:00", 0.00, TRUE, "Piscinas naturais, mergulho, quadriciclo", 4.8, "(73) 3258-1111", "https://www.taipudefora.com.br", "contato@taipudefora.com.br", "Praia e Natureza");
CALL Adicionar_Ponto_Turistico("Delta do único rio das Américas que deságua em mar aberto", "Delta do Parnaíba", "Piauí", "Parnaíba", "Delta do Parnaíba", 64200000, "08:00:00", "08:00:00", "17:00:00", "17:00:00", 0.00, TRUE, "Passeios de barco, observação de animais, dunas", 4.9, "(86) 3321-1111", "https://www.deltadoparnaiba.com.br", "contato@deltadoparnaiba.com.br", "Natureza e Aventura");
CALL Adicionar_Ponto_Turistico("Parque aquático com toboáguas e piscinas", "Beach Park", "Ceará", "Aquiraz", "Porto das Dunas", 61700000, "11:00:00", "11:00:00", "17:00:00", "17:00:00", 250.00, TRUE, "Toboáguas, piscinas, restaurantes, resorts", 4.7, "(85) 4012-1111", "https://www.beachpark.com.br", "contato@beachpark.com.br", "Lazer e Diversão");
CALL Adicionar_Ponto_Turistico("Praia com falésias avermelhadas e fontes de água doce", "Praia de Lagoinha", "Ceará", "Paraipaba", "Lagoinha", 62685000, "08:00:00", "08:00:00", "17:00:00", "17:00:00", 0.00, TRUE, "Passeios de buggy, catamarã, esquibunda", 4.6, "(85) 3368-1111", "https://www.lagoinha.com.br", "contato@lagoinha.com.br", "Praia e Aventura");
CALL Adicionar_Ponto_Turistico("Praia com dunas, coqueiros e mar calmo", "Praia do Preá", "Ceará", "Cruz", "Praia do Preá", 62595000, "08:00:00", "08:00:00", "18:00:00", "18:00:00", 0.00, TRUE, "Kitesurf, pousadas, restaurantes", 4.5, "(88) 3660-1111", "https://www.praiadoprea.com.br", "contato@praiadoprea.com.br", "Praia e Aventura");
CALL Adicionar_Ponto_Turistico("Praia com piscinas naturais e recifes de corais", "Praia do Patacho", "Alagoas", "Porto de Pedras", "Praia do Patacho", 57945000, "08:00:00", "08:00:00", "17:00:00", "17:00:00", 0.00, TRUE, "Piscinas naturais, pousadas de charme, tranquilidade", 4.9, "(82) 3298-1111", "https://www.praiadopatacho.com.br", "contato@praiadopatacho.com.br", "Praia e Lazer");
CALL Adicionar_Ponto_Turistico("Praia com falésias e mar agitado", "Praia do Amor", "Rio Grande do Norte", "Tibau do Sul", "Praia da Pipa", 59178000, "08:00:00", "08:00:00", "18:00:00", "18:00:00", 0.00, TRUE, "Surf, barracas de praia, mirante", 4.7, "(84) 3246-1112", "https://www.pipa.com.br/praia-do-amor", "contato@pipa.com.br", "Praia e Aventura");
CALL Adicionar_Ponto_Turistico("Praia com dunas e lagoas", "Praia de Genipabu", "Rio Grande do Norte", "Extremoz", "Genipabu", 59575000, "08:00:00", "08:00:00", "17:00:00", "17:00:00", 0.00, TRUE, "Passeios de buggy, dromedários, esquibunda", 4.6, "(84) 3225-1111", "https://www.genipabu.com.br", "contato@genipabu.com.br", "Praia e Aventura");
CALL Adicionar_Ponto_Turistico("Praia com piscinas naturais e recifes", "Parrachos de Maracajaú", "Rio Grande do Norte", "Maxaranguape", "Maracajaú", 59580000, "09:00:00", "09:00:00", "16:00:00", "16:00:00", 0.00, TRUE, "Mergulho, passeios de catamarã, restaurantes", 4.8, "(84) 3262-1111", "https://www.maracajau.com.br", "contato@maracajau.com.br", "Praia e Natureza");
CALL Adicionar_Ponto_Turistico("Vila de pescadores com praias desertas", "São Miguel do Gostoso", "Rio Grande do Norte", "São Miguel do Gostoso", "Centro", 59585000, "08:00:00", "08:00:00", "20:00:00", "20:00:00", 0.00, TRUE, "Kitesurf, windsurf, pousadas, restaurantes", 4.7, "(84) 3263-1111", "https://www.saomigueldogostoso.com.br", "contato@saomigueldogostoso.com.br", "Praia e Aventura");
CALL Adicionar_Ponto_Turistico("Praia de nudismo e falésias", "Praia de Tambaba", "Paraíba", "Conde", "Tambaba", 58322000, "08:00:00", "08:00:00", "17:00:00", "17:00:00", 0.00, TRUE, "Nudismo, mirante, pousadas", 4.5, "(83) 3298-1111", "https://www.tambaba.com.br", "contato@tambaba.com.br", "Praia e Natureza");
CALL Adicionar_Ponto_Turistico("Praia com areia avermelhada e falésias", "Praia de Coqueirinho", "Paraíba", "Conde", "Coqueirinho", 58322000, "08:00:00", "08:00:00", "17:00:00", "17:00:00", 0.00, TRUE, "Mirante, restaurantes, passeios de buggy", 4.6, "(83) 3298-1112", "https://www.praiadecoqueirinho.com.br", "contato@praiadecoqueirinho.com.br", "Praia e Lazer");
CALL Adicionar_Ponto_Turistico("Ilha com ruínas de uma prisão e praias", "Ilha de Itamaracá", "Pernambuco", "Itamaracá", "Vila Velha", 53900000, "09:00:00", "09:00:00", "17:00:00", "17:00:00", 0.00, TRUE, "Forte Orange, praias, Ecoparque Peixe-Boi", 4.4, "(81) 3544-1111", "https://www.itamaraca.pe.gov.br", "turismo@itamaraca.pe.gov.br", "Praia e História");
CALL Adicionar_Ponto_Turistico("Cidade histórica com ladeiras e igrejas barrocas", "Olinda", "Pernambuco", "Olinda", "Sítio Histórico", 53120000, "09:00:00", "09:00:00", "18:00:00", "18:00:00", 0.00, TRUE, "Igrejas, mirantes, ateliês, carnaval", 4.8, "(81) 3429-1111", "https://www.olinda.pe.gov.br", "turismo@olinda.pe.gov.br", "Cultura e História");
CALL Adicionar_Ponto_Turistico("Instituto de arte contemporânea com jardins e galerias", "Instituto Ricardo Brennand", "Pernambuco", "Recife", "Várzea", 50741900, "13:00:00", "13:00:00", "17:00:00", "17:00:00", 40.00, TRUE, "Castelo, pinacoteca, jardins, restaurante", 4.9, "(81) 2121-1111", "https://www.institutoricardobrennand.org.br", "contato@institutoricardobrennand.org.br", "Cultura e Arte");
CALL Adicionar_Ponto_Turistico("Bairro histórico com pontes e casarões", "Recife Antigo", "Pernambuco", "Recife", "Recife", 50030000, "09:00:00", "09:00:00", "22:00:00", "22:00:00", 0.00, TRUE, "Embaixada dos Bonecos Gigantes, Paço do Frevo, Rua do Bom Jesus", 4.7, "(81) 3355-1111", "https://www.recife.pe.gov.br", "turismo@recife.pe.gov.br", "Cultura e História");
CALL Adicionar_Ponto_Turistico("Praia com piscinas naturais e coqueiros", "Praia dos Carneiros", "Pernambuco", "Tamandaré", "Praia dos Carneiros", 55578000, "08:00:00", "08:00:00", "17:00:00", "17:00:00", 0.00, TRUE, "Passeios de catamarã, igreja histórica, restaurantes", 4.9, "(81) 3676-1111", "https://www.praiadoscarneiros.com.br", "contato@praiadoscarneiros.com.br", "Praia e Lazer");
CALL Adicionar_Ponto_Turistico("Santuário de vida marinha e projeto de conservação de tartarugas", "Projeto Tamar", "Bahia", "Mata de São João", "Praia do Forte", 48280000, "09:00:00", "09:00:00", "17:30:00", "17:30:00", 30.00, TRUE, "Tanques de observação, museu, loja", 4.8, "(71) 3676-1111", "https://www.tamar.org.br", "contato@tamar.org.br", "Natureza e Ecologia");
CALL Adicionar_Ponto_Turistico("Vila charmosa com praias e lojas de grife", "Trancoso", "Bahia", "Porto Seguro", "Trancoso", 45818000, "09:00:00", "09:00:00", "23:00:00", "23:00:00", 0.00, TRUE, "Quadrado, praias, restaurantes, lojas", 4.7, "(73) 3668-1111", "https://www.trancoso.com.br", "contato@trancoso.com.br", "Praia e Lazer");
CALL Adicionar_Ponto_Turistico("Praia com falésias e espelhos d'água na maré baixa", "Praia do Espelho", "Bahia", "Porto Seguro", "Caraíva", 45819000, "08:00:00", "08:00:00", "17:00:00", "17:00:00", 0.00, TRUE, "Piscinas naturais, restaurantes, pousadas", 4.8, "(73) 3668-1112", "https://www.praiadoespelho.com.br", "contato@praiadoespelho.com.br", "Praia e Natureza");
CALL Adicionar_Ponto_Turistico("Vila rústica com ruas de areia e praias", "Caraíva", "Bahia", "Porto Seguro", "Caraíva", 45819000, "08:00:00", "08:00:00", "22:00:00", "22:00:00", 0.00, TRUE, "Rio Caraíva, forró, restaurantes", 4.7, "(73) 3668-1113", "https://www.caraiva.com.br", "contato@caraiva.com.br", "Praia e Cultura");
CALL Adicionar_Ponto_Turistico("Parque nacional marinho com recifes de corais e rica biodiversidade", "Parque Nacional Marinho de Abrolhos", "Bahia", "Caravelas", "Arquipélago de Abrolhos", 45900000, "08:00:00", "08:00:00", "17:00:00", "17:00:00", 0.00, TRUE, "Mergulho, observação de baleias, passeios de barco", 4.9, "(73) 3297-1111", "https://www.icmbio.gov.br/parnaabrolhos", "parnaabrolhos@icmbio.gov.br", "Natureza e Ecologia");
CALL Adicionar_Ponto_Turistico("Cânion com vegetação de caatinga e passeios de catamarã", "Cânion do Xingó", "Sergipe", "Canindé de São Francisco", "Rio São Francisco", 49820000, "09:00:00", "09:00:00", "17:00:00", "17:00:00", 0.00, TRUE, "Passeios de catamarã, mergulho, restaurante flutuante", 4.8, "(79) 3346-1111", "https://www.caniondoxingo.com.br", "contato@caniondoxingo.com.br", "Natureza e Aventura");
CALL Adicionar_Ponto_Turistico("Cidade histórica com praças e igrejas coloniais", "São Cristóvão", "Sergipe", "São Cristóvão", "Centro Histórico", 49100000, "09:00:00", "09:00:00", "17:00:00", "17:00:00", 0.00, TRUE, "Praça São Francisco, igrejas, museus", 4.7, "(79) 3261-1111", "https://www.saocristovao.se.gov.br", "turismo@saocristovao.se.gov.br", "Cultura e História");
CALL Adicionar_Ponto_Turistico("Praia urbana com extensa faixa de areia e calçadão", "Praia de Atalaia", "Sergipe", "Aracaju", "Atalaia", 49035000, "08:00:00", "08:00:00", "22:00:00", "22:00:00", 0.00, TRUE, "Oceanário, Passarela do Caranguejo, lagos", 4.6, "(79) 3243-1111", "https://www.aracaju.se.gov.br", "turismo@aracaju.se.gov.br", "Praia e Lazer");
CALL Adicionar_Ponto_Turistico("Foz do rio São Francisco com dunas e praias", "Foz do Rio São Francisco", "Alagoas", "Piaçabuçu", "Foz do São Francisco", 57210000, "08:00:00", "08:00:00", "17:00:00", "17:00:00", 0.00, TRUE, "Passeios de barco, dunas, farol", 4.7, "(82) 3552-1111", "https://www.fozdosaofrancisco.com.br", "contato@fozdosaofrancisco.com.br", "Natureza e Aventura");
CALL Adicionar_Ponto_Turistico("Praia com falésias e areia colorida", "Morro Branco", "Ceará", "Beberibe", "Morro Branco", 62840000, "08:00:00", "08:00:00", "17:00:00", "17:00:00", 0.00, TRUE, "Labirinto das Falésias, passeios de buggy, artesanato de areia", 4.7, "(85) 3327-1111", "https://www.morrobranco.com.br", "contato@morrobranco.com.br", "Praia e Aventura");
CALL Adicionar_Ponto_Turistico("Praia com fontes de água doce e dunas", "Praia das Fontes", "Ceará", "Beberibe", "Praia das Fontes", 62840000, "08:00:00", "08:00:00", "17:00:00", "17:00:00", 0.00, TRUE, "Gruta da Mãe d'Água, fontes, passeios de buggy", 4.6, "(85) 3327-1112", "https://www.praiadasfontes.com.br", "contato@praiadasfontes.com.br", "Praia e Natureza");
CALL Adicionar_Ponto_Turistico("Cidade serrana com clima ameno e festival de jazz e blues", "Guaramiranga", "Ceará", "Guaramiranga", "Centro", 62766000, "09:00:00", "09:00:00", "20:00:00", "20:00:00", 0.00, TRUE, "Mosteiro dos Jesuítas, Pico Alto, cachoeiras", 4.5, "(85) 3321-1111", "https://www.guaramiranga.ce.gov.br", "turismo@guaramiranga.ce.gov.br", "Serra e Cultura");
CALL Adicionar_Ponto_Turistico("Sítio arqueológico com inscrições rupestres", "Vale dos Dinossauros", "Paraíba", "Sousa", "Sítio Arqueológico", 58800000, "08:00:00", "08:00:00", "17:00:00", "17:00:00", 0.00, TRUE, "Pegadas de dinossauros, museu, trilhas", 4.6, "(83) 3522-1111", "https://www.valedosdinossauros.com.br", "contato@valedosdinossauros.com.br", "História e Natureza");
CALL Adicionar_Ponto_Turistico("Pedra com formato de boca e inscrições rupestres", "Pedra da Boca", "Paraíba", "Araruna", "Parque Estadual", 58233000, "08:00:00", "08:00:00", "17:00:00", "17:00:00", 0.00, TRUE, "Trilhas, rapel, inscrições rupestres", 4.7, "(83) 3373-1111", "https://www.pedradaboca.com.br", "contato@pedradaboca.com.br", "Natureza e Aventura");
CALL Adicionar_Ponto_Turistico("Cidade com o maior São João do mundo", "Campina Grande", "Paraíba", "Campina Grande", "Parque do Povo", 58400000, "18:00:00", "18:00:00", "04:00:00", "04:00:00", 0.00, TRUE, "Shows, quadrilhas, comidas típicas", 4.8, "(83) 3310-1111", "https://www.campinagrande.pb.gov.br", "turismo@campinagrande.pb.gov.br", "Cultura e Festa");
CALL Adicionar_Ponto_Turistico("Cidade com vinícolas e produção de vinhos", "Vale do São Francisco", "Pernambuco", "Petrolina", "Vale do São Francisco", 56300000, "09:00:00", "09:00:00", "17:00:00", "17:00:00", 0.00, TRUE, "Vinícolas, passeios de barco, culinária", 4.6, "(87) 3861-1111", "https://www.valedosaofrancisco.com.br", "contato@valedosaofrancisco.com.br", "Gastronomia e Vinho");
CALL Adicionar_Ponto_Turistico("Arquipélago com praias e natureza preservada", "Arquipélago de Tinharé", "Bahia", "Cairu", "Morro de São Paulo", 45428000, "08:00:00", "08:00:00", "22:00:00", "22:00:00", 0.00, TRUE, "Praias, trilhas, vida noturna", 4.7, "(75) 3652-1111", "https://www.arquipelagodetinhare.com.br", "contato@arquipelagodetinhare.com.br", "Praia e Natureza");
CALL Adicionar_Ponto_Turistico("Praia urbana com barracas e vida noturna", "Praia de Iracema", "Ceará", "Fortaleza", "Praia de Iracema", 60060000, "08:00:00", "08:00:00", "23:00:00", "23:00:00", 0.00, TRUE, "Ponte dos Ingleses, Centro Dragão do Mar, bares", 4.4, "(85) 3456-1112", "https://www.fortaleza.ce.gov.br/praia-de-iracema", "turismo@fortaleza.ce.gov.br", "Praia e Cultura");
CALL Adicionar_Ponto_Turistico("Mercado de artesanato com produtos locais", "Mercado Central de Fortaleza", "Ceará", "Fortaleza", "Centro", 60055000, "08:00:00", "08:00:00", "18:00:00", "18:00:00", 0.00, TRUE, "Artesanato, roupas, castanhas", 4.5, "(85) 3454-1111", "https://www.mercadocentralfortaleza.com.br", "contato@mercadocentralfortaleza.com.br", "Compras e Cultura");
CALL Adicionar_Ponto_Turistico("Teatro em estilo art nouveau com rica programação cultural", "Theatro José de Alencar", "Ceará", "Fortaleza", "Centro", 60055000, "09:00:00", "09:00:00", "21:00:00", "21:00:00", 10.00, TRUE, "Visitas guiadas, espetáculos, jardins", 4.8, "(85) 3101-1111", "https://www.theatrojosedealencar.ce.gov.br", "contato@theatrojosedealencar.ce.gov.br", "Cultura e Arte");
CALL Adicionar_Ponto_Turistico("Parque urbano com áreas verdes e equipamentos de lazer", "Parque da Sementeira", "Sergipe", "Aracaju", "Jardins", 49025000, "05:00:00", "05:00:00", "21:00:00", "21:00:00", 0.00, TRUE, "Pista de caminhada, quadras, lago", 4.6, "(79) 3179-1111", "https://www.aracaju.se.gov.br/parque-da-sementeira", "turismo@aracaju.se.gov.br", "Lazer e Natureza");
CALL Adicionar_Ponto_Turistico("Museu interativo sobre a cultura e história do povo sergipano", "Museu da Gente Sergipana", "Sergipe", "Aracaju", "Centro", 49010000, "10:00:00", "10:00:00", "18:00:00", "18:00:00", 0.00, TRUE, "Instalações interativas, exposições, café", 4.8, "(79) 3218-1111", "https://www.museudagentesergipana.com.br", "contato@museudagentesergipana.com.br", "Cultura e História");
CALL Adicionar_Ponto_Turistico("Centro histórico com casarões e igrejas coloniais", "Centro Histórico de São Luís", "Maranhão", "São Luís", "Centro", 65010000, "09:00:00", "09:00:00", "20:00:00", "20:00:00", 0.00, TRUE, "Casarões azulejados, igrejas, museus, reggae", 4.7, "(98) 3212-1111", "https://www.saoluis.ma.gov.br", "turismo@saoluis.ma.gov.br", "Cultura e História");
CALL Adicionar_Ponto_Turistico("Cidade com cachoeiras, poços e trilhas", "Chapada das Mesas", "Maranhão", "Carolina", "Chapada das Mesas", 65980000, "08:00:00", "08:00:00", "17:00:00", "17:00:00", 0.00, TRUE, "Cachoeiras, poços, trilhas, rapel", 4.8, "(99) 3531-1111", "https://www.chapadasmesas.com.br", "contato@chapadasmesas.com.br", "Natureza e Aventura");
CALL Adicionar_Ponto_Turistico("Cidade histórica com casario colonial e festival de cinema", "Penedo", "Alagoas", "Penedo", "Centro Histórico", 57200000, "09:00:00", "09:00:00", "18:00:00", "18:00:00", 0.00, TRUE, "Igrejas, convento, museus, festival de cinema", 4.6, "(82) 3551-1111", "https://www.penedo.al.gov.br", "turismo@penedo.al.gov.br", "Cultura e História");
CALL Adicionar_Ponto_Turistico("Praia com coqueiros e mar calmo, ideal para famílias", "Praia de Ipioca", "Alagoas", "Maceió", "Ipioca", 57039000, "08:00:00", "08:00:00", "17:00:00", "17:00:00", 0.00, TRUE, "Barracas de praia, piscinas naturais, tranquilidade", 4.5, "(82) 3315-1112", "https://www.maceio.al.gov.br/praia-de-ipioca", "turismo@maceio.al.gov.br", "Praia e Lazer");
CALL Adicionar_Ponto_Turistico("Praia com falésias e mar agitado, ideal para surf", "Praia de Stella Maris", "Bahia", "Salvador", "Stella Maris", 41600000, "08:00:00", "08:00:00", "18:00:00", "18:00:00", 0.00, TRUE, "Surf, barracas de praia, resorts", 4.4, "(71) 3176-1112", "https://www.salvador.ba.gov.br/praia-de-stella-maris", "turismo@salvador.ba.gov.br", "Praia e Aventura");
CALL Adicionar_Ponto_Turistico("Praia com piscinas naturais e coqueiros", "Praia do Forte", "Bahia", "Mata de São João", "Praia do Forte", 48280000, "08:00:00", "08:00:00", "18:00:00", "18:00:00", 0.00, TRUE, "Projeto Tamar, castelo, restaurantes", 4.7, "(71) 3676-1111", "https://www.praiadoforte.com.br", "contato@praiadoforte.com.br", "Praia e Natureza");
CALL Adicionar_Ponto_Turistico("Cidade histórica com igrejas e museus", "Cachoeira", "Bahia", "Cachoeira", "Centro Histórico", 44300000, "09:00:00", "09:00:00", "17:00:00", "17:00:00", 0.00, TRUE, "Igrejas, museus, casas coloniais", 4.6, "(75) 3425-1111", "https://www.cachoeira.ba.gov.br", "turismo@cachoeira.ba.gov.br", "Cultura e História");
CALL Adicionar_Ponto_Turistico("Praia com dunas e lagoas, ideal para esportes aquáticos", "Praia do Cumbuco", "Ceará", "Caucaia", "Cumbuco", 61600000, "08:00:00", "08:00:00", "18:00:00", "18:00:00", 0.00, TRUE, "Kitesurf, windsurf, passeios de buggy", 4.5, "(85) 3318-1111", "https://www.cumbuco.com.br", "contato@cumbuco.com.br", "Praia e Aventura");
CALL Adicionar_Ponto_Turistico("Praia com piscinas naturais e coqueiros", "Praia de Muro Alto", "Pernambuco", "Ipojuca", "Muro Alto", 55590000, "08:00:00", "08:00:00", "17:00:00", "17:00:00", 0.00, TRUE, "Piscinas naturais, resorts, esportes aquáticos", 4.7, "(81) 3552-1112", "https://www.muroalto.com.br", "contato@muroalto.com.br", "Praia e Lazer");
CALL Adicionar_Ponto_Turistico("Praia com mar calmo e coqueiros", "Praia de Calhetas", "Pernambuco", "Cabo de Santo Agostinho", "Calhetas", 54590000, "08:00:00", "08:00:00", "17:00:00", "17:00:00", 0.00, TRUE, "Tirolesa, restaurantes, mergulho", 4.6, "(81) 3518-1111", "https://www.calhetas.com.br", "contato@calhetas.com.br", "Praia e Aventura");
CALL Adicionar_Ponto_Turistico("Praia com falésias e mar calmo, ideal para famílias", "Praia do Saco", "Sergipe", "Estância", "Praia do Saco", 49200000, "08:00:00", "08:00:00", "17:00:00", "17:00:00", 0.00, TRUE, "Passeios de buggy, restaurantes, coqueiros", 4.5, "(79) 3522-1111", "https://www.praiadosaco.com.br", "contato@praiadosaco.com.br", "Praia e Lazer");
CALL Adicionar_Ponto_Turistico("Praia com piscinas naturais e coqueiros", "Praia do Francês", "Alagoas", "Marechal Deodoro", "Praia do Francês", 57160000, "08:00:00", "08:00:00", "18:00:00", "18:00:00", 0.00, TRUE, "Surf, piscinas naturais, restaurantes", 4.6, "(82) 3260-1111", "https://www.praiadoforof.com.br", "contato@praiadoforof.com.br", "Praia e Lazer");
CALL Adicionar_Ponto_Turistico("Praia com dunas e lagoas, ideal para kitesurf", "Praia da Barra Nova", "Ceará", "Cascavel", "Barra Nova", 62850000, "08:00:00", "08:00:00", "18:00:00", "18:00:00", 0.00, TRUE, "Kitesurf, passeios de buggy, lagoas", 4.4, "(85) 3334-1111", "https://www.barranova.com.br", "contato@barranova.com.br", "Praia e Aventura");
CALL Adicionar_Ponto_Turistico("Praia com falésias e mar agitado", "Praia de Canoa Quebrada", "Ceará", "Aracati", "Canoa Quebrada", 62800000, "08:00:00", "08:00:00", "22:00:00", "22:00:00", 0.00, TRUE, "Passeios de buggy, parapente, vida noturna", 4.7, "(88) 3421-1111", "https://www.canoaquebrada.com.br", "contato@canoaquebrada.com.br", "Praia e Aventura");
CALL Adicionar_Ponto_Turistico("Praia com piscinas naturais e coqueiros", "Praia de Pajuçara", "Alagoas", "Maceió", "Pajuçara", 57030000, "08:00:00", "08:00:00", "18:00:00", "18:00:00", 0.00, TRUE, "Jangadas, piscinas naturais, artesanato", 4.6, "(82) 3315-1113", "https://www.maceio.al.gov.br/pajucara", "turismo@maceio.al.gov.br", "Praia e Lazer");
CALL Adicionar_Ponto_Turistico("Praia com falésias e mar calmo", "Praia de Ponta Verde", "Alagoas", "Maceió", "Ponta Verde", 57035000, "08:00:00", "08:00:00", "18:00:00", "18:00:00", 0.00, TRUE, "Coqueiros, calçadão, restaurantes", 4.7, "(82) 3315-1114", "https://www.maceio.al.gov.br/ponta-verde", "turismo@maceio.al.gov.br", "Praia e Lazer");
CALL Adicionar_Ponto_Turistico("Praia com arrecifes e piscinas naturais", "Praia de Japaratinga", "Alagoas", "Japaratinga", "Japaratinga", 57950000, "08:00:00", "08:00:00", "17:00:00", "17:00:00", 0.00, TRUE, "Piscinas naturais, tranquilidade, pousadas", 4.8, "(82) 3297-1111", "https://www.japaratinga.al.gov.br", "turismo@japaratinga.al.gov.br", "Praia e Natureza");
CALL Adicionar_Ponto_Turistico("Praia com dunas e lagoas, ideal para esportes", "Praia de Tatajuba", "Ceará", "Camocim", "Tatajuba", 62400000, "08:00:00", "08:00:00", "17:00:00", "17:00:00", 0.00, TRUE, "Passeios de buggy, lagoa da Torta, windsurf", 4.6, "(88) 3621-1111", "https://www.tatajuba.com.br", "contato@tatajuba.com.br", "Praia e Aventura");
CALL Adicionar_Ponto_Turistico("Praia com falésias e mar agitado", "Praia do Morro Branco", "Ceará", "Beberibe", "Morro Branco", 62840000, "08:00:00", "08:00:00", "17:00:00", "17:00:00", 0.00, TRUE, "Labirinto das Falésias, artesanato de areia, passeios de buggy", 4.7, "(85) 3327-1111", "https://www.morrobranco.com.br", "contato@morrobranco.com.br", "Praia e Aventura");

# */