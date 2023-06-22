# Projeto Banco de dados

Este projeto tem intuito de demonstrar o conteudo aprendido em sala de aula no curso de **DBA**, para insto foi escolhido um banco de dados para plataformas de streaming.

<div align=center>

## Modelo Conceitual
<img src="https://lh3.googleusercontent.com/pw/AJFCJaWSmw3yR4gznRcxppb9xTvCzRakkivJeItBT76g7xt6E3FRkYEuPy7J5e8LYYuI4G-pC9_OZSApwMKjRNh1Chh18b748m_qmiW5p0QQrxL9ga1_xwwNaa5jsyFOSGpyiQ_TZQQ695IIw03ZrHSx1WFH3A=w1116-h789-s-no?authuser=0"> 

<div align=center>

## Modelo Logico
<img src="https://lh3.googleusercontent.com/pw/AJFCJaVyVpeRIoerEiT7FvXq6SL3Hmfx7p3vu-sUvv6iGdsqsoB8abRFfdEG6LmGL9lfhFrtx8TEZFcxX-KvGo5VGYiTBxHFWtEkNv1KAbCUKns7GGB7ZSx9ErIMN7Yl7rkbYLMaNtTKwCEDtkDiMiuUjiWJ_g=w1115-h789-s-no?authuser=0">
</div>



## Tabelas
</div>

- Tabela1

CREATE TABLE IF NOT EXISTS tb_ClassInd (
	id_ClassInd INT PRIMARY KEY AUTO_INCREMENT,
	idade ENUM( 'livre' ,  '10' ,  '12' ,  '14' ,  '16' ,  '18' ) NOT NULL,
	descricao VARCHAR(100) NOT NULL,
	dt_atualizacao DATE NOT NULL,
 CONSTRAINT uq_idade UNIQUE (idade)
) AUTO_INCREMENT = 1;

- Tabela2

CREATE TABLE IF NOT EXISTS tb_categoria(
	id_categoria INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(60) NOT NULL,
	dt_atualizacao DATE NOT NULL,
CONSTRAINT uq_nome_tb_categoria UNIQUE (nome) 
) AUTO_INCREMENT = 1;

- Tabela3

CREATE TABLE IF NOT EXISTS tb_idioma (
	id_idioma INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(60) NOT NULL,
	dt_atualizacao DATE NOT NULL,
CONSTRAINT uq_nome_tb_idioma UNIQUE (nome)
)AUTO_INCREMENT = 1;


- Tabela4

CREATE TABLE IF NOT EXISTS tb_tipo_pag(
	id_tipo_pag INT PRIMARY KEY AUTO_INCREMENT,
	categoria VARCHAR(30) NOT NULL,
    dt_atualizacao DATE NOT NULL,
CONSTRAINT uq_categoria_tb_tipo_pag UNIQUE (categoria)
) AUTO_INCREMENT = 1;


- Tabela5

CREATE TABLE IF NOT EXISTS  tb_pais (
	id_pais  INT PRIMARY KEY AUTO_INCREMENT,
	nome  VARCHAR(45) NOT NULL,
	codigo  CHAR(3) NOT NULL,
	dt_atualizacao DATE NOT NULL,
CONSTRAINT uq_nome_tb_pais UNIQUE (nome),
CONSTRAINT uq_codigo_tb_pais UNIQUE (codigo)
) AUTO_INCREMENT = 1;


- Tabela6

CREATE TABLE IF NOT EXISTS  tb_plano(
	id_plano  INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL, 
	valor  FLOAT NOT NULL,
	descricao  VARCHAR(255) NOT NULL,
	dt_atualizacao DATE NOT NULL,
CONSTRAINT uq_nome_tb_plano UNIQUE (nome),
CONSTRAINT uq_valor_tb_plano UNIQUE (valor),
CONSTRAINT uq_descricao_tb_plano UNIQUE (descricao)
) AUTO_INCREMENT = 1;


- Tabela7

CREATE TABLE IF NOT EXISTS tb_ator(
	id_ator INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(45) NOT NULL,
	sobrenome VARCHAR(45) NOT NULL,
	dt_nascimento DATE NOT NULL,
	foto VARCHAR(255) NOT NULL,
	dt_atualizacao DATE NOT NULL,
CONSTRAINT uq_foto_tb_autor UNIQUE (foto)
) AUTO_INCREMENT = 1;


- Tabela8

CREATE TABLE IF NOT EXISTS tb_elenco(
	id_catalogo INT NOT NULL,
	id_ator INT NOT NULL,
    dt_atualizacao DATE NOT NULL,
PRIMARY KEY(id_catalogo, id_ator),
CONSTRAINT fk_catalogo_tb_elenco FOREIGN KEY (id_catalogo) REFERENCES tb_catalogo(id_catalogo),
CONSTRAINT fk_ator_tb_elenco FOREIGN KEY (id_ator) REFERENCES tb_ator(id_ator)
);
 

- Tabela9

CREATE TABLE IF NOT EXISTS  tb_estado(
	id_estado INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(45) NOT NULL,
	id_pais INT NOT NULL,
	dt_atualizacao DATE NOT NULL,
CONSTRAINT fk_id_pais FOREIGN KEY (id_pais) REFERENCES tb_pais(id_pais)
) AUTO_INCREMENT = 1;

- Tabela10

CREATE TABLE IF NOT EXISTS tb_catalogo (
  id_catalogo INT PRIMARY KEY AUTO_INCREMENT,
  titulo VARCHAR(45) NOT NULL,
  ano_lancamento YEAR NOT NULL,
  duracao TIME DEFAULT '00:00:00',
  descricao VARCHAR(255) NOT NULL,
  imagem_capa VARCHAR(200) NOT NULL,
  avaliacao ENUM('1', '2', '3', '4', '5') DEFAULT NULL,
  id_tb_classind INT,
  id_idioma INT NOT NULL,
  dt_atualizacao DATE NOT NULL,
  CONSTRAINT fk_id_classind_catalogo FOREIGN KEY (id_classind) REFERENCES tb_classInd(id_classind),
  CONSTRAINT fk_id_idioma_catalogo FOREIGN KEY (id_idioma) REFERENCES tb_idioma(id_idioma)
) AUTO_INCREMENT = 1;


- Tabela11
CREATE TABLE IF NOT EXISTS tb_filme(
  id_filme INT PRIMARY KEY AUTO_INCREMENT,
  id_catalogo INT NOT NULL,
  oscar ENUM('sim', 'nao') DEFAULT NULL,
  dt_atualizacao DATE NOT NULL,
CONSTRAINT uq_id_catalogo_tb_filme UNIQUE tb_catalogo(id_catalogo)
) AUTO_INCREMENT = 1;



- Tabela12
CREATE TABLE IF NOT EXISTS  tb_catalogo_idioma (
	id_catalogo  INT NOT NULL,
	id_idioma  INT NOT NULL,
	dt_atualizacao DATE NOT NULL,
PRIMARY KEY(id_catalogo, id_idioma),
CONSTRAINT fk_id_catalogo FOREIGN KEY (id_catalogo) REFERENCES tb_catalogo(id_catalogo),
CONSTRAINT fk_id_idioma FOREIGN KEY (id_idioma) REFERENCES tb_idioma(id_idioma)
);

- Tabela13
CREATE TABLE IF NOT EXISTS tb_pais_catalogo(
	id_pais INT NOT NULL,
	id_catalogo INT NOT NULL,
	dt_atualizacao DATE NOT NULL,
PRIMARY KEY(id_pais, id_catalogo),
CONSTRAINT fk_id_pais_tb_pais_catalogo FOREIGN KEY (id_pais) REFERENCES tb_pais(id_pais),
CONSTRAINT fk_id_catalogo_tb_pais_catalogo FOREIGN KEY (id_catalogo) REFERENCES tb_catalogo(id_catalogo)
);

