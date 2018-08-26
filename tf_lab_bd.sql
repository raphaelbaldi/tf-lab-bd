-- CLEAN UP ANTES DE INICIAR A CRIAÇÃO DE TABELAS, COMEÇANDO PELAS FOLHAS
DROP TABLE TF_JOGOS;
DROP TABLE TF_JOGADORES;
DROP TABLE TF_TIMES;
DROP TABLE TF_CIDADES;
DROP TABLE TF_ESTADOS;

-- ESTADOS
CREATE TABLE TF_ESTADOS
(
   ID_ESTADO NUMBER (2) NOT NULL,
   NOME VARCHAR (50) NOT NULL,
   SIGLA VARCHAR (2) NOT NULL CHECK(LENGTH(SIGLA) = 2),
   REGIAO VARCHAR (20) NOT NULL CHECK (REGIAO IN ('NORTE', 'NORDESTE', 'SUL', 'SUDESTE', 'CENTRO-OESTE')),

   CONSTRAINT PK_TF_ESTADOS PRIMARY KEY (ID_ESTADO),
   CONSTRAINT AK1_TF_ESTADOS UNIQUE (NOME),
   CONSTRAINT AK2_TF_ESTADOS UNIQUE (SIGLA)
);

-- CIDADES
CREATE TABLE TF_CIDADES
(
   ID_CIDADE NUMBER (4) NOT NULL,
   NOME VARCHAR (50) NOT NULL,
   ID_ESTADO NUMBER (2) NOT NULL,
   DATA_FUNDACAO DATE NOT NULL,
   REGIAO VARCHAR (20) NOT NULL CHECK (REGIAO IN ('CAPITAL', 'INTERIOR', 'CAMPANHA', 'SERRA', 'LITORAL')),

   CONSTRAINT PK_TF_CIDADES PRIMARY KEY (ID_CIDADE),
   CONSTRAINT FK_CID_EST FOREIGN KEY (ID_ESTADO) REFERENCES TF_ESTADOS (ID_ESTADO)
);

-- TIMES
CREATE TABLE TF_TIMES
(
   ID_TIME NUMBER (3) NOT NULL,
   NOME VARCHAR (50) NOT NULL,
   ID_CIDADE NUMBER (4) NOT NULL,
   DATA_FUNDACAO DATE NOT NULL CHECK (DATA_FUNDACAO > DATE '1850-01-01'),
   TECNICO VARCHAR (50) NOT NULL,

   CONSTRAINT PK_TF_TIMES PRIMARY KEY (ID_TIME),
   CONSTRAINT AK_TF_TIMES UNIQUE (NOME),
   CONSTRAINT FK_TIMES_CID FOREIGN KEY (ID_CIDADE) REFERENCES TF_CIDADES (ID_CIDADE)
);

-- JOGADORES
CREATE TABLE TF_JOGADORES
(
   ID_JOGADOR NUMBER (5) NOT NULL,
   NOME VARCHAR (100) NOT NULL,
   DATA_NASCIMENTO DATE NOT NULL,
   ID_TIME NUMBER (2) NOT NULL,
   POSICAO VARCHAR (20) NOT NULL CHECK (POSICAO IN ('GOLEIRO', 'ZAGUEIRO', 'LATERAL', 'VOLANTE', 'ALA', 'MEIA-ARMADOR', 'CENTROAVANTE', 'ATACANTE')),
   ID_CIDADE_NASCIMENTO NUMBER (4) NOT NULL,

   CONSTRAINT PK_JOGADORES PRIMARY KEY (ID_JOGADOR),
   CONSTRAINT FK_JOGADORES_TIME FOREIGN KEY (ID_TIME) REFERENCES TF_TIMES (ID_TIME),
   CONSTRAINT FK_JOGADORES_CIDADE FOREIGN KEY (ID_CIDADE_NASCIMENTO) REFERENCES TF_CIDADES (ID_CIDADE)
);

-- JOGOS
CREATE TABLE TF_JOGOS
(
   ID_JOGO NUMBER (8) NOT NULL,
   ID_MANDANTE NUMBER (3) NOT NULL,
   GOLS_MANDANTE NUMBER (2) NOT NULL CHECK (GOLS_MANDANTE >= 0),
   ID_VISITANTE NUMBER (3) NOT NULL,
   GOLS_VISITANTE NUMBER (2) NOT NULL CHECK (GOLS_VISITANTE >= 0),
   DATA_JOGO DATE NOT NULL,

   CONSTRAINT PK_JOGOS PRIMARY KEY (ID_JOGO),
   CONSTRAINT FK_JOGOS_TIME1 FOREIGN KEY (ID_MANDANTE) REFERENCES TF_TIMES (ID_TIME),
   CONSTRAINT FK_JOGOS_TIME2 FOREIGN KEY (ID_VISITANTE) REFERENCES TF_TIMES (ID_TIME)
);

