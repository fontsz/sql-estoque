-- INSERINDO DADOS NAS ENTIDADES PRIMÁRIAS

INSERT INTO fornecedor (forn_cnpj, forn_nome, forn_tel, forn_email) VALUES
(10000000000123, 'Fornecedor A', 11912345678, 'fornecedorA@empresa.com'),
(10000000000124, 'Fornecedor B', 11998765432, 'fornecedorB@empresa.com');

INSERT INTO notafiscal (nf_num, nf_dataemissao, nf_tipo) VALUES
(1, '2024-10-01', 'Compra'),
(2, '2024-10-05', 'Devolução'),
(3, '2024-10-10', 'Venda');

INSERT INTO funcionario (func_id, func_nome, func_cargo) VALUES
(1, 'João Silva', 'Gerente'),
(2, 'Maria Oliveira', 'Caixa'),
(3, 'Pedro Souza', 'Almoxarife');

INSERT INTO setor (setor_id, setor_nome) VALUES
(1, 'Eletrônicos'),
(2, 'Alimentos'),
(3, 'Limpeza');

-- INSERINDO DADOS NA TABELA DE PEDIDO
INSERT INTO pedido (pedido_id, pedido_data, forn_cnpj, nf_num, func_id) VALUES
(1, '2024-10-01', 10000000000123, 1, 1),
(2, '2024-10-05', 10000000000124, 2, 3);

-- INSERINDO DADOS NA TABELA DE MOVIMENTAÇÃO
INSERT INTO movimentacao (mov_id, mov_tipo, mov_data, func_id) VALUES
(1, 'Entrada', '2024-10-02', 3),
(2, 'Saída', '2024-10-06', 3);

-- INSERINDO DADOS NA TABELA DE PRODUTO
INSERT INTO produto (produto_id, produto_quantidade, forn_cnpj, setor_id) VALUES
(1, 50, 10000000000123, 1),
(2, 100, 10000000000124, 2);

-- INSERINDO DADOS NA TABELA DE RETORNO
INSERT INTO retorno (retorno_id, retorno_data, retorno_motivo, pedido_id, nf_num, forn_cnpj, func_id) VALUES
(1, '2024-10-06', 'Produto danificado', 2, 2, 10000000000124, 3);

-- INSERINDO DADOS NA TABELA DE VENDA
INSERT INTO venda (venda_id, venda_total, venda_data, func_id, nf_num) VALUES
(1, 500.00, '2024-10-10', 2, 3);

-- INSERINDO DADOS NAS ENTIDADES ASSOCIATIVAS

-- ITEM_PEDIDO
INSERT INTO item_pedido (produto_id, pedido_id) VALUES
(1, 1),
(2, 2);

-- ITEM_VENDA
INSERT INTO item_venda (produto_id, venda_id) VALUES
(1, 1);

-- ITEM_MOVIMENTACAO
INSERT INTO item_movimentacao (item_mov_quantidade, mov_id, produto_id) VALUES
(50, 1, 1),
(20, 2, 2);