- Tabela14
CREATE TABLE IF NOT EXISTS tb_endereco(
	id_endereco INT PRIMARY KEY AUTO_INCREMENT,
	lugadouro VARCHAR(200) NOT NULL,
    cep INT NOT NULL,
    bairro_distrito VARCHAR(200) NOT NULL,
    complemento_referencia TEXT NULL,
    localidade_uf VARCHAR(60) NOT NULL,
    numero INT NULL,
	id_pais INT NOT NULL,
	id_estado INT,
	dt_atualizacao DATE NOT NULL,
CONSTRAINT fk_id_pais_endereco FOREIGN KEY (id_pais) REFERENCES tb_pais(id_pais),
CONSTRAINT fk_id_estado_endereco FOREIGN KEY (id_estado) REFERENCES tb_estado(id_estado)
) AUTO_INCREMENT = 1;

- Tabela15
CREATE TABLE IF NOT EXISTS  tb_usuario(
	id_usuario  INT PRIMARY KEY AUTO_INCREMENT,
	nome  VARCHAR(45) NOT NULL,
	sobrenome  VARCHAR(45) NOT NULL,
	email  VARCHAR(95) NOT NULL,
	dt_nascimento  DATE NOT NULL,
	dt_cadastro  DATE NOT NULL,
	senha VARCHAR(32) NOT NULL,
	status  ENUM('ativo','inativo'),
	id_endereco  INT NOT NULL,
	dt_atualizacao  DATE NOT NULL,
CONSTRAINT uq_email UNIQUE(email),
CONSTRAINT fk_id_endereco_tb_usuario FOREIGN KEY (id_endereco) REFERENCES tb_endereco(id_endereco)
) AUTO_INCREMENT = 1;

- Tabela16
CREATE TABLE IF NOT EXISTS tb_funcionario(
	id INT PRIMARY KEY AUTO_INCREMENT,
	id_usuario INT NOT NULL,
	foto longblob NOT NULL,
	dt_atualizacao DATE NOT NULL,
CONSTRAINT uq_foto UNIQUE (foto),
CONSTRAINT uq_id_usuario_funcionario UNIQUE (id_usuario),
CONSTRAINT fk_id_usuario_funcionario FOREIGN KEY (id_usuario) REFERENCES tb_usuario(id_usuario)
) AUTO_INCREMENT = 1;

- Tabela17
CREATE TABLE IF NOT EXISTS tb_cliente(
	id_cliente INT PRIMARY KEY AUTO_INCREMENT,
	id_usuario INT NOT NULL,
	id_plano INT NULL,
	dt_vencimento_plano DATE NULL,
	dt_atualizacao DATE NOT NULL,
CONSTRAINT uq_id_usuario_cliente UNIQUE (id_usuario),
CONSTRAINT fk_id_usuario_cliente FOREIGN KEY (id_usuario) REFERENCES tb_usuario(id_usuario),
CONSTRAINT fk_id_plano_cliente FOREIGN KEY (id_plano) REFERENCES tb_plano(id_plano)
) AUTO_INCREMENT = 1;
 
 - Tabela18

 CREATE TABLE IF NOT EXISTS  tb_perfil( 
	id_perfil  INT PRIMARY KEY AUTO_INCREMENT,
	nome  VARCHAR(45) NOT NULL,
	foto longblob NOT NULL,
	tipo  ENUM('adulto','infantil') NOT NULL,
	id_cliente  INT NOT NULL,
	dt_atualizacao DATE NOT NULL,
CONSTRAINT fk_id_cliente_perfil FOREIGN KEY (id_cliente) REFERENCES tb_cliente(id_cliente)
) AUTO_INCREMENT = 1;

- Tabela19

CREATE TABLE IF NOT EXISTS  tb_cartao_credito(
	numero CHAR(19) NOT NULL,
	data_vencimento DATE NOT NULL,
	cod_seguranca CHAR(3) NOT NULL,
	id_cliente INT NOT NULL,
	dt_atualizacao DATE NOT NULL,
CONSTRAINT id_cliente_tb_cartao FOREIGN KEY (id_cliente) REFERENCES tb_cliente(id_cliente)
) AUTO_INCREMENT = 1;

- Tabela20

CREATE TABLE IF NOT EXISTS  tb_pagamento(
	id_pagamento INT PRIMARY KEY AUTO_INCREMENT,
	valor FLOAT NOT NULL,
	dt_pagamento DATETIME NOT NULL,
	id_cartao_credito INT,
	id_cliente INT NULL,
	id_tipo_pag INT NOT NULL,
	dt_atualizacao DATE NOT NULL,
CONSTRAINT fk_id_cartao_credito_pagamento FOREIGN KEY (id_cartao_credito) REFERENCES tb_cartao_credito(id_cartao),
CONSTRAINT fk_id_cliente_pagamento FOREIGN KEY (id_cliente) REFERENCES tb_cliente(id_cliente),
CONSTRAINT fk_id_tipo_pag_pagamento FOREIGN KEY (id_tipo_pag) REFERENCES tb_tipo_pag(id_tipo_pag)
) AUTO_INCREMENT = 1;

- Tabela 21

CREATE TABLE IF NOT EXISTS tb_catalogo_categoria(
	id_catalogo INT NOT NULL,
	id_categoria INT NOT NULL,
	dt_atualizacao DATE NOT NULL,
 PRIMARY KEY(id_catalogo, id_categoria),
 CONSTRAINT fk_id_catalogo_catalogo_categoria FOREIGN KEY (id_catalogo) REFERENCES tb_catalogo(id_catalogo),
 CONSTRAINT fk_id_categoria_catalogo_categoria FOREIGN KEY (id_categoria) REFERENCES tb_categoria(id_categoria)
 );


- Tabela 22

CREATE TABLE IF NOT EXISTS tb_artista(
	id_catalogo INT NOT NULL,
	id_ator INT NOT NULL,
    dt_atualizacao DATE NOT NULL,
PRIMARY KEY(id_catalogo, id_ator),
CONSTRAINT fk_catalogo_artista FOREIGN KEY (id_catalogo) REFERENCES tb_catalogo(id_catalogo),
CONSTRAINT fk_ator_artista FOREIGN KEY (id_ator) REFERENCES tb_ator(id_ator)
);
 
 - Tabela 23

CREATE TABLE IF NOT EXISTS tb_serie(
	id_serie INT PRIMARY KEY AUTO_INCREMENT,
	id_catalogo INT NOT NULL,
	qtd_temporadas TINYINT NOT NULL,
	qtd_episodios TINYINT NOT NULL,
    dt_atualizacao DATE NOT NULL,
CONSTRAINT uq_id_catalogo UNIQUE (id_catalogo),
CONSTRAINT fk_catalogo_tb_serie FOREIGN KEY (id_catalogo) REFERENCES tb_catalogo(id_catalogo)
) AUTO_INCREMENT = 1;

- Tabela 24

CREATE TABLE IF NOT EXISTS tb_temporada(
  id_temporada INT PRIMARY KEY AUTO_INCREMENT,
  titulo  VARCHAR(45) NOT NULL,
  id_serie  INT NOT NULL,
  descricao  VARCHAR(255) NOT NULL,
  qtd_episodio  TINYINT NOT NULL,
  dt_atualizacao DATE NOT NULL,
CONSTRAINT fk_id_serie_temporada FOREIGN KEY (id_serie) REFERENCES tb_serie(id_serie)
) AUTO_INCREMENT = 1;

