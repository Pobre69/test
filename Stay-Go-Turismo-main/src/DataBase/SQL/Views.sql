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

CREATE OR REPLACE VIEW Show_Citacoes_Referencias AS
SELECT * FROM Citacoes_Referencias;