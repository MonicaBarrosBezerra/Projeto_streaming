
 INSERT INTO tb_classind (idade, descricao, dt_atualizacao)
VALUES
	 ('Livre', 'Livre para todos os públicos', CURDATE()),
    ('10', 'Recomendado para maiores de 10 anos', CURDATE()),
    ('12', 'Recomendado para maiores de 12 anos', CURDATE()),
    ('14', 'Recomendado para maiores de 14 anos', CURDATE()),
    ('16', 'Recomendado para maiores de 16 anos', CURDATE()),
    ('18', 'Recomendado para maiores de 18 anos', CURDATE());
   
   INSERT INTO tb_categoria
(nome, dt_atualizacao)
VALUES 
('Suspense', CURDATE()),
('Ficção', CURDATE()),
('Terror', CURDATE()),
('Nacional', CURDATE()),
('Drama', CURDATE()),
('Comedia', CURDATE());


INSERT INTO tb_idioma 
(nome, dt_atualizacao)
VALUES
('português', CURDATE()),
('inglês', CURDATE()),
('espanhol', CURDATE()),
('coreano', CURDATE()),
('japones', CURDATE());
   

INSERT INTO tb_tipo_pag
(categoria, dt_atualizacao)
VALUES
('cartão', CURDATE()),
('pix', CURDATE()),
('boleto', CURDATE()),
('deposito bancario', CURDATE());


INSERT INTO tb_plano (nome, valor, descricao, dt_atualizacao)
VALUES
    ('Plano Básico', 9.99, 'Acesso básico a filmes e séries', CURDATE()),
    ('Plano Padrão', 14.99, 'Acesso em qualidade HD', CURDATE()),
    ('Plano Premium', 19.99, 'Acesso em qualidade Ultra HD e suporte a múltiplos dispositivos', CURDATE());
   
   
   INSERT INTO tb_ator (nome, sobrenome, dt_nascimento, foto, dt_atualizacao)
VALUES ('Ellen', 'Page', '1987-02-21', 'https://shorturl.at/fltH5', CURDATE()),
 ('Neil Patrick', 'Harris', '1973-06-15', 'https://shorturl.at/fjnoQ', CURDATE()),
('Janelle', 'Monáe', '1985-12-01', 'https://shorturl.at/degZ7', CURDATE()),
('Laverne', 'Cox', '1972-05-29', 'https://shorturl.at/hGKLN', CURDATE()), 
('Billy', 'Porter', '1969-09-21', 'https://shorturl.at/zKNV9', CURDATE());

INSERT INTO tb_estado
(nome, id_pais, dt_atualizacao)
values
('tóquio','4', CURDATE()),
('seoul', '5', CURDATE()),
('brasilia','1', CURDATE()),
('madri', '3', CURDATE()),
('washington', '2', CURDATE());

 
INSERT INTO tb_catalogo
(titulo, ano_lancamento, duracao, descricao, imagem_capa, avaliacao,  id_classind , id_idioma, dt_atualizacao)
VALUES
("Parasita", 2019, "02:12:00", "Uma família pobre começa a trabalhar para uma família rica, mas segredos obscuros surgem.", "https://exemplo.com/parasita.jpg", 4, 16, 3, CURDATE()),
("Interestelar", 2014, "02:49:00", "Um grupo de exploradores viaja através de um buraco de minhoca em busca de um novo planeta habitável.", "https://exemplo.com/interestelar.jpg", 5, 12, 1, CURDATE()),
("Cidade de Deus", 2002, "02:10:00", "A vida na favela Cidade de Deus, no Rio de Janeiro, e o crescimento do tráfico de drogas.", "https://exemplo.com/cidade-de-deus.jpg", 5, 18, 3, CURDATE()),
("A Origem", 2010, "02:28:00", "Um grupo de ladrões especializados invade os sonhos das pessoas para roubar informações.", "https://exemplo.com/a-origem.jpg", 3, 14, 2, CURDATE()),
("Pulp Fiction", 1994, "02:34:00", "Histórias interligadas de gangsters, boxeadores, assassinos e outros personagens peculiares.", "https://exemplo.com/pulp-fiction.jpg", 4.9, 18, 1, CURDATE());