- Tabela 25

CREATE TABLE IF NOT EXISTS tb_episodio (
    id_episodio INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    numero TINYINT NOT NULL,
    descricao  VARCHAR(255) NOT NULL,
    id_temporada INT NOT NULL,
    id_serie INT NOT NULL,
    dt_atualizacao DATE NOT NULL,
  CONSTRAINT fk_id_temporada_episodio FOREIGN KEY (id_temporada) REFERENCES tb_temporada (id_temporada),
  CONSTRAINT fk_id_serie_episodio FOREIGN KEY (id_serie) REFERENCES tb_serie (id_serie)
)  AUTO_INCREMENT = 1;

 



<div align=center>

## Views
</div>


 - Esta visualização  contém os todos os dados de todos os usuários, funcionários e quais são clientes, o endereço de cada um e seu pais de origem,  perfis cada um tem e seu plano.


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
	----------------------------	
	- Esta visualização contém todos os dados do catalogo dentificando series e filmes,(não mostra os episodios ), o idioma original e quantos idiomas são possíveis escolher,
      a classificação indicativa e suas categorias.

	
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
			
----------------------------		
- Esta visualização tem todos os dados dos episódios, qual sua serie, e de qual temporada ele é.

				
  CREATE VIEW vw_episodio AS  SELECT e.id_episodio, e.numero, e.id_catalogo, e.id_temporada, ca.titulo, se.id_serie FROM tb_episodio AS e
  LEFT JOIN tb_temporada AS te
  ON te.id_temporada = e.id_temporada
 LEFT JOIN tb_serie AS se
	ON te.id_serie = se.id_serie
 LEFT JOIN tb_catalogo AS ca
			ON ca.id_catalogo = e.id_catalogo
		RIGHT JOIN tb_catalogo AS cat
			ON ca.id_catalogo = se.id_catalogo
            GROUP BY se.id_serie, e.id_episodio;
            
     
   ----------------------------     
  
- Esta visualização tem todos os dados da temporada, a sua quantidade de episodios, e sua série.

  CREATE VIEW vw_temporada AS
  select t.id_temporada, t.titulo,  s.nome AS nome_serie, t.titulo AS titulo_temporada
 FROM tb_episodio e
 LEFT JOIN tb_temporada t ON e.id_temporada = t.id_temporada
 LEFT JOIN tb_serie s ON e.id_serie = s.id_serie;

----------------------------
 - Tem todos os dados dos atores, quantidades de filmes feito por ele, quantidade de series feita por ele.          
          
      CREATE VIEW vw_ator AS
   SELECT a.id_ator, a.nome, a.sobrenome, a.dt_nascimento, a.foto, COUNT(DISTINCT f.id_filme) AS qtd_filmes, COUNT(DISTINCT s.id_serie) AS qtd_series
  FROM tb_artista AS a
  LEFT JOIN tb_catalogo AS c ON c.id_catalogo = a.id_catalogo
  LEFT JOIN tb_filme AS f ON f.id_catalogo = c.id_catalogo
  LEFT JOIN tb_serie AS s ON s.id_catalogo = c.id_catalogo
  GROUP BY a.id_ator, a.nome, a.sobrenome, a.dt_nascimento, a.foto;

   ---------------------------- 
- Tem todos os dados de pagamento, seu tipo, o nome do cliente, seu plano e data de vencimento.


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
   
  ----------------------------
- Tem todos os dados do perfil e seu cliente.
  
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
   
           
      
----------------------------


<div align=center>

## Funções
</div>


- Remover acentos na linguagem latina - Português 

 CREATE FUNCTION fn_remover_acento (texto VARCHAR(255))
    RETURNS VARCHAR(255)
    LANGUAGE SQL
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
    BEGIN
    SET texto = REPLACE(texto,'Š','S');
    SET texto = REPLACE(texto,'š','s');
    SET texto = REPLACE(texto,'Ð','Dj');
    SET texto = REPLACE(texto,'Ž','Z');
    SET texto = REPLACE(texto,'ž','z');
    SET texto = REPLACE(texto,'À','A');
    SET texto = REPLACE(texto,'Á','A');
    SET texto = REPLACE(texto,'Â','A');
    SET texto = REPLACE(texto,'Ã','A');
    SET texto = REPLACE(texto,'Ä','A');
    SET texto = REPLACE(texto,'Å','A');
    SET texto = REPLACE(texto,'Æ','A');
    SET texto = REPLACE(texto,'Ç','C');
    SET texto = REPLACE(texto,'È','E');
    SET texto = REPLACE(texto,'É','E');
    SET texto = REPLACE(texto,'Ê','E');
    SET texto = REPLACE(texto,'Ë','E');
    SET texto = REPLACE(texto,'Ì','I');
    SET texto = REPLACE(texto,'Í','I');
    SET texto = REPLACE(texto,'Î','I');
    SET texto = REPLACE(texto,'Ï','I');
    SET texto = REPLACE(texto,'Ñ','N');
    SET texto = REPLACE(texto,'Ò','O');
    SET texto = REPLACE(texto,'Ó','O');
    SET texto = REPLACE(texto,'Ô','O');
    SET texto = REPLACE(texto,'Õ','O');
    SET texto = REPLACE(texto,'Ö','O');
    SET texto = REPLACE(texto,'Ø','O');
    SET texto = REPLACE(texto,'Ù','U');
    SET texto = REPLACE(texto,'Ú','U');
    SET texto = REPLACE(texto,'Û','U');
    SET texto = REPLACE(texto,'Ü','U');
    SET texto = REPLACE(texto,'Ý','Y');
    SET texto = REPLACE(texto,'Þ','B');
    SET texto = REPLACE(texto,'ß','Ss');
    SET texto = REPLACE(texto,'à','a');
    SET texto = REPLACE(texto,'á','a');
    SET texto = REPLACE(texto,'â','a');
    SET texto = REPLACE(texto,'ã','a');
    SET texto = REPLACE(texto,'ä','a');
    SET texto = REPLACE(texto,'å','a');
    SET texto = REPLACE(texto,'æ','a');
    SET texto = REPLACE(texto,'ç','c');
    SET texto = REPLACE(texto,'è','e');
    SET texto = REPLACE(texto,'é','e');
    SET texto = REPLACE(texto,'ê','e');
    SET texto = REPLACE(texto,'ë','e');
    SET texto = REPLACE(texto,'ì','i');
    SET texto = REPLACE(texto,'í','i');
    SET texto = REPLACE(texto,'î','i');
    SET texto = REPLACE(texto,'ï','i');
    SET texto = REPLACE(texto,'ð','o');
    SET texto = REPLACE(texto,'ñ','n');
    SET texto = REPLACE(texto,'ò','o');
    SET texto = REPLACE(texto,'ó','o');
    SET texto = REPLACE(texto,'ô','o');
    SET texto = REPLACE(texto,'õ','o');
    SET texto = REPLACE(texto,'ö','o');
    SET texto = REPLACE(texto,'ø','o');
    SET texto = REPLACE(texto,'ù','u');
    SET texto = REPLACE(texto,'ú','u');
    SET texto = REPLACE(texto,'û','u');
    SET texto = REPLACE(texto,'ý','y');
    SET texto = REPLACE(texto,'ý','y');
    SET texto = REPLACE(texto,'þ','b');
    SET texto = REPLACE(texto,'ÿ','y');
    SET texto = REPLACE(texto,'ƒ','f');
    SET texto = REPLACE(texto,'ç', 'c');
    SET texto = LOWER(texto);
    RETURN texto;
    END;

 Teste -  SELECT fn_remover_acento('árvore') AS texto_sem_acentos; 