----------------------- INSERÇÃO DE DADOS ---------------------
-- ESTADOS
INSERT INTO TF_ESTADOS VALUES (1,    'ACRE',                'AC',    'NORTE');
INSERT INTO TF_ESTADOS VALUES (2,    'ALAGOAS',             'AL',    'NORDESTE');
INSERT INTO TF_ESTADOS VALUES (3,    'AMAPÁ',               'AP',    'NORTE');
INSERT INTO TF_ESTADOS VALUES (4,    'AMAZONAS',            'AM',    'NORTE');
INSERT INTO TF_ESTADOS VALUES (5,    'BAHIA',               'BA',    'NORDESTE');
INSERT INTO TF_ESTADOS VALUES (6,    'CEARÁ',               'CE',    'NORDESTE');
INSERT INTO TF_ESTADOS VALUES (7,    'DISTRITO FEDERAL',    'DF',    'CENTRO-OESTE');
INSERT INTO TF_ESTADOS VALUES (8,    'ESPÍRITO SANTO',      'ES',    'SUDESTE');
INSERT INTO TF_ESTADOS VALUES (9,    'GOIÁS',               'GO',    'CENTRO-OESTE');
INSERT INTO TF_ESTADOS VALUES (10,   'MARANHÃO',            'MA',    'NORDESTE');
INSERT INTO TF_ESTADOS VALUES (11,   'MATO GROSSO',         'MT',    'CENTRO-OESTE');
INSERT INTO TF_ESTADOS VALUES (12,   'MATO GROSSO DO SUL',  'MS',    'CENTRO-OESTE');
INSERT INTO TF_ESTADOS VALUES (13,   'MINAS GERAIS',        'MG',    'SUDESTE');
INSERT INTO TF_ESTADOS VALUES (14,   'PARÁ',                'PA',    'NORTE');
INSERT INTO TF_ESTADOS VALUES (15,   'PARAÍBA',             'PB',    'NORDESTE');
INSERT INTO TF_ESTADOS VALUES (16,   'PARANÁ',              'PR',    'SUL');
INSERT INTO TF_ESTADOS VALUES (17,   'PERNAMBUCO',          'PE',    'NORDESTE');
INSERT INTO TF_ESTADOS VALUES (18,   'PIAUÍ',               'PI',    'NORDESTE');
INSERT INTO TF_ESTADOS VALUES (19,   'RIO DE JANEIRO',      'RJ',    'SUDESTE');
INSERT INTO TF_ESTADOS VALUES (20,   'RIO GRANDE DO NORTE', 'RN',    'NORDESTE');
INSERT INTO TF_ESTADOS VALUES (21,   'RIO GRANDE DO SUL',   'RS',    'SUL');
INSERT INTO TF_ESTADOS VALUES (22,   'RONDÔNIA',            'RO',    'NORTE');
INSERT INTO TF_ESTADOS VALUES (23,   'RORAIMA',             'RR',    'NORTE');
INSERT INTO TF_ESTADOS VALUES (24,   'SANTA CATARINA',      'SC',    'SUL');
INSERT INTO TF_ESTADOS VALUES (25,   'SÃO PAULO',           'SP',    'SUDESTE');
INSERT INTO TF_ESTADOS VALUES (26,   'SERGIPE',             'SE',    'NORDESTE');
INSERT INTO TF_ESTADOS VALUES (27,   'TOCANTINS',           'TO',    'NORTE');

