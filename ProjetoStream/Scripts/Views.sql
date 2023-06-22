-- Esta visualização  contém os todos os dados de todos os usuários, 
-- funcionários e quais são clientes, o endereço de cada um e seu pais de origem,  perfis cada um tem e seu plano.

CREATE VIEW vw_usuario AS 
	SELECT c.id_usuario AS cliente , f.id_usuario AS funcionario, u.id_usuario, u.nome, u.sobrenome, u.email, u.`status`, u.dt_nascimento, u.dt_cadastro, u.senha, u.dt_atualizacao, u.id_endereco,
    p.nome AS pais, COUNT(pe.nome) AS qnt_perfil, pla.descricao AS plano
    FROM tb_usuario AS u
		LEFT JOIN tb_funcionario AS f
			ON f.id_usuario = u.id_usuario
		LEFT JOIN tb_cliente AS c
			ON c.id_usuario = u.id_usuario
		LEFT JOIN tb_endereco AS e
			ON e.id_endereco = u.id_endereco
		INNER JOIN tb_pais AS p
			ON e.id_pais = p.id_pais
		INNER JOIN tb_perfil pe
			ON pe.id_cliente = c.id_cliente
		INNER JOIN tb_plano pla
			ON c.id_plano = pla.id_plano
		GROUP BY pe.nome;
		
	-- Esta visualização contém todos os dados do catalogo, identificando series e filmes, 
	-- (não mostra os episodios ), o idioma original e quantos idiomas são possíveis escolher,
     -- a classificação indicativa e suas categorias.

	
	CREATE VIEW vw_catalogo AS 
		SELECT se.id_catalogo AS serie , 
		fe.id_catalogo AS filme, 
		ca.id_catalogo AS catalogo,
		ca.id_pais, ca.imagem_capa, 
		ca.titulo,
		ca.ano_lancamento, 
				ca.duracao, ca.avaliacao, ca.dt_atualizacao, 
		ca.id_classind, ca.id_idioma, 
		cl.descricao
		AS classificacao FROM tb_catalogo AS ca
					LEFT JOIN tb_serie AS se
				ON se.id_catalogo = ca.id_catalogo
			LEFT JOIN tb_filme AS fe
				ON ca.id_catalogo = fe.id_catalogo
			LEFT JOIN tb_classind AS cl
				ON cl.id_classind = ca.id_classind
			LEFT JOIN tb_catalogo_categoria AS ct
				ON ct.id_catalogo = ca.id_catalogo
			LEFT JOIN tb_categoria AS cg
				ON cg.id_categoria = ct.id_categoria
			
		
-- Esta visualização tem todos os dados dos episódios, qual sua serie, e de qual temporada ele é.

			
		
CREATE VIEW vw_episodio AS
	SELECT e.id_episodio, e.numero, e.id_catalogo, e.id_temporada, ca.titulo, se.id_serie FROM tb_episodio AS e
		LEFT JOIN tb_temporada AS te
			ON te.id_temporada = e.id_temporada
		LEFT JOIN tb_serie AS se
			ON te.id_serie = se.id_serie
		LEFT JOIN tb_catalogo AS ca
			ON ca.id_catalogo = e.id_catalogo
		RIGHT JOIN tb_catalogo AS cat
			ON ca.id_catalogo = se.id_catalogo
            GROUP BY se.id_serie, e.id_episodio;
            
     
      
      
  
-- Esta visualização tem todos os dados da temporada, a sua quantidade de episodios, e sua série.
  CREATE VIEW vw_temporada AS
select t.id_temporada, t.titulo,  s.nome AS nome_serie, t.titulo AS titulo_temporada
FROM tb_episodio e
LEFT JOIN tb_temporada t ON e.id_temporada = t.id_temporada
LEFT JOIN tb_serie s ON e.id_serie = s.id_serie;


 -- Tem todos os dados dos atores, quantidades de filmes feito por ele, quantidade de series feita por ele.          
          
      CREATE VIEW vw_ator AS
SELECT a.id_ator, a.nome, a.sobrenome, a.dt_nascimento, a.foto, COUNT(DISTINCT f.id_filme) AS qtd_filmes, COUNT(DISTINCT s.id_serie) AS qtd_series
FROM tb_artista AS a
LEFT JOIN tb_catalogo AS c ON c.id_catalogo = a.id_catalogo
LEFT JOIN tb_filme AS f ON f.id_catalogo = c.id_catalogo
LEFT JOIN tb_serie AS s ON s.id_catalogo = c.id_catalogo
GROUP BY a.id_ator, a.nome, a.sobrenome, a.dt_nascimento, a.foto;
    



-- Tem todos os dados de pagamento, seu tipo, o nome do cliente, seu plano e data de vencimento.


CREATE VIEW vw_pagamento AS
SELECT 
    p.id_pagamento,
    p.valor,
    p.dt_pagamento,
    tp.categoria AS tipo_pagamento,
    c.nome AS nome_cliente,
    pl.nome AS nome_plano,
    c.dt_vencimento_plano
FROM 
    tb_pagamento p
    LEFT JOIN tb_tipo_pag tp ON p.id_tipo_pag = tp.id_tipo_pag
    LEFT JOIN tb_cliente c ON p.id_cliente = c.id_cliente
    left JOIN tb_plano pl ON c.id_plano = pl.id_plano;
   
  
-- Tem todos os dados do perfil e seu cliente.
  
  CREATE VIEW vw_perfil AS
	SELECT p.id_plano, us.nome AS cliente,  p.foto, p.nome AS nome_perfil, 
	p.tipo, cl.id_cliente, cl.plano_escolhido, cl.dt_vencimento, cl.id_usuario, cl.id_cartao_credito 
	FROM tb_perfil AS p
		LEFT JOIN tb_cliente AS cl
			ON p.id_plano = cl.id_plano
		LEFT JOIN tb_plano AS pl
			ON pl.id_plano = cl.id_plano
		LEFT JOIN tb_usuario AS us
			ON us.id_usuario = cl.id_usuario;
   
           
      
  