----------------------------

- Validação de texto 

CREATE FUNCTION fn_valida_texto(texto VARCHAR(255), parametro INT)
    RETURNS BOOLEAN
    READS SQL DATA 
BEGIN
    DECLARE valor BOOLEAN;
    IF (LENGTH(TRIM(fn_remover_acento(texto)))) <= parametro THEN
        SET valor = 0;
        RETURN valor;
    ELSE
        SET valor = 1;
        RETURN valor;
    END IF;
END;
           
----------------------------

- Inserir novos dados  na tb_estado 


CREATE FUNCTION insert_tb_estado(nome VARCHAR(45), id_pais INT)
 RETURNS INT
  BEGIN
    DECLARE id INT;
    INSERT INTO tb_estado (nome, id_pais, dt_atualizacao) VALUES (nome, id_pais, CURDATE());
    SET id = LAST_INSERT_ID();
    RETURN id;
     END;

Teste-  SELECT insert_tb_estado('São Paulo', 1); 

----------------------------

- Inserir novos dados validados na tb_ator

CREATE FUNCTION insert_tb_ator(nome VARCHAR(45), sobrenome VARCHAR(45), dt_nascimento DATE, foto VARCHAR(255))
 RETURNS INT
  BEGIN
    DECLARE id INT;
    INSERT INTO tb_ator (nome, sobrenome, dt_nascimento, foto, dt_atualizacao) VALUES (nome, sobrenome, dt_nascimento, foto, CURDATE());
    SET id = LAST_INSERT_ID();
    RETURN id;
     END;

----------------------------

- Inserir novos dados validados na tb_plano

 CREATE FUNCTION insert_tb_plano(nome VARCHAR(45), valor FLOAT, descricao VARCHAR(255))
  RETURNS INT
  BEGIN
    DECLARE id INT;
    INSERT INTO tb_plano (nome, valor, descricao, dt_atualizacao) VALUES (nome, valor, descricao, CURDATE());
    SET id = LAST_INSERT_ID();
    RETURN id;
    END;

----------------------------
- Inserir novos dados validados na tb_tipo_pag

 CREATE FUNCTION insert_tb_tipo_pag(categoria VARCHAR(30))
 RETURNS INT
  BEGIN
    DECLARE id INT;
    INSERT INTO tb_tipo_pag (categoria, dt_atualizacao) VALUES (categoria, CURDATE());
    SET id = LAST_INSERT_ID();
    RETURN id;
    END;
----------------------------
- Inserir novos dados validados na tb_ator

 CREATE FUNCTION insert_tb_idioma(nome VARCHAR(60))
  RETURNS INT
   BEGIN
    DECLARE id INT;
    INSERT INTO tb_idioma (nome, dt_atualizacao) VALUES (nome, CURDATE());
    SET id = LAST_INSERT_ID();
    RETURN id;
      END;

----------------------------
- Inserir novos dados validados na tb_categoria

 CREATE FUNCTION insert_tb_categoria(nome VARCHAR(60))
  RETURNS INT
   BEGIN
    DECLARE id INT;
    INSERT INTO tb_categoria (nome, dt_atualizacao) VALUES (nome, CURDATE());
    SET id = LAST_INSERT_ID();
    RETURN id;
     END;

----------------------------

- Function para atualizar foto do perfil do usuario 
 CREATE FUNCTION update_foto_perfil(id_perfil INT, nova_foto LONGBLOB)
  RETURNS BOOLEAN
   BEGIN
    DECLARE rows_affected INT;

    UPDATE tb_perfil
    SET foto = nova_foto, dt_atualizacao = CURDATE()
    WHERE id_perfil = id_perfil;

    SET rows_affected = ROW_COUNT();

    IF rows_affected > 0 THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
    END;

----------------------------

- Atualiza nome do perfil do usuario

 CREATE FUNCTION update_nome_perfil(id_perfil INT, novo_nome VARCHAR(45))
  RETURNS BOOLEAN
   BEGIN
    DECLARE rows_affected INT;

    UPDATE tb_perfil
    SET nome = novo_nome, dt_atualizacao = CURDATE()
    WHERE id_perfil = id_perfil;

    SET rows_affected = ROW_COUNT();

    IF rows_affected > 0 THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
 END;

----------------------------


<div align=center>

## Procedures
</div>

- Procedure para obter detalhes do catalogo 

CREATE PROCEDURE sp_ObterDetalhesCatalogo (
  IN p_catalogo_id INT,
  OUT p_titulo VARCHAR(45),
  OUT p_ano_lancamento YEAR,
  OUT p_duracao TIME,
  OUT p_descricao VARCHAR(255),
  OUT p_imagem_capa VARCHAR(200),
  OUT p_avaliacao ENUM('1', '2', '3', '4', '5'),
  OUT p_id_classind INT,
  OUT p_id_idioma INT
)
BEGIN
  SELECT titulo, ano_lancamento, duracao, descricao, imagem_capa, avaliacao, id_classind, id_idioma
  INTO p_titulo, p_ano_lancamento, p_duracao, p_descricao, p_imagem_capa, p_avaliacao, p_id_classind, p_id_idioma
  FROM tb_catalogo
  WHERE catalogo_id = p_catalogo_id;

  IF p_titulo IS NULL THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Falha ao obter detalhes do catálogo. Catálogo não encontrado.';
  END IF;
END;
-- teste --

SET @titulo = '';
SET @ano_lancamento = NULL;
SET @duracao = NULL;
SET @descricao = '';
SET @imagem_capa = '';
SET @avaliacao = '';
SET @id_classind = NULL;
SET @id_idioma = NULL;

CALL sp_ObterDetalhesCatalogo(1, @titulo, @ano_lancamento, @duracao, @descricao, @imagem_capa, @avaliacao, @id_classind, @id_idioma);

SELECT @titulo, @ano_lancamento, @duracao, @descricao, @imagem_capa, @avaliacao, @id_classind, @id_idioma;

----------------------------

- inserir filme para inserir filme, caso não, retornar uma mensagem de erro  

CREATE PROCEDURE sp_InsertFilme (
  IN p_id_catalogo INT,
  IN p_oscar ENUM('sim', 'nao')
)
BEGIN
  DECLARE rows_affected INT;

  START TRANSACTION;

  INSERT INTO tb_filme (id_catalogo, oscar, dt_atualizacao)
  VALUES (p_id_catalogo, p_oscar, CURDATE());

  SET rows_affected = ROW_COUNT();

  IF rows_affected = 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Falha ao inserir filme. Não foi possível inserir o registro.';
  END IF;

  COMMIT;
END;

-- teste -- 

CALL sp_InsertFilme(65, 'a');

----------------------------

-- procedure para cliente inserir cliente, caso não esteja dentro dos padrões, retornar  msg de erro 

CREATE PROCEDURE sp_InsertCliente (
  IN p_id_usuario INT,
  IN p_id_plano INT,
  IN p_dt_vencimento_plano DATE
)
BEGIN
  DECLARE error_msg VARCHAR(255) DEFAULT NULL;
  
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
  BEGIN
    GET DIAGNOSTICS CONDITION 1 error_msg = MESSAGE_TEXT;
  END;
  
  START TRANSACTION;
  
  INSERT INTO tb_cliente (id_usuario, id_plano, dt_vencimento_plano, dt_atualizacao)
  VALUES (p_id_usuario, p_id_plano, p_dt_vencimento_plano, CURDATE());
  
  IF error_msg IS NULL THEN
    COMMIT;
  ELSE
    ROLLBACK;
    SELECT error_msg AS 'Erro ao inserir cliente';
  END IF;
  