-- CIDADES
INSERT INTO TF_CIDADES VALUES (1,  'PORTO ALEGRE',          21,  DATE '1772-03-26',    'CAPITAL');
INSERT INTO TF_CIDADES VALUES (2,  'CAXIAS DO SUL',         21,  DATE '1890-06-20',    'SERRA');
INSERT INTO TF_CIDADES VALUES (3,  'NOVO HAMBURGO',         21,  DATE '1927-04-05',    'CAPITAL');
INSERT INTO TF_CIDADES VALUES (4,  'PELOTAS',               21,  DATE '1758-06-18',    'INTERIOR');
INSERT INTO TF_CIDADES VALUES (5,  'SANTA CRUZ DO SUL',     21,  DATE '1877-03-31',    'INTERIOR');
INSERT INTO TF_CIDADES VALUES (6,  'RIO DE JANEIRO',        19,  DATE '1565-03-01',    'CAPITAL');
INSERT INTO TF_CIDADES VALUES (7,  'SÃO PAULO',             25,  DATE '1554-01-25',    'CAPITAL');
INSERT INTO TF_CIDADES VALUES (8,  'SANTOS',                25,  DATE '1565-03-01',    'LITORAL');
INSERT INTO TF_CIDADES VALUES (9,  'BELO HORIZONTE',        13,  DATE '1897-12-12',    'CAPITAL');
INSERT INTO TF_CIDADES VALUES (10, 'CURITIBA',              16,  DATE '1693-03-29',    'CAPITAL');
INSERT INTO TF_CIDADES VALUES (11, 'SALVADOR',               5,  DATE '1549-03-29',    'CAPITAL');
INSERT INTO TF_CIDADES VALUES (12, 'CHAPECÓ',               24,  DATE '1917-08-25',    'INTERIOR');
INSERT INTO TF_CIDADES VALUES (13, 'RECIFE',                17,  DATE '1537-03-12',    'CAPITAL');
INSERT INTO TF_CIDADES VALUES (14, 'FORTALEZA',              6,  DATE '1726-04-13',    'CAPITAL');
INSERT INTO TF_CIDADES VALUES (15, 'RIO BRANCO',             1,  DATE '1882-12-28',    'CAPITAL');
INSERT INTO TF_CIDADES VALUES (16, 'MACEIÓ',                 2,  DATE '1815-12-05',    'CAPITAL');
INSERT INTO TF_CIDADES VALUES (17, 'MACAPÁ',                 3,  DATE '1758-02-04',    'CAPITAL');
INSERT INTO TF_CIDADES VALUES (18, 'MANAUS',                 4,  DATE '1669-10-24',    'CAPITAL');
INSERT INTO TF_CIDADES VALUES (19, 'BRASILIA',               7,  DATE '1960-04-21',    'CAPITAL');
INSERT INTO TF_CIDADES VALUES (20, 'VITÓRIA',                8,  DATE '1551-09-08',    'CAPITAL');
INSERT INTO TF_CIDADES VALUES (21, 'GOIÂNIA',                9,  DATE '1933-10-24',    'CAPITAL');
INSERT INTO TF_CIDADES VALUES (22, 'SÃO LUÍS',              10,  DATE '1612-09-08',    'CAPITAL');
INSERT INTO TF_CIDADES VALUES (23, 'CUIABÁ',                11,  DATE '1719-04-08',    'CAPITAL');
INSERT INTO TF_CIDADES VALUES (24, 'CAMPO GRANDE',          12,  DATE '1899-08-26',    'CAPITAL');
INSERT INTO TF_CIDADES VALUES (25, 'BELÉM',                 14,  DATE '1616-01-12',    'CAPITAL');
INSERT INTO TF_CIDADES VALUES (26, 'JOÃO PESSOA',           15,  DATE '1585-08-05',    'CAPITAL');
INSERT INTO TF_CIDADES VALUES (27, 'TERESINA',              18,  DATE '1852-08-16',    'CAPITAL');
INSERT INTO TF_CIDADES VALUES (28, 'NATAL',                 20,  DATE '1599-12-25',    'CAPITAL');
INSERT INTO TF_CIDADES VALUES (29, 'PORTO VELHO',           22,  DATE '1914-10-02',    'CAPITAL');
INSERT INTO TF_CIDADES VALUES (30, 'BOA VISTA',             23,  DATE '1890-08-01',    'CAPITAL');
INSERT INTO TF_CIDADES VALUES (31, 'ARACAJU',               26,  DATE '1855-03-17',    'CAPITAL');
INSERT INTO TF_CIDADES VALUES (32, 'PALMAS',                27,  DATE '1989-05-20',    'CAPITAL');
INSERT INTO TF_CIDADES VALUES (33, 'CAMPO BOM',             21,  DATE '1829-01-31',    'INTERIOR');
INSERT INTO TF_CIDADES VALUES (34, 'SÃO JOSÉ DO RIO PRETO', 25,  DATE '1852-03-19',    'INTERIOR');
INSERT INTO TF_CIDADES VALUES (35, 'VÁRZEA GRANDE',         11,  DATE '1867-05-15',    'INTERIOR');

