DELIMITER //

CREATE FUNCTION QuantidadeProdutoEspecifico(
    p_produto_id INT
) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE quantidade INT;
    SELECT produto_quantidade INTO quantidade
    FROM produto
    WHERE produto_id = p_produto_id;
    RETURN quantidade;
END //

CREATE FUNCTION QuantidadeItensEntreguePorFornecedor(
    p_fornecedor_cnpj BIGINT
) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total_itens INT;
    SELECT SUM(produto_quantidade) INTO total_itens
    FROM produto
    WHERE forn_cnpj = p_fornecedor_cnpj;
    RETURN total_itens;
END //

DELIMITER ;