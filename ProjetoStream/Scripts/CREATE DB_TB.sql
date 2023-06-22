CREATE DATABASE IF NOT EXISTS db_tvtupionline
COLLATE utf8mb4_general_ci CHARSET utf8mb4;

use db_tvtupionline;

CREATE TABLE IF NOT EXISTS tb_ClassInd (
	id_ClassInd INT PRIMARY KEY AUTO_INCREMENT,
	idade ENUM( 'livre' ,  '10' ,  '12' ,  '14' ,  '16' ,  '18' ) NOT NULL,
	descricao VARCHAR(100) NOT NULL,
	dt_atualizacao DATE NOT NULL,
 CONSTRAINT uq_idade UNIQUE (idade)
) AUTO_INCREMENT = 1;


CREATE TABLE IF NOT EXISTS tb_categoria(
	id_categoria INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(60) NOT NULL,
	dt_atualizacao DATE NOT NULL,
CONSTRAINT uq_nome_tb_categoria UNIQUE (nome) 
) AUTO_INCREMENT = 1;

CREATE TABLE IF NOT EXISTS tb_idioma (
	id_idioma INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(60) NOT NULL,
	dt_atualizacao DATE NOT NULL,
CONSTRAINT uq_nome_tb_idioma UNIQUE (nome)
)AUTO_INCREMENT = 1;

CREATE TABLE IF NOT EXISTS tb_tipo_pag(
	id_tipo_pag INT PRIMARY KEY AUTO_INCREMENT,
	categoria VARCHAR(30) NOT NULL,
    dt_atualizacao DATE NOT NULL,
CONSTRAINT uq_categoria_tb_tipo_pag UNIQUE (categoria)
) AUTO_INCREMENT = 1;

CREATE TABLE IF NOT EXISTS  tb_pais (
	id_pais  INT PRIMARY KEY AUTO_INCREMENT,
	nome  VARCHAR(45) NOT NULL,
	codigo  CHAR(3) NOT NULL,
	dt_atualizacao DATE NOT NULL,
CONSTRAINT uq_nome_tb_pais UNIQUE (nome),
CONSTRAINT uq_codigo_tb_pais UNIQUE (codigo)
) AUTO_INCREMENT = 1;

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


CREATE TABLE IF NOT EXISTS tb_ator(
	id_ator INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(45) NOT NULL,
	sobrenome VARCHAR(45) NOT NULL,
	dt_nascimento DATE NOT NULL,
	foto VARCHAR(255) NOT NULL,
	dt_atualizacao DATE NOT NULL,
CONSTRAINT uq_foto_tb_autor UNIQUE (foto)
) AUTO_INCREMENT = 1;


CREATE TABLE IF NOT EXISTS tb_elenco(
	id_catalogo INT NOT NULL,
	id_ator INT NOT NULL,
    dt_atualizacao DATE NOT NULL,
PRIMARY KEY(id_catalogo, id_ator),
CONSTRAINT fk_catalogo_tb_elenco FOREIGN KEY (id_catalogo) REFERENCES tb_catalogo(id_catalogo),
CONSTRAINT fk_ator_tb_elenco FOREIGN KEY (id_ator) REFERENCES tb_ator(id_ator)
);
 


CREATE TABLE IF NOT EXISTS  tb_estado(
	id_estado INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(45) NOT NULL,
	id_pais INT NOT NULL,
	dt_atualizacao DATE NOT NULL,
CONSTRAINT fk_id_pais FOREIGN KEY (id_pais) REFERENCES tb_pais(id_pais)
) AUTO_INCREMENT = 1;



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



CREATE TABLE IF NOT EXISTS tb_filme(
  id_filme INT PRIMARY KEY AUTO_INCREMENT,
  id_catalogo INT NOT NULL,
  oscar ENUM('sim', 'nao') DEFAULT NULL,
  dt_atualizacao DATE NOT NULL,
CONSTRAINT uq_id_catalogo_tb_filme UNIQUE tb_catalogo(id_catalogo)
) AUTO_INCREMENT = 1;


CREATE TABLE IF NOT EXISTS  tb_catalogo_idioma (
	id_catalogo  INT NOT NULL,
	id_idioma  INT NOT NULL,
	dt_atualizacao DATE NOT NULL,
PRIMARY KEY(id_catalogo, id_idioma),
CONSTRAINT fk_id_catalogo FOREIGN KEY (id_catalogo) REFERENCES tb_catalogo(id_catalogo),
CONSTRAINT fk_id_idioma FOREIGN KEY (id_idioma) REFERENCES tb_idioma(id_idioma)
);