-- TIMES
INSERT INTO TF_TIMES VALUES (1,  'CLUBE DE REGATAS DO FLAMENGO',             6,        DATE '1895-11-15', 'MAURÍCIO BARBIERI');
INSERT INTO TF_TIMES VALUES (2,  'GRÊMIO FOOT-BALL PORTO ALEGRENSE',         1,        DATE '1903-09-15', 'RENATO GAÚCHO');
INSERT INTO TF_TIMES VALUES (3,  'SOCIEDADE ESPORTIVA PALMEIRAS',            7,        DATE '1914-08-26', 'ROGER MACHADO');
INSERT INTO TF_TIMES VALUES (4,  'SPORT CLUB CORINTHIANS PAULISTA',          7,        DATE '1910-09-01', 'OSMAR LOSS');
INSERT INTO TF_TIMES VALUES (5,  'SANTOS FC',                                8,        DATE '1912-04-14', 'JAIR VENTURA');
INSERT INTO TF_TIMES VALUES (6,  'CLUB DE REGATAS VASCO DA GAMA',            6,        DATE '1898-08-21', 'JORGINHO');
INSERT INTO TF_TIMES VALUES (7,  'SÃO PAULO FUTEBOL CLUBE',                  7,        DATE '1935-12-16', 'DIEGO AGUIRRE');
INSERT INTO TF_TIMES VALUES (8,  'CRUZEIRO ESPORTE CLUBE',                   9,        DATE '1921-01-02', 'MANO MENEZES');
INSERT INTO TF_TIMES VALUES (9,  'SPORT CLUB INTERNACIONAL',                 1,        DATE '1909-04-04', 'ODAIR HELLMANN');
INSERT INTO TF_TIMES VALUES (10, 'CLUBE ATLÉTICO MINEIRO',                   9,        DATE '1908-03-25', 'THIAGO LARGHI');
INSERT INTO TF_TIMES VALUES (11, 'FLUMINENSE FOOTBALL CLUB',                 6,        DATE '1902-07-21', 'ABEL BRAGA');
INSERT INTO TF_TIMES VALUES (12, 'CLUBE ATLÉTICO PARANAENSE',               10,        DATE '1924-03-26', 'FERNANDO DINIZ');
INSERT INTO TF_TIMES VALUES (13, 'BOTAFOGO DE FUTEBOL E REGATAS',            6,        DATE '1894-07-01', 'ALBERTO VALENTIM');
INSERT INTO TF_TIMES VALUES (14, 'ESPORTE CLUBE BAHIA',                     11,        DATE '1931-01-01', 'ENDERSON MOREIRA');
INSERT INTO TF_TIMES VALUES (15, 'ASSOCIAÇÃO CHAPECOENSE DE FUTEBOL',       12,        DATE '1973-05-10', 'GILSON KLEINA');
INSERT INTO TF_TIMES VALUES (16, 'ESPORTE CLUBE VITÓRIA',                   11,        DATE '1899-05-13', 'VÁGNER MANCINI');
INSERT INTO TF_TIMES VALUES (17, 'SPORT CLUB DO RECIFE',                    13,        DATE '1905-05-13', 'CLAUDINEI OLIVEIRA');
INSERT INTO TF_TIMES VALUES (18, 'AMÉRICA FUTEBOL CLUBE (MG)',               9,        DATE '1912-04-30', 'RICARDO DRUBSCKY');
INSERT INTO TF_TIMES VALUES (19, 'CEARÁ SPORTING CLUB CEARÁ SPORTING CLUB', 14,        DATE '1914-06-02', 'LISCA');
INSERT INTO TF_TIMES VALUES (20, 'PARANÁ CLUBE',                            10,        DATE '1989-12-19', 'ROGÉRIO MICALE');

