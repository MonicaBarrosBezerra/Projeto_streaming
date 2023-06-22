
-- Trigger para que, antes da inserção de um cliente, sejam verificadas se há nulidade do campo do id do plano

CREATE TRIGGER before_insert_tb_cliente
BEFORE INSERT ON tb_cliente
FOR EACH ROW
BEGIN
    IF NEW.id_plano IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'O campo id_plano não pode ser nulo';
    END IF;
END;


-- Trigger para que, após a atualização (novo id criado)  da tabela catálogo, caso não se escolha se na tabela filme se algum filme não teve oscar, automaticamente será colocado como 'sim'

CREATE TRIGGER after_update_tb_catalogo
AFTER UPDATE ON tb_catalogo
FOR EACH ROW
BEGIN
    IF NEW.avaliacao IS NOT NULL THEN
        UPDATE tb_filme SET oscar = 'sim' WHERE id_catalogo = NEW.id_catalogo;
    END IF;
END;


-- sempre que uma linha na tabela "tb_usuario" for atualizada, um registro será inserido na tabela "tb_usuario_audit" 
-- com o ID do usuário antigo e a data/hora da atualização 
CREATE TRIGGER after_update_tb_usuario
AFTER UPDATE ON tb_usuario
FOR EACH ROW
BEGIN
    INSERT INTO tb_usuario_audit (id_usuario, dt_atualizacao)
    VALUES (OLD.id_usuario, NOW());
END;

-- 

-- quando um novo cartão de crédito é inserido na tabela "tb_cartao_credito", 
-- atualiza-se a data de vencimento do plano do cliente correspondente na tabela
-- "tb_cliente" com base na data de vencimento fornecida

CREATE TRIGGER after_insert_tb_cartao_credito
AFTER INSERT ON tb_cartao_credito
FOR EACH ROW
BEGIN
    UPDATE tb_cliente SET dt_vencimento_plano = NEW.data_vencimento WHERE id_cliente = NEW.id_cliente;
   
   END; 
   
   --  sempre que uma atualização é realizada na tabela "tb_catalogo", atualiza-se para a data atual antes da execução do update.
   --  Mostrando momento exato da última modificação feita no registro.
   
   CREATE TRIGGER before_update_tb_catalogo
BEFORE UPDATE ON tb_catalogo
FOR EACH ROW
BEGIN
    SET NEW.dt_atualizacao = CURRENT_DATE();
END; 

-- Após a exclusão de um registro da tabela "tb_cliente", 
-- os registros relacionados nas tabelas "tb_pagamento" e "tb_perfil" também serão removidos 

CREATE TRIGGER after_delete_tb_cliente
AFTER DELETE ON tb_cliente
FOR EACH ROW
BEGIN
    DELETE FROM tb_pagamento WHERE id_cliente = OLD.id_cliente;
    DELETE FROM tb_perfil WHERE id_cliente = OLD.id_cliente;
   
END; 


--  

-- Tal trigger garante que não seja excluida uma categoria 

CREATE TRIGGER before_delete_tb_categoria
BEFORE DELETE ON tb_categoria
FOR EACH ROW
BEGIN
    IF OLD.nome = 'Ação' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Não é permitido excluir a categoria de Ação.';
    END IF;
END;

-- 

 -- sempre que uma linha na tabela "tb_catalogo" é atualizada, 
 -- é registrado uma entrada no histórico na tabela "tb_catalogo_historico" com os valores antigos do ID do catálogo,
 --  título e data de atualização

CREATE TRIGGER after_update_tb_catalogo
AFTER UPDATE ON tb_catalogo
FOR EACH ROW
BEGIN
    INSERT INTO tb_catalogo_historico (id_catalogo, titulo, dt_atualizacao) 
    VALUES (OLD.id_catalogo, OLD.titulo, OLD.dt_atualizacao);
END;



--  quando uma atualizaçao ocorre na tabela "tb_catalogo", é redefinida a data atual antes da execução do update. 

CREATE TRIGGER before_update_tb_catalogo
BEFORE UPDATE ON tb_catalogo
FOR EACH ROW
BEGIN
    SET NEW.dt_atualizacao = CURRENT_DATE();
END;


-- Traz uma mensagem de aviso de novo cliente junto com o id e hora atual 

CREATE TRIGGER after_insert_tb_cliente
AFTER INSERT ON tb_cliente
FOR EACH ROW
BEGIN
    INSERT INTO tb_log (mensagem, dt_registro)
    VALUES ('Novo cliente cadastrado - ID: ' + CAST(NEW.id_cliente AS CHAR), CURRENT_TIMESTAMP());
END;

 --- Atualiza a quantidade da tabela temporada quando é feito a inserção de um episódio
 
CREATE TRIGGER after_insert_tb_episodio
AFTER INSERT ON tb_episodio
FOR EACH ROW
BEGIN
    UPDATE tb_temporada
    SET qtd_episodio = qtd_episodio + 1
    WHERE id_temporada = NEW.id_temporada;
END;

 -- Atualiza a quantidade da tabela temporada quando é feito a remoção de um episódio
CREATE TRIGGER after_delete_tb_episodio
AFTER DELETE ON tb_episodio
FOR EACH ROW
BEGIN
    UPDATE tb_temporada
    SET qtd_episodio = qtd_episodio - 1
    WHERE id_temporada = OLD.id_temporada;
END;