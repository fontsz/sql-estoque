DELIMITER //

CREATE FUNCTION fn_get_estoque_atual(p_produto_id INT) 
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE estoque_atual INT;

    SELECT produto_quantidade
    INTO estoque_atual
    FROM produto
    WHERE produto_id = p_produto_id
    FOR UPDATE; -- Para garantir consistência

    RETURN IFNULL(estoque_atual, 0);
END //

DELIMITER //

CREATE FUNCTION fn_calcular_total_pedido(p_pedido_id INT) 
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE total_pedido DECIMAL(10, 2);

	-- Calcula o preço total do pedido
    SELECT SUM(quantidade * preco_unitario)
    INTO total_pedido
    FROM item_pedido
    WHERE pedido_id = p_pedido_id;

    RETURN IFNULL(total_pedido, 0.00);
END //

DELIMITER ;

