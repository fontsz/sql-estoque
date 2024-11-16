-- Índices nas Foreign Keys
CREATE INDEX idx_pedido_forn_cnpj ON pedido (forn_cnpj);
CREATE INDEX idx_pedido_func_id ON pedido (func_id);
CREATE INDEX idx_produto_forn_cnpj ON produto (forn_cnpj);
CREATE INDEX idx_produto_setor_id ON produto (setor_id);
CREATE INDEX idx_item_pedido_composto ON item_pedido (produto_id, pedido_id);
CREATE INDEX idx_item_venda_composto ON item_venda (produto_id, venda_id);
CREATE INDEX idx_retorno_composto ON retorno (pedido_id, nf_num, forn_cnpj);
CREATE INDEX idx_venda_composto ON venda (func_id, nf_num);

-- Índices para Data
CREATE INDEX idx_pedido_pedido_data ON pedido (pedido_data);
CREATE INDEX idx_venda_venda_data ON venda (venda_data);
CREATE INDEX idx_notafiscal_nf_dataemissao ON notafiscal (nf_dataemissao);
CREATE INDEX idx_movimentacao_mov_data ON movimentacao (mov_data);
CREATE INDEX idx_retorno_retorno_data ON retorno (retorno_data);

-- Índice para busca por Nome
CREATE INDEX idx_funcionario_func_nome ON funcionario (func_nome);
CREATE INDEX idx_fornecedor_forn_nome ON fornecedor (forn_nome);
CREATE INDEX idx_produto_produto_nome ON produto (produto_nome);

-- Índices para consultas específicas
CREATE INDEX idx_pedido_data_func ON pedido (pedido_data, func_id);
CREATE INDEX idx_produto_setor_estoque ON produto (setor_id, produto_quantidade);
