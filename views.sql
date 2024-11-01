CREATE VIEW vw_estoque_atual AS
SELECT 
    p.produto_id,
    p.produto_quantidade,
    f.forn_nome AS fornecedor_nome,
    s.setor_nome AS setor_nome
FROM produto p
JOIN fornecedor f ON p.forn_cnpj = f.forn_cnpj
LEFT JOIN setor s ON p.setor_id = s.setor_id;
    
    CREATE VIEW vw_itens_pedido AS
SELECT 
    p.pedido_id,
    p.pedido_data,
    f.forn_nome AS fornecedor,
    n.nf_num AS nota_fiscal,
    func.func_nome AS funcionario,
    ip.produto_id,
    pr.produto_quantidade,
    pr.setor_id
FROM pedido p
JOIN item_pedido ip ON p.pedido_id = ip.pedido_id
JOIN produto pr ON ip.produto_id = pr.produto_id
JOIN fornecedor f ON p.forn_cnpj = f.forn_cnpj
JOIN notafiscal n ON p.nf_num = n.nf_num
JOIN funcionario func ON p.func_id = func.func_id;

CREATE VIEW vw_retorno_pedidos AS
SELECT 
    r.retorno_id,
    r.retorno_data,
    r.retorno_motivo,
    p.pedido_id,
    p.pedido_data,
    f.forn_nome AS fornecedor,
    nf.nf_num AS nota_fiscal,
    func.func_nome AS funcionario FROM retorno r
JOIN pedido p ON r.pedido_id = p.pedido_id
JOIN fornecedor f ON r.forn_cnpj = f.forn_cnpj
JOIN notafiscal nf ON r.nf_num = nf.nf_num
JOIN funcionario func ON r.func_id = func.func_id;

CREATE VIEW vw_vendas_por_periodo AS
SELECT 
    YEAR(v.venda_data) AS ano,
    MONTH(v.venda_data) AS mes,
    COUNT(v.venda_id) AS total_vendas,
    SUM(v.venda_total) AS total_receita,
    AVG(v.venda_total) AS receita_media,
    func.func_nome AS funcionario
FROM venda v JOIN funcionario func ON v.func_id = func.func_id
GROUP BY YEAR(v.venda_data), MONTH(v.venda_data), func.func_nome
ORDER BY ano DESC, mes DESC;

CREATE VIEW vw_pedidos_funcionarios AS
SELECT 
    p.pedido_id,
    p.pedido_data,
    f.func_nome,
    f.func_cargo,
    forn.forn_nome AS fornecedor_nome FROM pedido p
JOIN funcionario f ON p.func_id = f.func_id
JOIN fornecedor forn ON p.forn_cnpj = forn.forn_cnpj;

CREATE VIEW vw_vendas_funcionario AS
SELECT 
    v.venda_id,
    v.venda_data,
    v.venda_total,
    func.func_id,
    func.func_nome,
    func.func_cargo
FROM venda v 
JOIN funcionario func ON v.func_id = func.func_id
ORDER BY func.func_nome, v.venda_data DESC;