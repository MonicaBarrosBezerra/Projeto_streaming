-- Procedure para obter detalhes do catalogo --

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

-- inserir filme para inserir filme, caso não, retornar uma mensagem de erro -- 
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

-- procedure para cliente inserir cliente, caso não esteja dentro dos padrões, retornar  msg de erro -- 
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

DROP PROCEDURE IF EXISTS sp_InsertCliente;

-- procedure de atualização de  catalogo, caso não esteja dentro dos padrões, retornar  msg de erro -- 
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

-- procedure de exclusão de item, caso não esteja dentro dos padrões, retornar  msg de erro -- 

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



-- procedure para buscar titulos do catalogo, caso não esteja dentro dos padrões, retornar  msg de erro -- 
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

-- -- procedure para atualizar catalogo, caso não esteja dentro dos padrões, retornar  msg de erro -- 

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


-- procedure de exclusão de temporada, caso não esteja dentro dos padrões, retornar  msg de erro -- 


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


-- procedure de inserir de temporada, caso não esteja dentro dos padrões, retornar  msg de erro -- 


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


-- procedure de inserir serie, caso não esteja dentro dos padrões, retornar  msg de erro -- 
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




--- procedure de inserir elenco, caso não esteja dentro dos padrões, retornar  msg de erro -- 


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


--- procedure de deletar elenco, caso não esteja dentro dos padrões, retornar  msg de erro -- 



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



--- procedure fazer update do elenco, caso não esteja dentro dos padrões, retornar  msg de erro -- 

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


-- procedure de inserir pagamento (fazer a venda), caso não esteja dentro dos padrões, retornar  msg de erro -- 


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

-- procedure de atualizar pagamento (venda), caso não esteja dentro dos padrões, retornar  msg de erro --
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

-- procedure de deletar pagamento (fazer estorno\cancelar venda), caso não esteja dentro dos padrões, retornar  msg de erro -- 


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

-- procedure de apagar cliente, caso não esteja dentro dos padrões, retornar  msg de erro -- 


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


-- procedure de atualizar dados do cliente, caso não esteja dentro dos padrões, retornar  msg de erro -- 

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

   
   -- procedure de inserir dados do cliente, caso não esteja dentro dos padrões, retornar  msg de erro -- 
   
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



-- procedure de inserir dados do funcionario, caso não esteja dentro dos padrões, retornar  msg de erro -- 


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
	
-- procedure de atualizar dados do funcionario, caso não esteja dentro dos padrões, retornar  msg de erro -- 

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
    
   -- procedure de apagar dados do funcionario, caso não esteja dentro dos padrões, retornar  msg de erro -- 

   
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



 -- procedure de inserir dados do usuario, caso não esteja dentro dos padrões, retornar  msg de erro -- 

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


---

-- procedure de apagar dados do usuario, caso não esteja dentro dos padrões, retornar  msg de erro --

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


--- 

-- procedure de atualizar dados do usuario, caso não esteja dentro dos padrões, retornar  msg de erro --

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
    DECLARE error_message VARCHAR(250) DEFAULT '';

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