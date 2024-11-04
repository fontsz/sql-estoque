DELIMITER //
CREATE PROCEDURE CadastrarFornecedor(
    IN p_fornecedor_cnpj BIGINT,
    IN p_fornecedor_nome VARCHAR(100),
    IN p_fornecedor_tel BIGINT,
    IN p_fornecedor_email VARCHAR(100)
)
BEGIN
    -- Cria o fornecedor 
    INSERT INTO fornecedor (forn_cnpj, forn_nome, forn_tel, forn_email)
    VALUES (p_fornecedor_cnpj, p_fornecedor_nome, p_fornecedor_tel, p_fornecedor_email);
END //

CREATE PROCEDURE CadastrarPedido(
    IN p_pedido_data DATE,
    IN p_forn_cnpj BIGINT,
    IN p_nf_num INT,
    IN p_func_id INT,
    IN p_produto_id INT,
    IN p_quantidade INT
)
BEGIN
    DECLARE p_pedido_id INT;
    -- Cria o pedido
    INSERT INTO pedido (pedido_data, forn_cnpj, nf_num, func_id)
    VALUES (p_pedido_data, p_forn_cnpj, p_nf_num, p_func_id);
    SET p_pedido_id = LAST_INSERT_ID();
    -- Liga os itens ao pedido
    INSERT INTO item_pedido (produto_id, pedido_id)
    VALUES (p_produto_id, p_pedido_id);
    -- Atualiza o estoque do produto
    UPDATE produto
    SET produto_quantidade = produto_quantidade + p_quantidade
    WHERE produto_id = p_produto_id;
END //

CREATE PROCEDURE AtualizarEstoqueAtual(
    IN p_mov_id INT,
    IN p_produto_id INT,
    IN p_quantidade INT
)
BEGIN
    INSERT INTO item_movimentacao (item_mov_quantidade, mov_id, produto_id)
    VALUES (p_quantidade, p_mov_id, p_produto_id);
    UPDATE produto
    SET produto_quantidade = produto_quantidade + p_quantidade
    WHERE produto_id = p_produto_id;
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
    INSERT INTO retorno (retorno_data, retorno_motivo, pedido_id, nf_num, forn_cnpj, func_id)
    VALUES (p_retorno_data, p_retorno_motivo, p_pedido_id, p_nf_num, p_forn_cnpj, p_func_id);
END //

CREATE PROCEDURE AtualizarDadosFuncionario(
    IN p_func_id INT,
    IN p_func_nome VARCHAR(100),
    IN p_func_cargo VARCHAR(100)
)
BEGIN
    UPDATE funcionario
    SET func_nome = p_func_nome, func_cargo = p_func_cargo
    WHERE func_id = p_func_id;
END //

CREATE PROCEDURE ExcluirProduto(
    IN p_produto_id INT
)
BEGIN
    DELETE FROM item_pedido WHERE produto_id = p_produto_id;
    DELETE FROM item_venda WHERE produto_id = p_produto_id;
    DELETE FROM item_movimentacao WHERE produto_id = p_produto_id;
    DELETE FROM produto WHERE produto_id = p_produto_id;
END //
DELIMITER ; 