CREATE TABLE IF NOT EXISTS tb_pais_catalogo(
	id_pais INT NOT NULL,
	id_catalogo INT NOT NULL,
	dt_atualizacao DATE NOT NULL,
PRIMARY KEY(id_pais, id_catalogo),
CONSTRAINT fk_id_pais_tb_pais_catalogo FOREIGN KEY (id_pais) REFERENCES tb_pais(id_pais),
CONSTRAINT fk_id_catalogo_tb_pais_catalogo FOREIGN KEY (id_catalogo) REFERENCES tb_catalogo(id_catalogo)
);


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

CREATE TABLE IF NOT EXISTS tb_funcionario(
	id INT PRIMARY KEY AUTO_INCREMENT,
	id_usuario INT NOT NULL,
	foto longblob NOT NULL,
	dt_atualizacao DATE NOT NULL,
CONSTRAINT uq_foto UNIQUE (foto),
CONSTRAINT uq_id_usuario_funcionario UNIQUE (id_usuario),
CONSTRAINT fk_id_usuario_funcionario FOREIGN KEY (id_usuario) REFERENCES tb_usuario(id_usuario)
) AUTO_INCREMENT = 1;



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

CREATE TABLE IF NOT EXISTS  tb_perfil( 
	id_perfil  INT PRIMARY KEY AUTO_INCREMENT,
	nome  VARCHAR(45) NOT NULL,
	foto longblob NOT NULL,
	tipo  ENUM('adulto','infantil') NOT NULL,
	id_cliente  INT NOT NULL,
	dt_atualizacao DATE NOT NULL,
CONSTRAINT fk_id_cliente_perfil FOREIGN KEY (id_cliente) REFERENCES tb_cliente(id_cliente)
) AUTO_INCREMENT = 1;
 
CREATE TABLE IF NOT EXISTS  tb_cartao_credito(
	numero CHAR(19) NOT NULL,
	data_vencimento DATE NOT NULL,
	cod_seguranca CHAR(3) NOT NULL,
	id_cliente INT NOT NULL,
	dt_atualizacao DATE NOT NULL,
CONSTRAINT id_cliente_tb_cartao FOREIGN KEY (id_cliente) REFERENCES tb_cliente(id_cliente)
) AUTO_INCREMENT = 1;

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


CREATE TABLE IF NOT EXISTS tb_catalogo_categoria(
	id_catalogo INT NOT NULL,
	id_categoria INT NOT NULL,
	dt_atualizacao DATE NOT NULL,
 PRIMARY KEY(id_catalogo, id_categoria),
 CONSTRAINT fk_id_catalogo_catalogo_categoria FOREIGN KEY (id_catalogo) REFERENCES tb_catalogo(id_catalogo),
 CONSTRAINT fk_id_categoria_catalogo_categoria FOREIGN KEY (id_categoria) REFERENCES tb_categoria(id_categoria)
 );


CREATE TABLE IF NOT EXISTS tb_artista(
	id_catalogo INT NOT NULL,
	id_ator INT NOT NULL,
    dt_atualizacao DATE NOT NULL,
PRIMARY KEY(id_catalogo, id_ator),
CONSTRAINT fk_catalogo_artista FOREIGN KEY (id_catalogo) REFERENCES tb_catalogo(id_catalogo),
CONSTRAINT fk_ator_artista FOREIGN KEY (id_ator) REFERENCES tb_ator(id_ator)
);
 


CREATE TABLE IF NOT EXISTS tb_serie(
	id_serie INT PRIMARY KEY AUTO_INCREMENT,
	id_catalogo INT NOT NULL,
	qtd_temporadas TINYINT NOT NULL,
	qtd_episodios TINYINT NOT NULL,
    dt_atualizacao DATE NOT NULL,
CONSTRAINT uq_id_catalogo UNIQUE (id_catalogo),
CONSTRAINT fk_catalogo_tb_serie FOREIGN KEY (id_catalogo) REFERENCES tb_catalogo(id_catalogo)
) AUTO_INCREMENT = 1;
 


CREATE TABLE IF NOT EXISTS tb_temporada(
  id_temporada INT PRIMARY KEY AUTO_INCREMENT,
  titulo  VARCHAR(45) NOT NULL,
  id_serie  INT NOT NULL,
  descricao  VARCHAR(255) NOT NULL,
  qtd_episodio  TINYINT NOT NULL,
  dt_atualizacao DATE NOT NULL,
CONSTRAINT fk_id_serie_temporada FOREIGN KEY (id_serie) REFERENCES tb_serie(id_serie)
) AUTO_INCREMENT = 1;



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