-- JOGADORES
INSERT INTO TF_JOGADORES VALUES (1, 'PEDRO GEROMEL',    DATE '1990-02-10', 2, 'ZAGUEIRO', 7);
INSERT INTO TF_JOGADORES VALUES (2, 'MARCELO GROHE',    DATE '1985-10-02', 2, 'GOLEIRO',  33);
INSERT INTO TF_JOGADORES VALUES (3, 'LUAN VIEIRA',      DATE '1987-11-07', 2, 'ATACANTE', 34);
INSERT INTO TF_JOGADORES VALUES (4, 'JAEL FERREIRA',    DATE '1984-03-26', 2, 'ATACANTE', 35);
INSERT INTO TF_JOGADORES VALUES (5, 'BRESSAN',          DATE '1989-08-15', 2, 'ZAGUEIRO', 2);
INSERT INTO TF_JOGADORES VALUES (6, 'LEO MOURA',        DATE '1990-05-30', 2, 'LATERAL', 7);
INSERT INTO TF_JOGADORES VALUES (7, 'MADSON',           DATE '1991-04-11', 2, 'LATERAL', 8);
INSERT INTO TF_JOGADORES VALUES (8, 'BRUNO CORTEZ',     DATE '1994-12-10', 2, 'LATERAL', 10);
INSERT INTO TF_JOGADORES VALUES (9, 'CICERO',           DATE '1984-01-15', 2, 'MEIA-ARMADOR', 15);
INSERT INTO TF_JOGADORES VALUES (10, 'MICHEL',          DATE '1995-07-05', 2, 'VOLANTE', 6);
INSERT INTO TF_JOGADORES VALUES (11, 'EVERTON',         DATE '1979-12-11', 2, 'ATACANTE', 11);
INSERT INTO TF_JOGADORES VALUES (12, 'ANDRE',           DATE '1996-01-10', 2, 'ATACANTE', 1);
INSERT INTO TF_JOGADORES VALUES (13, 'ALISSON',         DATE '1989-08-15', 2, 'ZAGUEIRO', 2);
INSERT INTO TF_JOGADORES VALUES (14, 'DANILO',          DATE '1989-08-11', 9, 'GOLEIRO', 14);
INSERT INTO TF_JOGADORES VALUES (15, 'RODRIGO MOLEDO',  DATE '1984-03-18', 9, 'ZAGUEIRO', 2);
INSERT INTO TF_JOGADORES VALUES (16, 'VICTOR CUESTA',   DATE '1987-03-12', 9, 'ZAGUEIRO', 7);
INSERT INTO TF_JOGADORES VALUES (17, 'ZECA',            DATE '1987-07-11', 9, 'LATERAL', 10);
INSERT INTO TF_JOGADORES VALUES (18, 'RODRIGO DOURADO', DATE '1989-09-12', 9, 'VOLANTE', 9);
INSERT INTO TF_JOGADORES VALUES (19, 'LEANDRO DAMIAO',  DATE '1984-01-25', 9, 'ATACANTE', 3);
INSERT INTO TF_JOGADORES VALUES (20, 'DIEGO ALVES',     DATE '1988-03-26', 1, 'GOLEIRO', 14);
INSERT INTO TF_JOGADORES VALUES (21, 'RENE',            DATE '1992-03-18', 1, 'VOLANTE', 12);
INSERT INTO TF_JOGADORES VALUES (22, 'GUERRERO',        DATE '1987-05-20', 1, 'ATACANTE', 11);
INSERT INTO TF_JOGADORES VALUES (23, 'DIEGO',           DATE '1989-07-12', 1, 'ATACANTE', 15);
INSERT INTO TF_JOGADORES VALUES (24, 'PRASS',           DATE '1982-09-11', 3, 'GOLEIRO', 15);
INSERT INTO TF_JOGADORES VALUES (25, 'MAYKE',           DATE '1992-03-18', 3, 'LATERAL', 13);
INSERT INTO TF_JOGADORES VALUES (26, 'FELIPE MELO',     DATE '1989-09-12', 3, 'VOLANTE', 9);