END;

CALL sp_InsertCliente(1, 1, '2023-06-30');

----------------------------

-- procedure de atualização de  catalogo, caso não esteja dentro dos padrões, retornar  msg de erro 

CREATE PROCEDURE sp_AtualizarAvaliacaoCatalogo (
  IN p_id_catalogo INT,
  IN p_avaliacao ENUM('1', '2', '3', '4', '5')
)
BEGIN
  DECLARE rows_affected INT;

  UPDATE tb_catalogo
  SET avaliacao = p_avaliacao, dt_atualizacao = CURDATE()
  WHERE id_catalogo = p_id_catalogo;

  SET rows_affected = ROW_COUNT();

  IF rows_affected = 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Falha ao atualizar a avaliação do catálogo. Catálogo não encontrado.';
  END IF;
END;

-- teste de erro --

 CALL sp_AtualizarAvaliacaoCatalogo(5, '4');


----------------------------

- procedure de exclusão de item, caso não esteja dentro dos padrões, retornar  msg de erro 

CREATE PROCEDURE sp_ExcluirItemCatalogo (
  IN p_catalogo_id INT
)
BEGIN
  DECLARE rows_affected INT;

  DELETE FROM tb_catalogo
  WHERE id_catalogo = p_catalogo_id;

  SET rows_affected = ROW_COUNT();

  IF rows_affected = 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Falha ao excluir item do catálogo. Item não encontrado.';
  END IF;
END;

-- CALL sp_ExcluirItemCatalogo(1); --

----------------------------

- procedure para buscar titulos do catalogo, caso não esteja dentro dos padrões, retornar  msg de erro 


CREATE PROCEDURE sp_BuscarPorTitulo1 (
  IN p_titulo VARCHAR(100)
)
BEGIN
  DECLARE num_registros INT;

  SELECT COUNT(*) INTO num_registros
  FROM tb_catalogo
  WHERE titulo LIKE CONCAT('%', p_titulo, '%');

  IF num_registros > 0 THEN
    SELECT *
    FROM tb_catalogo
    WHERE titulo LIKE CONCAT('%', p_titulo, '%');
  ELSE
    SELECT 'Nenhum título encontrado no catálogo.' AS mensagem;
  END IF;
END;

----------------------------

- procedure para atualizar catalogo, caso não esteja dentro dos padrões, retornar  msg de erro -- 

CREATE PROCEDURE UpdateCatalogo(
    IN p_id INT,
    IN p_titulo VARCHAR(45),
    IN p_ano_lancamento YEAR(4),
    IN p_duracao TIME,
    IN p_descricao VARCHAR(255),
    IN p_imagem_capa VARCHAR(200),
    IN p_avaliacao ENUM('1', '2', '3', '4', '5'),
    IN p_id_classind INT,
    IN p_id_idioma INT
)
BEGIN
    DECLARE error_message VARCHAR(250) DEFAULT '';

    
    BEGIN
       
        UPDATE tb_catalogo
        SET titulo = p_titulo, ano_lancamento = p_ano_lancamento, duracao = p_duracao,
            descricao = p_descricao, imagem_capa = p_imagem_capa, avaliacao = p_avaliacao,
            id_classind = p_id_classind, id_idioma = p_id_idioma, dt_atualizacao = CURDATE()
        WHERE id_catalogo = p_id;

       
        IF ROW_COUNT() = 0 THEN
            SET error_message = 'Nenhum registro encontrado para atualização.';
        END IF;
    END;


    BEGIN
        IF error_message <> '' THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = error_message;
        END IF;
    END;
end;

----------------------------

- Procedure de exclusão de temporada, caso não esteja dentro dos padrões, retornar  msg de erro -- 


CREATE PROCEDURE sp_delete_temporada(valor_id INT)
BEGIN
	IF NOT EXISTS
		(SELECT id_temporada FROM tb_temporada WHERE id_temporada = valor_id) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT =  'ID invalido';
    ELSE
		DELETE FROM tb_temporada
		WHERE id_temporada = valor_id;
	END IF;
END;

----------------------------

- procedure de inserir de temporada, caso não esteja dentro dos padrões, retornar  msg de erro -- 


CREATE PROCEDURE sp_insert_temporada(
    v_titulo VARCHAR(45),
    id_da_serie INT,
    v_descricao VARCHAR(255),
    qtd_de_episodio TINYINT
)
BEGIN
    IF (v_titulo IS NULL) OR (fn_valida_texto(v_titulo, 0)) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'titulo invalido';
    ELSEIF NOT EXISTS (SELECT id_serie FROM tb_serie WHERE id_serie = id_da_serie) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ID_serie invalido';
    ELSEIF (v_descricao IS NULL) OR (fn_valida_texto(v_descricao, 0)) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'descricao invalido';
    ELSEIF qtd_de_episodio NOT BETWEEN 1 AND 50 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Numero de episodios invalido';
    ELSE
        INSERT INTO tb_temporada
            (titulo, id_serie, descricao, qtd_episodio, dt_atualizacao)
        VALUES
            (LOWER(v_titulo), id_da_serie, LOWER(v_descricao), qtd_de_episodio, CURDATE());
    END IF;
END;

----------------------------

- procedure de inserir serie, caso não esteja dentro dos padrões, retornar  msg de erro -- 
CREATE PROCEDURE sp_insert_serie(v_titulo VARCHAR(45), qtd_de_temporadas TINYINT, qtd_do_episodios TINYINT, id_do_catalogo INT)
BEGIN
	IF
		(v_titulo IS NULL ) OR (fn_valida_texto(v_titulo, 0)) = 0 THEN 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT =  'nome invalido';
	ELSEIF
		qtd_de_temporadas NOT BETWEEN 1 AND 50 THEN                                         
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT =  'Numero de temporadas invalido';
	ELSEIF
		qtd_do_episodios NOT BETWEEN 1 AND 50 THEN                                         
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT =  'Numero de episodios invalido';
	ELSE
			INSERT INTO tb_serie
			(titulo, qtd_temporadas, qtd_episodios, id_catalogo, dt_atualizacao)
			VALUES
			(LOWER(v_titulo), qtd_de_temporadas, qtd_do_episodios, id_do_catalogo, CURDATE());
	END IF;
END;


----------------------------

- procedure de inserir elenco, caso não esteja dentro dos padrões, retornar  msg de erro -- 


CREATE PROCEDURE sp_insert_elenco(
    id_do_catalogo INT,
    id_do_ator INT
)
BEGIN
    DECLARE error_message VARCHAR(250) DEFAULT '';

        IF NOT EXISTS (SELECT id_catalogo FROM tb_catalogo WHERE id_catalogo = id_do_catalogo) THEN
        SET error_message = 'ID_catalogo invalido';
    
    ELSEIF NOT EXISTS (SELECT id_ator FROM tb_ator WHERE id_ator = id_do_ator) THEN
        SET error_message = 'ID_ator invalido';
    
    ELSE
        BEGIN
            INSERT INTO tb_elenco (id_catalogo, id_ator, dt_atualizacao)
            VALUES (id_do_catalogo, id_do_ator, CURDATE());
        END;
    END IF;

   
    IF error_message <> '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = error_message;
    END IF;
END;

----------------------------

- procedure de deletar elenco, caso não esteja dentro dos padrões, retornar  msg de erro -- 



