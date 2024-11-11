-- Seed para a tabela 'fornecedor'
INSERT INTO fornecedor (forn_cnpj, forn_nome, forn_tel, forn_email) VALUES
(12345678901234, 'Fornecedor Alpha', 11999999999, 'contato@fornecedoralpha.com'),
(23456789012345, 'Fornecedor Beta', 11988888888, 'contato@fornecedorbeta.com');

-- Seed para a tabela 'notafiscal'
INSERT INTO notafiscal (nf_num, nf_dataemissao, nf_tipo) VALUES
(1001, '2024-11-01', 'Compra'),
(1002, '2024-11-02', 'Venda'),
(1003, '2024-11-03', 'Retorno');

-- Seed para a tabela 'funcionario'
INSERT INTO funcionario (func_nome, func_cargo) VALUES
('João Silva', 'Gerente de Compras'),
('Maria Santos', 'Assistente de Estoque'),
('Carlos Lima', 'Vendedor');

-- Seed para a tabela 'setor'
INSERT INTO setor (setor_nome) VALUES
('Eletrônicos'),
('Alimentos'),
('Bebidas');

-- Seed para a tabela 'produto'
INSERT INTO produto (produto_quantidade, forn_cnpj, setor_id) VALUES
(50, 12345678901234, 1),
(100, 12345678901234, 2),
(75, 23456789012345, 3);

-- Seed para a tabela 'pedido'
INSERT INTO pedido (pedido_data, forn_cnpj, nf_num, func_id) VALUES
('2024-11-05', 12345678901234, 1001, 1),
('2024-11-06', 23456789012345, 1002, 2);

-- Seed para a tabela 'movimentacao'
INSERT INTO movimentacao (mov_tipo, mov_data, func_id) VALUES
('Entrada', '2024-11-01', 1),
('Saída', '2024-11-02', 2);

-- Seed para a tabela 'venda'
INSERT INTO venda (venda_total, venda_data, func_id, nf_num) VALUES
(150.50, '2024-11-07', 3, 1002),
(300.75, '2024-11-08', 2, 1003);

-- Seed para a tabela 'retorno'
INSERT INTO retorno (retorno_data, retorno_motivo, pedido_id, nf_num, forn_cnpj, func_id) VALUES
('2024-11-09', 'Produto com defeito', 1, 1003, 12345678901234, 1);

-- Seed para a tabela 'item_pedido'
INSERT INTO item_pedido (produto_id, pedido_id, quantidade) VALUES
(1, 1, 10),
(2, 1, 20),
(3, 2, 15);

-- Seed para a tabela 'item_venda'
INSERT INTO item_venda (produto_id, venda_id) VALUES
(1, 1),
(2, 1),
(3, 2);

-- Seed para a tabela 'item_movimentacao'
INSERT INTO item_movimentacao (item_mov_quantidade, mov_id, produto_id) VALUES
(10, 1, 1),
(5, 2, 2);
