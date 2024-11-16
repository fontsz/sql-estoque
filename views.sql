CREATE VIEW vw_estoque_atual AS
SELECT 
    p.produto_id,
    p.produto_nome,
    p.produto_quantidade AS estoque_atual,
    s.setor_nome AS setor,
    f.forn_nome AS fornecedor
FROM produto p
LEFT JOIN setor s ON p.setor_id = s.setor_id
LEFT JOIN fornecedor f ON p.forn_cnpj = f.forn_cnpj;
-- -------------------------------------------------------------------------------------
CREATE VIEW vw_itens_pedido AS
SELECT 
    ip.pedido_id,
    p.produto_nome,
    ip.quantidade,
    ip.preco_unitario,
    (ip.quantidade * ip.preco_unitario) AS preco_total
FROM item_pedido ip
JOIN produto p ON ip.produto_id = p.produto_id;
-- -------------------------------------------------------------------------------------
CREATE VIEW vw_retorno_pedidos AS
SELECT 
    r.retorno_id,
    r.retorno_data,
    r.retorno_motivo,
    r.pedido_id,
    f.forn_nome AS fornecedor,
    p.produto_nome,
    ip.quantidade AS quantidade_retornada
FROM retorno r
JOIN pedido pd ON r.pedido_id = pd.pedido_id
JOIN fornecedor f ON r.forn_cnpj = f.forn_cnpj
LEFT JOIN item_pedido ip ON r.pedido_id = ip.pedido_id
LEFT JOIN produto p ON ip.produto_id = p.produto_id;
-- -------------------------------------------------------------------------------------
CREATE VIEW vw_vendas_por_periodo AS
SELECT 
    v.venda_id,
    v.venda_data,
    v.venda_total,
    f.func_nome AS funcionario_responsavel
FROM venda v
LEFT JOIN funcionario f ON v.func_id = f.func_id;
-- -------------------------------------------------------------------------------------
CREATE VIEW vw_pedidos_funcionarios AS
SELECT 
    pd.pedido_id,
    pd.pedido_data,
    f.func_nome AS funcionario_responsavel,
    fr.forn_nome AS fornecedor
FROM pedido pd
LEFT JOIN funcionario f ON pd.func_id = f.func_id
LEFT JOIN fornecedor fr ON pd.forn_cnpj = fr.forn_cnpj;
-- -------------------------------------------------------------------------------------
CREATE VIEW vw_vendas_funcionario AS
SELECT 
    v.venda_id,
    v.venda_data,
    f.func_nome AS funcionario_responsavel,
    v.venda_total
FROM venda v
LEFT JOIN funcionario f ON v.func_id = f.func_id;