CREATE PROCEDURE sp_delete_elenco(
    id_do_catalogo INT,
    id_do_ator INT
)
BEGIN
    DECLARE error_message VARCHAR(250) DEFAULT '';

       IF NOT EXISTS (SELECT id_catalogo FROM tb_catalogo WHERE id_catalogo = id_do_catalogo) THEN
        SET error_message = 'ID_catalogo invalido';
    
    ELSEIF NOT EXISTS (SELECT id_ator FROM tb_ator WHERE id_ator = id_do_ator) THEN
        SET error_message = 'ID_ator invalido';
   
    ELSE
        BEGIN
            DELETE FROM tb_elenco
            WHERE id_catalogo = id_do_catalogo AND id_ator = id_do_ator;
        END;
    END IF;

  
    IF error_message <> '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = error_message;
    END IF;
END;

----------------------------

- procedure fazer update do elenco, caso não esteja dentro dos padrões, retornar  msg de erro -- 

CREATE PROCEDURE sp_update_elenco(
    id_do_catalogo INT,
    id_do_ator INT,
    novo_id_do_catalogo INT,
    novo_id_do_ator INT
)
BEGIN
    DECLARE error_message VARCHAR(250) DEFAULT '';

    
    IF NOT EXISTS (SELECT id_catalogo FROM tb_catalogo WHERE id_catalogo = id_do_catalogo) THEN
        SET error_message = 'ID_catalogo invalido';
  
    ELSEIF NOT EXISTS (SELECT id_ator FROM tb_ator WHERE id_ator = id_do_ator) THEN
        SET error_message = 'ID_ator invalido';
 
    ELSEIF NOT EXISTS (SELECT id_catalogo FROM tb_catalogo WHERE id_catalogo = novo_id_do_catalogo) THEN
        SET error_message = 'Novo ID_catalogo invalido';
  
    ELSEIF NOT EXISTS (SELECT id_ator FROM tb_ator WHERE id_ator = novo_id_do_ator) THEN
        SET error_message = 'Novo ID_ator invalido';
    
    ELSE
        BEGIN
            UPDATE tb_elenco
            SET id_catalogo = novo_id_do_catalogo, id_ator = novo_id_do_ator, dt_atualizacao = CURDATE()
            WHERE id_catalogo = id_do_catalogo AND id_ator = id_do_ator;
        END;
    END IF;

    IF error_message <> '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = error_message;
    END IF;
END;


- procedure de inserir pagamento (fazer a venda), caso não esteja dentro dos padrões, retornar  msg de erro -- 


CREATE PROCEDURE sp_insert_pagamento(
    valor_p FLOAT,
    data_pagamento DATETIME,
    id_do_cartao_credito INT,
    id_do_cliente INT,
    id_do_tipo_pagamento INT
)
BEGIN
    DECLARE error_message VARCHAR(250) DEFAULT '';

        IF (valor_p IS NULL) OR (valor_p < 20.00 OR valor_p > 100.00) THEN
        SET error_message = 'Valor fora de parâmetro';
        ELSEIF (data_pagamento IS NULL) OR (data_pagamento > CURDATE()) THEN
        SET error_message = 'Data de pagamento inválida';
        ELSEIF NOT EXISTS (SELECT id_cartao_credito FROM tb_cartao_credito WHERE id_cartao_credito = id_do_cartao_credito) THEN
        SET error_message = 'ID_cartao_credito inválido';
        ELSEIF NOT EXISTS (SELECT id_cliente FROM tb_cliente WHERE id_cliente = id_do_cliente) THEN
        SET error_message = 'ID_cliente inválido';
       ELSEIF NOT EXISTS (SELECT id_tipo_pag FROM tb_tipo_pag WHERE id_tipo_pag = id_do_tipo_pag) THEN
        SET error_message = 'ID_tipo_pagamento inválido';
        ELSE
        BEGIN
            INSERT INTO tb_pagamento (valor, dt_pagamento, id_cartao_credito, id_cliente, id_tipo_pag, dt_atualizacao)
            VALUES (valor_p, data_pagamento, id_do_cartao_credito, id_do_cliente, id_do_tipo_pag, CURDATE());
        END;
    END IF;

        IF error_message <> '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = error_message;
    ELSE
        SELECT 'Pagamento realizada com sucesso' AS 'Mensagem';
    END IF;
END;
----------------------------

- procedure de atualizar pagamento (venda), caso não esteja dentro dos padrões, retornar  msg de erro --

CREATE PROCEDURE sp_update_pagamento(
    id_do_pagamento INT,
    novo_valor FLOAT,
    nova_data_pagamento DATETIME,
    novo_id_do_cartao_credito INT,
    novo_id_do_cliente INT,
    novo_id_do_tipo_pagamento INT
)
BEGIN
    DECLARE error_message VARCHAR(250) DEFAULT '';

  
    IF NOT EXISTS (SELECT id_pagamento FROM tb_pagamento WHERE id_pagamento = id_do_pagamento) THEN
        SET error_message = 'ID_pagamento inválido';
   
    ELSEIF (novo_valor IS NULL) OR (novo_valor < 20.00 OR novo_valor > 100.00) THEN
        SET error_message = 'Novo valor fora de parâmetro';

    ELSEIF (nova_data_pagamento IS NULL) OR (nova_data_pagamento > CURDATE()) THEN
        SET error_message = 'Nova data de pagamento inválida';
    
    ELSEIF NOT EXISTS (SELECT id_cartao_credito FROM tb_cartao_credito WHERE id_cartao_credito = novo_id_do_cartao_credito) THEN
        SET error_message = 'Novo ID_cartao_credito inválido';

    ELSEIF NOT EXISTS (SELECT id_cliente FROM tb_cliente WHERE id_cliente = novo_id_do_cliente) THEN
        SET error_message = 'Novo ID_cliente inválido';
   
    ELSEIF NOT EXISTS (SELECT id_tipo_pag FROM tb_tipo_pag WHERE id_tipo_pag = novo_id_do_tipo_pagamento) THEN
        SET error_message = 'Novo ID_tipo_pagamento inválido';
   
        BEGIN
            UPDATE tb_pagamento
            SET valor = novo_valor,
                dt_pagamento = nova_data_pagamento,
                id_cartao_credito = novo_id_do_cartao_credito,
                id_cliente = novo_id_do_cliente,
                id_tipo_pag = novo_id_do_tipo_pagamento,
                dt_atualizacao = CURDATE()
            WHERE id_pag = id_do_pagamento;
        END;
    END IF;

      IF error_message <> '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = error_message;
    ELSE
        SELECT 'Atualização de pagamento realizada com sucesso' AS 'Mensagem';
    END IF;
END; 

----------------------------

- procedure de deletar pagamento (fazer estorno\cancelar venda), caso não esteja dentro dos padrões, retornar  msg de erro -- 


CREATE PROCEDURE sp_delete_pagamento(id_do_pagamento INT)
BEGIN
    DECLARE error_message VARCHAR(250) DEFAULT '';

        IF NOT EXISTS (SELECT id_pagamento FROM tb_pagamento WHERE id_pagamento = id_do_pagamento) THEN
        SET error_message = 'ID_pagamento inválido';
    
    ELSE
        BEGIN
            DELETE FROM tb_pagamento WHERE id_pagamento = id_do_pagamento;
        END;
    END IF;

    
    IF error_message <> '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = error_message;
    ELSE
        SELECT 'Exclusão de pagamento realizada com sucesso' AS 'Mensagem';
    END IF;
END;

----------------------------

- procedure de apagar cliente, caso não esteja dentro dos padrões, retornar  msg de erro -- 


CREATE PROCEDURE sp_delete_cliente(valor_id INT)
BEGIN
	IF NOT EXISTS
		(SELECT id_cliente FROM tb_cliente WHERE id_cliente = valor_id) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT =  'ID invalido';
    ELSE
		DELETE FROM  tb_cliente
		WHERE id_cliente = valor_id;
	END IF;