-- JOGOS
INSERT INTO TF_JOGOS VALUES (1,   1, 5,  2, 5, TO_DATE('2018-06-24 11:00', 'yyyy-mm-dd hh24:mi'));
INSERT INTO TF_JOGOS VALUES (2,   3, 1,  4, 3, TO_DATE('2018-06-17 20:00', 'yyyy-mm-dd hh24:mi'));
INSERT INTO TF_JOGOS VALUES (3,   5, 2,  1, 1, TO_DATE('2018-06-10 16:00', 'yyyy-mm-dd hh24:mi'));
INSERT INTO TF_JOGOS VALUES (4,   2, 0,  3, 0, TO_DATE('2018-06-03 16:00', 'yyyy-mm-dd hh24:mi'));
INSERT INTO TF_JOGOS VALUES (5,   4, 4,  5, 3, TO_DATE('2018-05-05 19:00', 'yyyy-mm-dd hh24:mi'));
INSERT INTO TF_JOGOS VALUES (6,   1, 1, 10, 1, TO_DATE('2017-05-15 20:00', 'yyyy-mm-dd hh24:mi'));
INSERT INTO TF_JOGOS VALUES (7,   4, 1, 15, 1, TO_DATE('2017-05-14 19:00', 'yyyy-mm-dd hh24:mi'));
INSERT INTO TF_JOGOS VALUES (8,  11, 3,  5, 2, TO_DATE('2017-05-14 16:00', 'yyyy-mm-dd hh24:mi'));
INSERT INTO TF_JOGOS VALUES (9,  14, 6, 12, 2, TO_DATE('2017-05-14 16:00', 'yyyy-mm-dd hh24:mi'));
INSERT INTO TF_JOGOS VALUES (10,  8, 1,  7, 0, TO_DATE('2017-05-14 16:00', 'yyyy-mm-dd hh24:mi'));
INSERT INTO TF_JOGOS VALUES (11,  3, 4,  6, 0, TO_DATE('2017-05-14 11:00', 'yyyy-mm-dd hh24:mi'));
INSERT INTO TF_JOGOS VALUES (12,  2, 2, 13, 0, TO_DATE('2017-05-13 19:00', 'yyyy-mm-dd hh24:mi'));
INSERT INTO TF_JOGOS VALUES (13, 15, 1,  3, 0, TO_DATE('2017-05-21 19:00', 'yyyy-mm-dd hh24:mi'));
INSERT INTO TF_JOGOS VALUES (14,  6, 2, 14, 1, TO_DATE('2017-05-21 16:00', 'yyyy-mm-dd hh24:mi'));
INSERT INTO TF_JOGOS VALUES (15, 16, 0,  4, 1, TO_DATE('2017-05-21 16:00', 'yyyy-mm-dd hh24:mi'));
INSERT INTO TF_JOGOS VALUES (16, 12, 0,  2, 2, TO_DATE('2017-05-21 16:00', 'yyyy-mm-dd hh24:mi'));
INSERT INTO TF_JOGOS VALUES (17, 10, 1, 11, 2, TO_DATE('2017-05-20 19:00', 'yyyy-mm-dd hh24:mi'));
INSERT INTO TF_JOGOS VALUES (18, 17, 1,  8, 1, TO_DATE('2017-05-20 19:00', 'yyyy-mm-dd hh24:mi'));
INSERT INTO TF_JOGOS VALUES (19,  7, 2,  3, 0, TO_DATE('2017-05-29 20:00', 'yyyy-mm-dd hh24:mi'));
INSERT INTO TF_JOGOS VALUES (20,  6, 3, 11, 2, TO_DATE('2017-05-28 19:00', 'yyyy-mm-dd hh24:mi'));
INSERT INTO TF_JOGOS VALUES (21, 12, 1,  1, 1, TO_DATE('2017-05-28 16:00', 'yyyy-mm-dd hh24:mi'));
INSERT INTO TF_JOGOS VALUES (22,  5, 0,  8, 1, TO_DATE('2017-05-28 11:00', 'yyyy-mm-dd hh24:mi'));
INSERT INTO TF_JOGOS VALUES (23, 13, 1, 14, 0, TO_DATE('2017-05-27 21:00', 'yyyy-mm-dd hh24:mi'));
INSERT INTO TF_JOGOS VALUES (24, 17, 4,  2, 3, TO_DATE('2017-05-27 19:00', 'yyyy-mm-dd hh24:mi'));


------------- CONSULTAS PARA AVALIAÇÃO DOS DADOS INSERIDOS ---------------------
-- SELECIONA TODOS OS ESTADOS
SELECT * FROM TF_ESTADOS
ORDER BY ID_ESTADO;

-- SELECIONA TODAS AS CIDADES
SELECT * FROM TF_CIDADES
ORDER BY ID_CIDADE;

-- SELECIONA TODOS OS TIMES
SELECT * FROM TF_TIMES
ORDER BY ID_TIME;

-- SELECIONA TODOS OS JOGADORES
SELECT * FROM TF_JOGADORES
ORDER BY ID_JOGADOR;

-- SELECIONA TODOS OS JOGOS
SELECT * FROM TF_JOGOS
ORDER BY DATA_JOGO;


--------------------------------------------------------------------------------
--------------------------- CONSULTAS DESENVOLVIDAS ----------------------------
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
------------------------------ Consultas básicas -------------------------------
--------------------------------------------------------------------------------
-- 5 consultas básicas envolvendo os comandos distinct, order by, count(*),
-- like, in e funções de manipulação de datas.

-- 1. Nomes de todos os jogadores nascidos entre de 1992 e 2007.
SELECT nome FROM tf_jogadores
WHERE data_nascimento BETWEEN
      TO_DATE('1992-01-01', 'YYYY-MM-DD') AND
      TO_DATE('2007-12-31', 'YYYY-MM-DD');

-- 2. Nomes de todas as cidades que começam com a letra 'P'.
SELECT nome FROM tf_cidades
WHERE nome LIKE 'P%';

-- 3. Nomes de todos os clubes e número de anos em atividade.
SELECT nome,
    EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM data_fundacao) anos_atividade
