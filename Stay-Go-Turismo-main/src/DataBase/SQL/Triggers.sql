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