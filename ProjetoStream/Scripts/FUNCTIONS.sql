

-- Remover acentos na linguagem latina - Português - 

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
END

-- Teste -  SELECT fn_remover_acento('árvore') AS texto_sem_acentos; -- 


-- Validação de texto - 

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

-- Inserir novos dados  na tb_estado - 


CREATE FUNCTION insert_tb_estado(nome VARCHAR(45), id_pais INT)
RETURNS INT
BEGIN
    DECLARE id INT;
    INSERT INTO tb_estado (nome, id_pais, dt_atualizacao) VALUES (nome, id_pais, CURDATE());
    SET id = LAST_INSERT_ID();
    RETURN id;
END;

-- Teste-  SELECT insert_tb_estado('São Paulo', 1); --


-- Inserir novos dados validados na tb_ator-- 
CREATE FUNCTION insert_tb_ator(nome VARCHAR(45), sobrenome VARCHAR(45), dt_nascimento DATE, foto VARCHAR(255))
RETURNS INT
BEGIN
    DECLARE id INT;
    INSERT INTO tb_ator (nome, sobrenome, dt_nascimento, foto, dt_atualizacao) VALUES (nome, sobrenome, dt_nascimento, foto, CURDATE());
    SET id = LAST_INSERT_ID();
    RETURN id;
END;


-- Inserir novos dados validados na tb_plano-- 
CREATE FUNCTION insert_tb_plano(nome VARCHAR(45), valor FLOAT, descricao VARCHAR(255))
RETURNS INT
BEGIN
    DECLARE id INT;
    INSERT INTO tb_plano (nome, valor, descricao, dt_atualizacao) VALUES (nome, valor, descricao, CURDATE());
    SET id = LAST_INSERT_ID();
    RETURN id;
END;

-- Inserir novos dados validados na tb_tipo_pag-- 
CREATE FUNCTION insert_tb_tipo_pag(categoria VARCHAR(30))
RETURNS INT
BEGIN
    DECLARE id INT;
    INSERT INTO tb_tipo_pag (categoria, dt_atualizacao) VALUES (categoria, CURDATE());
    SET id = LAST_INSERT_ID();
    RETURN id;
END;

-- Inserir novos dados validados na tb_ator-- 
CREATE FUNCTION insert_tb_idioma(nome VARCHAR(60))
RETURNS INT
BEGIN
    DECLARE id INT;
    INSERT INTO tb_idioma (nome, dt_atualizacao) VALUES (nome, CURDATE());
    SET id = LAST_INSERT_ID();
    RETURN id;
END;

-- Inserir novos dados validados na tb_categoria-- 
CREATE FUNCTION insert_tb_categoria(nome VARCHAR(60))
RETURNS INT
BEGIN
    DECLARE id INT;
    INSERT INTO tb_categoria (nome, dt_atualizacao) VALUES (nome, CURDATE());
    SET id = LAST_INSERT_ID();
    RETURN id;
END;

-- Function para atualizar foto do perfil do usuario - 
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
end;

-- atualiza nome do perfil do usuario --

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




