DELIMITER //
CREATE PROCEDURE CadastrarPedido(
    IN p_pedido_data DATE,
    IN p_forn_cnpj BIGINT,
    IN p_nf_num INT,
    IN p_func_id INT,
    IN p_produto_id INT,
    IN p_quantidade INT
)
cadastro:BEGIN
    DECLARE p_pedido_id INT;
    DECLARE p_produto_quantidade INT;
    
    -- Inicia a transação
    START TRANSACTION;
    
    -- Verifica a quantidade disponível em estoque com LOCK para evitar alterações concorrentes
    SELECT produto_quantidade INTO p_produto_quantidade
    FROM produto
    WHERE produto_id = p_produto_id
    LOCK IN SHARE MODE;

    -- Verifica se há quantidade suficiente no estoque
    IF p_produto_quantidade < p_quantidade THEN
        -- Se não houver estoque suficiente, realiza um rollback e encerra a procedure
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Estoque insuficiente para o produto selecionado';
        ROLLBACK;
        LEAVE cadastro;
    END IF;

    -- Insere o pedido na tabela de pedidos
    INSERT INTO pedido (pedido_data, forn_cnpj, nf_num, func_id)
    VALUES (p_pedido_data, p_forn_cnpj, p_nf_num, p_func_id);
    
    -- Obtém o ID do pedido criado
    SET p_pedido_id = LAST_INSERT_ID();
    
    -- Insere o item na tabela de item_pedido
    INSERT INTO item_pedido (produto_id, pedido_id, quantidade)
    VALUES (p_produto_id, p_pedido_id, p_quantidade);
    
    -- Atualiza o estoque do produto subtraindo a quantidade pedida
    UPDATE produto
    SET produto_quantidade = produto_quantidade - p_quantidade
    WHERE produto_id = p_produto_id;

    -- Confirma a transação
    COMMIT;
END //

CREATE PROCEDURE CadastrarFornecedor(
    IN p_fornecedor_cnpj BIGINT,
    IN p_fornecedor_nome VARCHAR(100),
    IN p_fornecedor_tel BIGINT,
    IN p_fornecedor_email VARCHAR(100)
)
BEGIN
    -- Inicia a transação
    START TRANSACTION;
    
    -- Cria o fornecedor 
    INSERT INTO fornecedor (forn_cnpj, forn_nome, forn_tel, forn_email)
    VALUES (p_fornecedor_cnpj, p_fornecedor_nome, p_fornecedor_tel, p_fornecedor_email);

    -- Confirma a transação
    COMMIT;
END //

CREATE PROCEDURE AtualizarEstoqueAtual(
    IN p_mov_id INT,
    IN p_produto_id INT,
    IN p_quantidade INT
)
BEGIN
    -- Inicia a transação
    START TRANSACTION;

    -- Insere o item na movimentação de estoque e atualiza a quantidade do produto
    INSERT INTO item_movimentacao (item_mov_quantidade, mov_id, produto_id)
    VALUES (p_quantidade, p_mov_id, p_produto_id);

    UPDATE produto
    SET produto_quantidade = produto_quantidade + p_quantidade
    WHERE produto_id = p_produto_id;

    -- Confirma a transação
    COMMIT;
END //

CREATE PROCEDURE RegistrarRetornoProduto(
    IN p_retorno_data DATE,
    IN p_retorno_motivo VARCHAR(255),
    IN p_pedido_id INT,
    IN p_nf_num INT,
    IN p_forn_cnpj BIGINT,
    IN p_func_id INT
)
BEGIN
    -- Inicia a transação
    START TRANSACTION;

    -- Insere o retorno de produto
    INSERT INTO retorno (retorno_data, retorno_motivo, pedido_id, nf_num, forn_cnpj, func_id)
    VALUES (p_retorno_data, p_retorno_motivo, p_pedido_id, p_nf_num, p_forn_cnpj, p_func_id);

    -- Confirma a transação
    COMMIT;
END //

CREATE PROCEDURE AtualizarDadosFuncionario(
    IN p_func_id INT,
    IN p_func_nome VARCHAR(100),
    IN p_func_cargo VARCHAR(100)
)
BEGIN
    -- Inicia a transação
    START TRANSACTION;

    -- Atualiza os dados do funcionário
    UPDATE funcionario
    SET func_nome = p_func_nome, func_cargo = p_func_cargo
    WHERE func_id = p_func_id;

    -- Confirma a transação
    COMMIT;
END //

CREATE PROCEDURE ExcluirProduto(
    IN p_produto_id INT
)
BEGIN
    -- Inicia a transação
    START TRANSACTION;

    -- Exclui todas as ocorrências do produto em tabelas associativas antes de excluí-lo da tabela principal
    DELETE FROM item_pedido WHERE produto_id = p_produto_id;
    DELETE FROM item_venda WHERE produto_id = p_produto_id;
    DELETE FROM item_movimentacao WHERE produto_id = p_produto_id;
    DELETE FROM produto WHERE produto_id = p_produto_id;

    -- Confirma a transação
    COMMIT;
END //

DELIMITER ;