FROM tf_times;

-- 4. Total de gols em julho de 2017.
SELECT SUM(tf_jogos.gols_mandante) + SUM(tf_jogos.gols_visitante) total_de_gols
FROM tf_jogos
WHERE data_jogo BETWEEN
    TO_DATE('2017-07-01', 'YYYY-MM-DD') AND
    TO_DATE('2017-07-31', 'YYYY-MM-DD');

-- 5. Média de gols por partida (dentre todas as partidas cadastradas).
SELECT AVG(tf_jogos.gols_mandante + tf_jogos.gols_visitante) media_gols
FROM tf_jogos;


--------------------------------------------------------------------------------
------------------------- Consultas envolvendo junções -------------------------
--------------------------------------------------------------------------------
-- 5 consultas das quais 2 envolvam junções entre duas tabelas e 3 envolvam
-- junções entre três ou mais tabelas.

-- 1. Selecionar as datas de todos os jogos, nomes das cidades e dos estados
--    onde aconteceram.
SELECT tf_jogos.data_jogo AS data, tf_cidades.nome AS cidade,
       tf_estados.nome AS estado
FROM tf_jogos
    JOIN tf_times ON tf_times.id_time = tf_jogos.id_mandante
    JOIN tf_cidades ON tf_cidades.id_cidade = tf_times.id_cidade
    JOIN tf_estados ON tf_estados.id_estado = tf_cidades.id_estado;

-- 2. Selecionar as datas de todos os jogos, times envolvidos e resultado.
SELECT TO_CHAR(tf_jogos.data_jogo, 'dd/mm/yyyy hh24:mi') data,
  t1.nome mandante,
	  tf_jogos.gols_mandante,
  t2.nome visitante,
  tf_jogos.GOLS_VISITANTE FROM tf_jogos
    JOIN tf_times t1 ON t1.id_time = tf_jogos.id_mandante
    JOIN tf_times t2 ON t2.id_time = tf_jogos.id_visitante;

-- 3. Selecionar o estado de origem de cada time.
SELECT tf_times.nome time, tf_estados.nome estado FROM tf_times
    JOIN tf_cidades ON tf_cidades.id_cidade = tf_times.id_cidade
    JOIN tf_estados ON tf_estados.id_estado = tf_cidades.id_estado;

-- 4. Selecionar o nome do jogador, o nome de sua cidade natal e sua idade.
SELECT tf_jogadores.nome nome,
       tf_cidades.nome cidade_natal,
       EXTRACT(YEAR FROM SYSDATE) -
          EXTRACT(YEAR FROM tf_jogadores.data_nascimento) idade
    FROM tf_jogadores
    JOIN tf_cidades ON tf_cidades.id_cidade = tf_jogadores.id_cidade_nascimento;

-- 5. Data e total de gols das partidas acontecidas em cidades fundadas há mais de 150 anos.
SELECT TO_CHAR(tf_jogos.data_jogo, 'dd/mm/yyyy hh24:mi') data,
       tf_jogos.gols_mandante + tf_jogos.gols_visitante gols
FROM tf_jogos
	JOIN tf_times ON tf_times.id_time = tf_jogos.id_mandante
	JOIN tf_cidades ON tf_cidades.id_cidade = tf_times.id_cidade
WHERE EXTRACT(YEAR FROM tf_cidades.data_fundacao) < EXTRACT(YEAR FROM SYSDATE) - 150
ORDER BY gols DESC;


--------------------------------------------------------------------------------
----------------------- Consultas envolvendo agregações ------------------------
--------------------------------------------------------------------------------
-- 5 consultas envolvendo group by e having, juntamente com funções de agregação

-- 1. Nomes das cidades e quantidade de clubes por cidade.
SELECT tf_cidades.nome nome_cidade,
       count(tf_times.id_time) clubes
FROM tf_cidades
    JOIN tf_times ON tf_times.id_cidade = tf_cidades.id_cidade
GROUP BY tf_cidades.nome
ORDER BY clubes DESC;

-- 2. Cidades cuja média da idade dos jogadores seja maior que 30 anos.
SELECT tf_cidades.nome nome_cidade FROM tf_cidades
    JOIN tf_jogadores ON
        tf_jogadores.id_cidade_nascimento = tf_cidades.id_cidade
GROUP BY tf_cidades.nome
HAVING AVG(EXTRACT(YEAR FROM SYSDATE) -
       EXTRACT(YEAR FROM tf_jogadores.data_nascimento)) > 30;