END;

----------------------------

- procedure de atualizar dados do cliente, caso não esteja dentro dos padrões, retornar  msg de erro -- 

CREATE PROCEDURE sp_update_cliente(valor_id INT, id_do_usuario INT, id_do_plano INT, vencimento_plano DATE)
	BEGIN
		IF NOT EXISTS
			(SELECT id_cliente FROM tb_cliente WHERE id_cliente = valor_id) THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT =  'ID_cliente invalido';
		ELSEIF NOT EXISTS
			(SELECT id_usuario FROM tb_usuario WHERE id_usuario = id_do_usuario) THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT =  'ID_usuario invalido';
		ELSEIF NOT EXISTS
			(SELECT id_plano FROM tb_plano WHERE id_plano = id_do_plano) THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT =  'ID_plano invalido';
		ELSEIF
			(vencimento_plano IS NULL) OR (vencimento_plano < DATE_ADD(CURDATE(), INTERVAL 30 DAY)) THEN 
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT =  'data de vencimento do plano invalida';
		ELSE
			UPDATE tb_cliente SET id_do_usuario = id_usuario, id_do_plano = id_plano, vencimento_plano = dt_vencimento_plano, dt_atualizacao = CURDATE()
			WHERE id_cliente = valor_id;
		END IF;
    END;

----------------------------
   
   - procedure de inserir dados do cliente, caso não esteja dentro dos padrões, retornar  msg de erro -- 
   
   CREATE PROCEDURE sp_insert_cliente(id_do_usuario INT, id_do_plano INT, vencimento_plano DATE)
BEGIN
	IF NOT EXISTS
		(SELECT id_usuario FROM tb_usuario WHERE id_usuario = id_do_usuario) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT =  'ID_usuario invalido';
	ELSEIF NOT EXISTS
		(SELECT id_plano FROM tb_plano WHERE id_plano = id_do_plano) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT =  'ID_plano invalido';
	ELSEIF
		(vencimento_plano IS NULL) OR (vencimento_plano < DATE_ADD(CURDATE(), INTERVAL 30 DAY)) THEN 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT =  'data de vencimento do plano invalida';
	ELSE
		INSERT INTO tb_cliente
		(id_usuario, id_plano, dt_vencimento_plano, dt_atualizacao)
		VALUES
		(id_do_usuario, id_do_plano, vencimento_plano, CURDATE());
    END IF;
 END;


----------------------------

- procedure de inserir dados do funcionario, caso não esteja dentro dos padrões, retornar  msg de erro -- 


CREATE PROCEDURE sp_insert_funcionario(id_do_usuario INT, foto_usuario VARCHAR(255))
	BEGIN
		IF NOT EXISTS
			(SELECT id_usuario FROM tb_usuario WHERE id_usuario = id_do_usuario) THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT =  'ID_usuario invalido';
		ELSEIF
			(foto_usuario IS NULL ) OR (fn_valida_texto(foto_usuario, 5)) = 0 THEN 
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT =  'Link da foto invalido';
		ELSE
			INSERT INTO tb_funcionario
            (id_usuario, foto, data_atualizacao)
            VALUES
            (id_do_usuario, foto_usuario, CURDATE());
		END IF;
	END;
	
	----------------------------
- procedure de atualizar dados do funcionario, caso não esteja dentro dos padrões, retornar  msg de erro -- 

CREATE PROCEDURE sp_update_funcionario(valor_id INT, id_do_usuario INT, foto_usuario VARCHAR(255))
	BEGIN
		IF NOT EXISTS
			(SELECT id_funcionario FROM tb_funcionario WHERE id_funcionario = valor_id) THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT =  'ID_funcionario invalido';
		ELSEIF NOT EXISTS
			(SELECT id_usuario FROM tb_usuario WHERE id_usuario = id_do_usuario) THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT =  'ID_usuario invalido';
		ELSEIF
			(foto_usuario IS NULL ) OR (fn_valida_texto(foto_usuario, 5)) = 0 THEN 
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT =  'Link da foto invalido';
		ELSE
			UPDATE tb_funcionario SET id_usuario = id_do_usuario,foto = foto_usuario, dt_atualizacao = CURDATE()
			WHERE id_funcionario = valor_id;
		END IF;
    END;
    
	----------------------------
   - procedure de apagar dados do funcionario, caso não esteja dentro dos padrões, retornar  msg de erro -- 

   
   CREATE PROCEDURE sp_delete_funcionario(valor_id INT)
BEGIN
	IF NOT EXISTS
		(SELECT id_funcionario FROM tb_funcionario WHERE id_funcionario = valor_id) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT =  'ID invalido';
    ELSE
		DELETE FROM  tb_funcionario
		WHERE id_funcionario = valor_id;
	END IF;
END;

----------------------------

 - procedure de inserir dados do usuario, caso não esteja dentro dos padrões, retornar  msg de erro -- 

CREATE PROCEDURE sp_insert_usuario(
    p_nome VARCHAR(45),
    p_sobrenome VARCHAR(45),
    p_email VARCHAR(45),
    p_dt_nascimento DATE,
    p_dt_cadastro DATE,
    p_senha VARCHAR(255),
    p_status BOOLEAN,
    p_id_endereco INT
)
BEGIN
    DECLARE error_message VARCHAR(250) DEFAULT '';

    
    IF NOT EXISTS (SELECT id_endereco FROM tb_endereco WHERE id_endereco = p_id_endereco) THEN
        SET error_message = 'ID_endereco inválido.';
    ELSE
       
        INSERT INTO tb_usuario (nome, sobrenome, email, dt_nascimento, dt_cadastro, senha, status, id_endereco, dt_atualizacao)
        VALUES (p_nome, p_sobrenome, p_email, p_dt_nascimento, p_dt_cadastro, p_senha, p_status, p_id_endereco, CURDATE());

       
        IF ROW_COUNT() = 0 THEN
            SET error_message = 'Falha ao inserir o usuário.';
        END IF;
    END IF;

   
    IF error_message <> '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = error_message;
    ELSE
        SELECT 'Inserção de usuário realizada com sucesso.' AS 'Mensagem';
    END IF;
END;


-------------------------------

- procedure de apagar dados do usuario, caso não esteja dentro dos padrões, retornar  msg de erro --

CREATE PROCEDURE sp_delete_usuario(
    p_id INT
)
BEGIN
    DECLARE error_message VARCHAR(250) DEFAULT '';

    
    IF NOT EXISTS (SELECT id_usuario FROM tb_usuario WHERE id_usuario = p_id) THEN
        SET error_message = 'ID de usuário inválido.';
    ELSE
        
        DELETE FROM tb_usuario WHERE id_usuario = p_id;
        
        
        IF ROW_COUNT() = 0 THEN
            SET error_message = 'Falha ao deletar o usuário.';
        END IF;
    END IF;

    
    IF error_message <> '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = error_message;
    ELSE
        SELECT 'Exclusão de usuário realizada com sucesso.' AS 'Mensagem';
    END IF;
END;


------------------------------- 

- procedure de atualizar dados do usuario, caso não esteja dentro dos padrões, retornar  msg de erro --



