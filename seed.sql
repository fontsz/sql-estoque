INSERT INTO fornecedor (forn_cnpj, forn_nome, forn_tel, forn_email) VALUES
(12345678000195, 'Fornecedor A', 1123456789, 'fornecedorA@email.com'),
(98765432000199, 'Fornecedor B', 1198765432, 'fornecedorB@email.com');

INSERT INTO funcionario (func_nome, func_cargo) VALUES
('João Silva', 'Gerente de Compras'),
('Maria Oliveira', 'Vendedor'),
('Carlos Souza', 'Estoque');

INSERT INTO setor (setor_nome) VALUES
('Alimentos'),
('Bebidas'),
('Limpeza');

INSERT INTO pedido (pedido_data, forn_cnpj, func_id) VALUES
('2024-11-01', 12345678000195, 1),
('2024-11-02', 98765432000199, 2);

INSERT INTO notafiscal (nf_dataemissao, nf_tipo, pedido_id) VALUES
('2024-11-01', 'Venda', 1),
('2024-11-02', 'Compra', 2);

INSERT INTO movimentacao (mov_tipo, mov_data, func_id) VALUES
('Entrada', '2024-11-03', 3),
('Saída', '2024-11-03', 3);

INSERT INTO produto (produto_nome, preco_preco, produto_quantidade, forn_cnpj, setor_id) VALUES
('Arroz', 25.50, 100, 12345678000195, 1),
('Refrigerante', 8.99, 200, 98765432000199, 2),
('Sabão em Pó', 15.00, 50, 12345678000195, 3);

INSERT INTO retorno (retorno_data, retorno_motivo, pedido_id, nf_num, forn_cnpj, func_id) VALUES
('2024-11-04', 'Produto com defeito', 1, 1, 12345678000195, 2);

INSERT INTO venda (venda_total, venda_data, func_id, nf_num) VALUES
(100.00, '2024-11-05', 2, 1);

INSERT INTO item_pedido (produto_id, pedido_id, quantidade, preco_unitario) VALUES
(1, 1, 10, 25.50),
(2, 2, 50, 8.99);

INSERT INTO item_venda (produto_id, venda_id, quantidade) VALUES
(1, 1, 5),
(2, 1, 10);

INSERT INTO item_movimentacao (item_mov_quantidade, mov_id, produto_id) VALUES
(50, 1, 1),
(30, 2, 2);