-- 3. Nomes dos times que jogaram pelo menos 2 jogos fora de casa em 2017 e
--    quantidade de jogos.
SELECT tf_times.nome nome_time, COUNT(tf_jogos.id_jogo) jogos_visitante
FROM tf_times
    JOIN tf_jogos ON tf_jogos.id_visitante = tf_times.id_time
WHERE tf_jogos.data_jogo BETWEEN
        TO_DATE('2017-01-01', 'YYYY-MM-DD') AND
        TO_DATE('2017-12-31', 'YYYY-MM-DD')
GROUP BY tf_times.nome
HAVING COUNT(tf_jogos.id_jogo) >= 2
ORDER BY jogos_visitante DESC;

-- 4. Nome das cidades e quantidade de jogadores nascidos na cidade
SELECT tf_cidades.nome nome_cidade,
  COUNT(tf_jogadores.nome) jogadores FROM tf_cidades
    JOIN tf_jogadores ON tf_jogadores.id_cidade_nascimento = tf_cidades.id_cidade
GROUP BY tf_cidades.nome
ORDER BY jogadores DESC;

-- 5. Nome das cidades e quantidade de jogos por cidade
SELECT tf_cidades.nome nome_cidade,
  COUNT(tf_jogos.id_mandante) cidade FROM tf_cidades
    JOIN tf_jogos ON tf_jogos.id_mandante = tf_times.id_time
    JOIN tf_times ON tf_times.id_cidade = tf_cidades.id_cidade
GROUP BY tf_cidades.nome
ORDER BY cidade DESC;


--------------------------------------------------------------------------------
--------------------- Consultas envolvendo sub-consultas -----------------------
--------------------------------------------------------------------------------
-- 5 consultas envolvendo sub-consultas.

-- 1. Nomes dos jogadores cujos clubes jogaram pelo menos dois jogos em 2017.
SELECT nome FROM tf_jogadores
WHERE id_time IN
  (SELECT id_time FROM tf_times, tf_jogos
      WHERE tf_jogos.id_mandante = tf_times.id_time OR
            tf_jogos.id_visitante = tf_times.id_time AND
            tf_jogos.data_jogo BETWEEN
              TO_DATE('2017-01-01', 'YYYY-MM-DD') AND
              TO_DATE('2017-12-31', 'YYYY-MM-DD')
  GROUP BY id_time
  HAVING COUNT(*) >= 2);

-- 2. Nomes dos estados que possuem cidades que sediaram pelo menos um jogo
--    entre janeiro de 2016 e dezembro de 2017.
SELECT tf_estados.nome FROM tf_estados
    JOIN tf_cidades ON tf_cidades.id_estado = tf_estados.id_estado
WHERE tf_cidades.id_cidade IN
  (SELECT tf_times.id_cidade FROM tf_times
      JOIN tf_jogos ON tf_jogos.id_mandante = tf_times.id_time
      WHERE tf_jogos.data_jogo BETWEEN
        TO_DATE('2016-01-01', 'YYYY-MM-DD') AND
  	    TO_DATE('2017-12-31', 'YYYY-MM-DD')
      GROUP BY tf_times.id_cidade
      HAVING COUNT(*) >= 1);

-- 3. Nomes dos estados que possuem pelo menos dois clubes.
SELECT DISTINCT tf_estados.nome FROM tf_estados
    JOIN tf_cidades ON tf_cidades.id_estado = tf_estados.id_estado
    WHERE tf_cidades.id_cidade IN
        (SELECT id_cidade FROM tf_times
         GROUP BY id_cidade
         HAVING COUNT(*) >= 2);

-- 4. Selecionar cidades que poderiam ter um time de futebol contando apenas com
--    nativos (cidades que tenham sido berço de pelo menos 11 jogadores).
SELECT nome AS cidade FROM tf_cidades
    WHERE id_cidade IN
        (SELECT id_cidade_nascimento FROM tf_jogadores
            GROUP BY id_cidade_nascimento
            HAVING COUNT(*) >= 11);

-- 5. O estado onde nasceu o jogador mais velho cadastrado.
SELECT tf_estados.nome nome_estado FROM tf_estados
    JOIN tf_cidades ON tf_cidades.id_estado = tf_estados.id_estado
    JOIN tf_jogadores ON tf_jogadores.id_cidade_nascimento = tf_cidades.id_cidade
WHERE EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM tf_jogadores.data_nascimento) =
    (SELECT MAX(EXTRACT(YEAR FROM SYSDATE) -
            EXTRACT(YEAR FROM data_nascimento)) idade_maxima FROM tf_jogadores);