CREATE PROCEDURE sp_update_usuario(
    p_id INT,
    p_nome VARCHAR(45),
    p_sobrenome VARCHAR(45),
    p_email VARCHAR(45),
    p_dt_nascimento DATE,
    p_dt_cadastro DATE,
    p_senha VARCHAR(255),
    p_status BOOLEAN,
    p_id_endereco INT
)
BEGIN
    DECLARE error_message VARCHAR(250) DEFAULT ' ';

        IF NOT EXISTS (SELECT id_usuario FROM tb_usuario WHERE id_usuario = p_id) THEN
        SET error_message = 'ID de usuário inválido.';
    ELSE
        
        IF NOT EXISTS (SELECT id_endereco FROM tb_endereco WHERE id_endereco = p_id_endereco) THEN
            SET error_message = 'ID_endereco inválido.';
        ELSE
                        UPDATE tb_usuario
            SET nome = p_nome,
                sobrenome = p_sobrenome,
                email = p_email,
                dt_nascimento = p_dt_nascimento,
                dt_cadastro = p_dt_cadastro,
                senha = p_senha,
                status = p_status,
                id_endereco = p_id_endereco,
                dt_atualizacao = CURDATE()
            WHERE id_usuario = p_id;
            
                        IF ROW_COUNT() = 0 THEN
                SET error_message = 'Falha ao atualizar o usuário.';
            END IF;
        END IF;
    END IF;

        IF error_message <> '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = error_message;
    ELSE
        SELECT 'Atualização de usuário realizada com sucesso.' AS 'Mensagem';
    END IF;
	END;



<div align=center>

## Triggers
</div>

-  Trigger para que, antes da inserção de um cliente, sejam verificadas se há nulidade do campo do id do plano

CREATE TRIGGER before_insert_tb_cliente
BEFORE INSERT ON tb_cliente
FOR EACH ROW
BEGIN
    IF NEW.id_plano IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'O campo id_plano não pode ser nulo';
    END IF;
END;


------------------------------- 

- Trigger para que, após a atualização (novo id criado)  da tabela catálogo, caso não se escolha se na tabela filme se algum filme não teve oscar, automaticamente será colocado como 'sim'

CREATE TRIGGER after_update_tb_catalogo
AFTER UPDATE ON tb_catalogo
FOR EACH ROW
BEGIN
    IF NEW.avaliacao IS NOT NULL THEN
        UPDATE tb_filme SET oscar = 'sim' WHERE id_catalogo = NEW.id_catalogo;
    END IF;
END;


------------------------------- 

- Sempre que uma linha na tabela "tb_usuario" for atualizada, um registro será inserido na tabela "tb_usuario_audit" com o ID do usuário antigo e a data/hora da atualização. 

CREATE TRIGGER after_update_tb_usuario
AFTER UPDATE ON tb_usuario
FOR EACH ROW
BEGIN
    INSERT INTO tb_usuario_audit (id_usuario, dt_atualizacao)
    VALUES (OLD.id_usuario, NOW());
END;

------------------------------- 
- Quando um novo cartão de crédito é inserido na tabela 
"tb_cartao_credito", atualiza-se a data de vencimento do plano do cliente correspondente na tabela "tb_cliente" com base na data de vencimento fornecida

CREATE TRIGGER after_insert_tb_cartao_credito
AFTER INSERT ON tb_cartao_credito
FOR EACH ROW
BEGIN
    UPDATE tb_cliente SET dt_vencimento_plano = NEW.data_vencimento WHERE id_cliente = NEW.id_cliente;
   
   END; 

   ------------------------------- 

- Sempre que uma atualização é realizada na tabela "tb_catalogo", atualiza-se para a data atual antes da execução do update mostrando momento exato da última modificação feita no registro.
   
   CREATE TRIGGER before_update_tb_catalogo
BEFORE UPDATE ON tb_catalogo
FOR EACH ROW
BEGIN
    SET NEW.dt_atualizacao = CURRENT_DATE();
END; 

------------------------------- 

- Após a exclusão de um registro da tabela "tb_cliente", os registros relacionados nas tabelas "tb_pagamento" e "tb_perfil" também serão removidos 

CREATE TRIGGER after_delete_tb_cliente
AFTER DELETE ON tb_cliente
FOR EACH ROW
BEGIN
    DELETE FROM tb_pagamento WHERE id_cliente = OLD.id_cliente;
    DELETE FROM tb_perfil WHERE id_cliente = OLD.id_cliente;
   
END; 

------------------------------- 

- Tal trigger garante que não seja excluida uma categoria.

CREATE TRIGGER before_delete_tb_categoria
BEFORE DELETE ON tb_categoria
FOR EACH ROW
BEGIN
    IF OLD.nome = 'Ação' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Não é permitido excluir a categoria de Ação.';
    END IF;
END;

------------------------------- 

 - Sempre que uma linha na tabela "tb_catalogo" é atualizada, 
  é registrado uma entrada no histórico na tabela "tb_catalogo_historico" com os valores antigos do ID do catálogo,título e data de atualização

CREATE TRIGGER after_update_tb_catalogo
AFTER UPDATE ON tb_catalogo
FOR EACH ROW
BEGIN
    INSERT INTO tb_catalogo_historico (id_catalogo, titulo, dt_atualizacao) 
    VALUES (OLD.id_catalogo, OLD.titulo, OLD.dt_atualizacao);
END;

------------------------------- 

- Quando uma atualizaçao ocorre na tabela "tb_catalogo", é redefinida a data atual antes da execução do update. 

CREATE TRIGGER before_update_tb_catalogo
BEFORE UPDATE ON tb_catalogo
FOR EACH ROW
BEGIN
    SET NEW.dt_atualizacao = CURRENT_DATE();
END;

------------------------------- 

- Traz uma mensagem de aviso de novo cliente junto com o id e hora atual 

CREATE TRIGGER after_insert_tb_cliente
AFTER INSERT ON tb_cliente
FOR EACH ROW
BEGIN
    INSERT INTO tb_log (mensagem, dt_registro)
    VALUES ('Novo cliente cadastrado - ID: ' + CAST(NEW.id_cliente AS CHAR), CURRENT_TIMESTAMP());
END;

------------------------------- 

 - Atualiza a quantidade da tabela temporada quando é feito a inserção de um episódio
 
CREATE TRIGGER after_insert_tb_episodio
AFTER INSERT ON tb_episodio
FOR EACH ROW
BEGIN
    UPDATE tb_temporada
    SET qtd_episodio = qtd_episodio + 1
    WHERE id_temporada = NEW.id_temporada;
END;

------------------------------- 

 - Atualiza a quantidade da tabela temporada quando é feito a remoção de um episódio
CREATE TRIGGER after_delete_tb_episodio
AFTER DELETE ON tb_episodio
FOR EACH ROW
BEGIN
    UPDATE tb_temporada
    SET qtd_episodio = qtd_episodio - 1
    WHERE id_temporada = OLD.id_temporada;
END;



<div align=center>

## Scripts
</div>

|Scripts    |Clique aqui|
|-----------|-----------|
|DDL        |[Clique aqui](https://seulinkaqui.com)|
|Dados      |[Clique aqui](https://seulinkaqui.com)|
|Views      |[Clique aqui](https://seulinkaqui.com)|
|Funções    |[Clique aqui](https://seulinkaqui.com)|
|Procedures |[Clique aqui](https://seulinkaqui.com)|
|Triggers   |[Clique aqui](https://seulinkaqui.com)|
|Dumps      |[Clique aqui](https://seulinkaqui.com)|

<div align=center>

## Contatos

|  [![Linkedin](/img/icons8-linkedin-48.png)](https://seulinkaqui.com)| [![Instagram](/img/icons8-instagram-48.png)](https://seulinkaqui.com) |[![Email](/img/icons8-email-48.png)](https://seulinkaqui.com) | [![Portfolio](/img/icons8-portf%C3%B3lio-48.png)](https://seulinkaqui.com) |
|-----------|-----------|-----------|-----------|-----------|

</div>