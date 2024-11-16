DELIMITER //

CREATE PROCEDURE CadastrarPedido(
    IN p_fornecedor BIGINT,
    IN p_funcionario INT,
    IN p_pedido_data DATE
)
BEGIN
    DECLARE v_pedido_id INT;

    START TRANSACTION;

    -- Insere o pedido na tabela
    INSERT INTO pedido (pedido_data, forn_cnpj, func_id)
    VALUES (p_pedido_data, p_fornecedor, p_funcionario);

    COMMIT;
END //

DELIMITER //

CREATE PROCEDURE CadastrarNotaFiscal(
    IN p_pedido_id INT,
    IN p_nf_dataemissao DATE,
    IN p_nf_tipo VARCHAR(45)
)
BEGIN
    DECLARE v_exists INT;

    START TRANSACTION;

    -- Conta quantos registros existem com o ID do Pedido da Procedure
    SELECT COUNT(*) INTO v_exists
    FROM pedido
    WHERE pedido_id = p_pedido_id;

	-- Se não existir pedidos com o ID solicitado, apresentará um erro
    IF v_exists = 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Pedido não encontrado';
    END IF;

    -- Insere a Nota Fiscal
    INSERT INTO notafiscal (nf_dataemissao, nf_tipo, pedido_id)
    VALUES (p_nf_dataemissao, p_nf_tipo, p_pedido_id);

    COMMIT;
END //

DELIMITER //

CREATE PROCEDURE CadastrarFornecedor(
    IN p_fornecedor_cnpj BIGINT,
    IN p_fornecedor_nome VARCHAR(100),
    IN p_fornecedor_tel BIGINT,
    IN p_fornecedor_email VARCHAR(100)
)
BEGIN
    START TRANSACTION;

    INSERT INTO fornecedor (forn_cnpj, forn_nome, forn_tel, forn_email)
    VALUES (p_fornecedor_cnpj, p_fornecedor_nome, p_fornecedor_tel, p_fornecedor_email);

    COMMIT;
END //

DELIMITER //

CREATE PROCEDURE AtualizarEstoqueAtual(
    IN p_produto_id INT,
    IN p_quantidade INT
)
BEGIN
    START TRANSACTION;

    UPDATE produto
    SET produto_quantidade = produto_quantidade + p_quantidade
    WHERE produto_id = p_produto_id;

    COMMIT;
END //

DELIMITER //

CREATE PROCEDURE RegistrarRetornoProduto(
    IN p_pedido_id INT,
    IN p_fornecedor BIGINT,
    IN p_funcionario INT,
    IN p_nf_num INT,
    IN p_retorno_data DATE,
    IN p_retorno_motivo VARCHAR(255)
)
BEGIN
    DECLARE v_exists INT;

    START TRANSACTION;

    -- Verifica se a Nota Fiscal existe
    SELECT COUNT(*) INTO v_exists
    FROM notafiscal
    WHERE nf_num = p_nf_num AND pedido_id = p_pedido_id;

    IF v_exists = 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Nota Fiscal não encontrada para o pedido informado';
    END IF;

    -- Insere o retorno
    INSERT INTO retorno (retorno_data, retorno_motivo, pedido_id, nf_num, forn_cnpj, func_id)
    VALUES (p_retorno_data, p_retorno_motivo, p_pedido_id, p_nf_num, p_fornecedor, p_funcionario);

    COMMIT;
END //

DELIMITER //

CREATE PROCEDURE ExcluirProduto(
    IN p_produto_id INT
)
excluirproduto:BEGIN
    DECLARE v_exists INT;

    START TRANSACTION;

    -- Verifica se o produto está associado a algum pedido ou venda por motivos de segurança
    SELECT COUNT(*) INTO v_exists
    FROM item_pedido
    WHERE produto_id = p_produto_id;

    IF v_exists > 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Produto vinculado a pedidos. Exclusão não permitida';
        ROLLBACK;
        LEAVE excluirproduto;
    END IF;

    SELECT COUNT(*) INTO v_exists
    FROM item_venda
    WHERE produto_id = p_produto_id;

    IF v_exists > 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Produto vinculado a vendas. Exclusão não permitida';
        ROLLBACK;
        LEAVE ExcluirProduto;
    END IF;

    -- Exclui o produto
    DELETE FROM produto
    WHERE produto_id = p_produto_id;

    COMMIT;
END //

DELIMITER ;
