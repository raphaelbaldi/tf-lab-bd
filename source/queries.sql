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

-- SELECIONA TODOS OS JOGOS E EXIBE O NOME DOS TIMES PARTICIPANTES, ASSIM COMO O RESULTADO
SELECT j.id_jogo JOGO, j.data_jogo DATA, mandante.nome MANDANTE, gols_mandante GOLS, visitante.nome VISITANTE, gols_visitante GOLS,
  CASE
    WHEN gols_mandante > gols_visitante THEN mandante.nome
    WHEN gols_mandante < gols_visitante THEN visitante.nome
    ELSE 'EMPATE' END RESULTADO
FROM tf_jogos j
  INNER JOIN tf_times mandante ON j.id_mandante = mandante.id_time
  INNER JOIN tf_times visitante ON j.id_visitante = visitante.id_time
ORDER BY j.id_jogo;