INSERT INTO tb_filme
(id_catalogo, oscar, dt_atualizacao)
VALUES
(11 , 'sim', CURDATE()),
(12, 'nao', CURDATE()),
(13, 'nao', CURDATE()),
(14, 'nao', CURDATE()),
(15,'nao' , CURDATE());


INSERT INTO tb_catalogo_idioma (id_catalogo, id_idioma, dt_atualizacao)
VALUES
(11, 4, CURDATE()), (12, 2, CURDATE()), (13, 1, CURDATE()), (14, 2, CURDATE()), (15, 2, CURDATE());

INSERT INTO tb_catalogo_idioma (id_catalogo, id_idioma, dt_atualizacao)
values (11, 2, CURDATE()), (12, 1, CURDATE()), (13, 2, CURDATE()), (14, 1, CURDATE()), (15, 1, CURDATE());

INSERT INTO tb_catalogo_idioma (id_catalogo, id_idioma, dt_atualizacao)
VALUES
(11, 1, CURDATE()), (12, 3, CURDATE()), (13, 3, CURDATE()), (14, 3, CURDATE()), (15, 3, CURDATE());

INSERT INTO tb_catalogo_idioma (id_catalogo, id_idioma, dt_atualizacao)
VALUES
(11, 3, CURDATE()), (12, 4, CURDATE()), (13, 4, CURDATE()), (14, 4, CURDATE()), (15, 4, CURDATE());

INSERT INTO tb_catalogo_idioma (id_catalogo, id_idioma, dt_atualizacao)
VALUES
(11, 5, CURDATE()), (12, 5, CURDATE()), (13, 5, CURDATE()), (14, 5, CURDATE()), (15, 5, CURDATE());



INSERT INTO tb_pais_catalogo
(id_pais, id_catalogo, dt_atualizacao)
VALUES
(5,11, CURDATE()), (2,12, CURDATE()), (1,13, CURDATE()), (2,14, CURDATE()), (2,15, CURDATE());



INSERT INTO tb_endereco
(lugadouro, cep, bairro_distrito, complemento_referencia, localidade_uf, numero, id_pais, id_estado, dt_atualizacao)
VALUES
('Rua A', '12345678', 'Centro', 'Próximo ao Parque', 'Brasília/DF', '101', 1, 3, CURDATE()),
('Shibuya Dori', '1234567', 'Shibuya-ku', 'Perto da Estação de Shibuya', 'Tóquio', 'Japão', '202', 4, 1, CURDATE())
('Calle C', '28001', 'Salamanca', 'Cerca del Museo', 'Madri', '303', 3, 4, CURDATE()),
('Street D', '12345', 'Downtown', 'Near Central Park', 'New York/NY', '404', 2, 5, CURDATE()),
('도로 E', '123456', '강남구', '삼성역 근처', '서울특별시', '505', 5, 2, CURDATE());


INSERT INTO tb_usuario  
(nome, sobrenome, email, dt_nascimento, dt_cadastro, senha, status, id_endereco, dt_atualizacao)
VALUES 
('Carlos', 'Santos', 'carlos.santos@example.com', '1990-08-25', '2023-06-16', MD5('s3nh@123'), 'ativo', 6, CURDATE()),
('Emily', 'Johnson', 'emily.johnson@example.com', '1992-03-10', '2023-06-16', MD5('p@ssw0rd'), 'inativo', 9, CURDATE()),
('Kazuki', 'Tanaka', 'kazuki.tanaka@example.com', '1988-12-02', '2023-06-16', MD5('パスワード123'), 'ativo', 11, CURDATE()),
('Minji', 'Kim', 'minji.kim@example.com', '1994-06-20', '2023-06-16', MD5('비밀번호123'), 'inativo', 10, CURDATE()),
('Juan', 'García', 'juan.garcia@example.com', '1987-09-30', '2023-06-16', MD5('c0ntraseña123'), 'ativo', 8, CURDATE());



INSERT INTO tb_funcionario 
(id_usuario, foto, dt_atualizacao)
VALUES 
(1, 'https://shorturl.at/ortEK', CURDATE()),
(2, 'https://shorturl.at/lmxO4', CURDATE()),
(3, 'https://shorturl.at/byDV6', CURDATE()),
(4, 'https://shorturl.at/ptwzD', CURDATE()),
(5, 'https://shorturl.at/gqvyS', CURDATE());


INSERT INTO tb_cliente 
	(id_usuario, id_plano, dt_vencimento_plano, dt_atualizacao)
VALUES 
	(4, 1, '2023-06-30', CURDATE()),
	(5, 2, '2023-06-30', CURDATE()),
	(6, 2, '2023-06-30', CURDATE());



INSERT INTO tb_perfil (nome, foto, tipo, id_cliente, dt_atualizacao)
VALUES 
	('PerfilAdulto', 'https://shorturl.at/ghquP', 'adulto', 1, CURDATE()),
	('PerfilInfantil', 'https://shorturl.at/knuX2', 'infantil', 2, CURDATE());



INSERT INTO tb_cartao_credito (numero, data_vencimento, cod_seguranca, id_cliente, dt_atualizacao)
VALUES
    ('1111111111111111', '2024-11-30', '123', 4, CURDATE()),
    ('2222222222222222', '2023-08-31', '456', 5, CURDATE()),
    ('3333333333333333', '2025-05-31', '789', 6, CURDATE());

INSERT INTO tb_pagamento (valor, dt_pagamento, id_cartao_credito, id_cliente, id_tipo_pag, dt_atualizacao)
VALUES 
    (100.00, '2023-06-21', 1, 1, 4, '2023-06-21'),
    (50.50, '2023-06-21', 2, NULL, 5, '2023-06-21'),
    (75.25, '2023-06-21', 3, NULL, 6, '2023-06-21'),
    (200.00, '2023-06-21', 4, NULL, 4, '2023-06-21');

   
INSERT INTO tb_catalogo_categoria (id_catalogo, id_categoria, dt_atualizacao)
VALUES 
(11,1, CURDATE()), (12,2, CURDATE()), (13,5, CURDATE()), (14,2, CURDATE()), (3,1, CURDATE()), (3,3, CURDATE()), 
(4,1, CURDATE()), (4,3, CURDATE()), (4,5, CURDATE()), (5,1, CURDATE()), (5,5, CURDATE());


INSERT INTO tb_elenco (id_catalogo, id_ator, dt_atualizacao)
VALUES
	(11, 9, CURDATE()), 
	(12, 8, CURDATE()), 
	(13, 7, CURDATE()), 
	(14, 6, CURDATE()), 
	(15, 8, CURDATE());

INSERT INTO tb_episodio (nome, numero, id_temporada, id_serie, dt_atualizacao)
VALUES
('Aventuras no Espaço', 1,  21, 2, '2023-06-01'),
('O Mistério do Tesouro Perdido', 2, 22, 2, '2023-06-02'),
('O Segredo das Ruínas Antigas', 3,  23, 2, '2023-06-03'),
('Confronto nas Montanhas', 4,  24, 2, '2023-06-04'),
('A Reviravolta Inesperada', 5,  25, 2, '2023-06-05');

INSERT INTO tb_temporada (titulo, id_serie, qtd_episodio, dt_atualizacao)
VALUES
('Temporada 1', 2,  5, '2023-06-01'),
('Temporada 2', 2,  5, '2023-06-02'),
('Temporada 3', 2,  5, '2023-06-03'),
('Temporada 4', 2,  5, '2023-06-04'),
('Temporada 5', 2,  5, '2023-06-05');

INSERT INTO tb_serie 
(id_catalogo, qtd_temporadas, qtd_episodios, dt_atualizacao)
VALUES 
(4, 0, 0, CURDATE()),
(5, 0, 0, CURDATE());


INSERT INTO tb_serie (id_catalogo, qtd_temporadas, qtd_episodio, dt_atualizacao, nome)
VALUES (6, 5, 10, '2023-06-21', 'The Chronicles of Adventure'),
       (7, 3, 8, '2023-06-21', 'Mystic Manor'),
       (8, 2, 6, '2023-06-21', 'Beyond the Horizon');
           