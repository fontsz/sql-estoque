-- ENTIDADES PRIMARIAS

CREATE TABLE IF NOT EXISTS fornecedor (
	PRIMARY KEY (forn_cnpj),
	forn_cnpj BIGINT NOT NULL,
    forn_nome VARCHAR(100),
    forn_tel BIGINT,
    forn_email VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS notafiscal (
	PRIMARY KEY (nf_num),
    nf_num INT NOT NULL,
    nf_dataemissao DATE,
    nf_tipo VARCHAR(45)
);

CREATE TABLE IF NOT EXISTS funcionario (
	PRIMARY KEY (func_id),
    func_id INT NOT NULL AUTO_INCREMENT,
    func_nome VARCHAR(100),
    func_cargo VARCHAR (100)
);

CREATE TABLE IF NOT EXISTS setor (
	PRIMARY KEY (setor_id),
    setor_id INT NOT NULL AUTO_INCREMENT,
    setor_nome VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS pedido (
	PRIMARY KEY (pedido_id),
    pedido_id INT NOT NULL AUTO_INCREMENT,
    pedido_data DATE,
    forn_cnpj BIGINT NOT NULL,
    FOREIGN KEY (forn_cnpj) REFERENCES fornecedor(forn_cnpj),
    nf_num INT NOT NULL,
    FOREIGN KEY (nf_num) REFERENCES notafiscal(nf_num),
    func_id INT NOT NULL,
    FOREIGN KEY (func_id) REFERENCES funcionario(func_id)
);

CREATE TABLE IF NOT EXISTS movimentacao (
	PRIMARY KEY (mov_id),
    mov_id INT NOT NULL AUTO_INCREMENT,
    mov_tipo VARCHAR(100),
    mov_data DATE,
    func_id INT,
    FOREIGN KEY (func_id) REFERENCES funcionario(func_id)
);

CREATE TABLE IF NOT EXISTS produto (
	PRIMARY KEY (produto_id),
	produto_id INT NOT NULL AUTO_INCREMENT,
    produto_quantidade INT NOT NULL DEFAULT 0,
    forn_cnpj BIGINT NOT NULL,
    FOREIGN KEY (forn_cnpj) REFERENCES fornecedor(forn_cnpj),
    setor_id INT,
    FOREIGN KEY (setor_id) REFERENCES setor(setor_id)
);

CREATE TABLE IF NOT EXISTS retorno (
	PRIMARY KEY (retorno_id),
    retorno_id INT NOT NULL AUTO_INCREMENT,
    retorno_data DATE,
    retorno_motivo VARCHAR(255),
    pedido_id INT NOT NULL,
    FOREIGN KEY (pedido_id) REFERENCES pedido(pedido_id),
    nf_num INT NOT NULL,
    FOREIGN KEY (nf_num) REFERENCES notafiscal(nf_num),
    forn_cnpj BIGINT NOT NULL,
    FOREIGN KEY (forn_cnpj) REFERENCES fornecedor(forn_cnpj),
    func_id INT NOT NULL,
    FOREIGN KEY (func_id) REFERENCES funcionario(func_id)
);

CREATE TABLE IF NOT EXISTS venda (
	PRIMARY KEY (venda_id),
    venda_id INT NOT NULL AUTO_INCREMENT,
    venda_total DECIMAL(10, 2),
    venda_data DATE,
    func_id INT,
    FOREIGN KEY (func_id) REFERENCES funcionario(func_id),
    nf_num INT NOT NULL,
    FOREIGN KEY (nf_num) REFERENCES notafiscal(nf_num)
);

-- ENTIDADES ASSOCIATIVAS

CREATE TABLE IF NOT EXISTS item_pedido (
	produto_id INT NOT NULL,
    FOREIGN KEY (produto_id) REFERENCES produto(produto_id),
    pedido_id INT NOT NULL,
    FOREIGN KEY (pedido_id) REFERENCES pedido(pedido_id),
    quantidade INT NOT NULL DEFAULT 0
);

CREATE TABLE IF NOT EXISTS item_venda (
	produto_id INT NOT NULL,
    FOREIGN KEY (produto_id) REFERENCES produto(produto_id),
    venda_id INT NOT NULL,
    FOREIGN KEY (venda_id) REFERENCES venda(venda_id)
);

CREATE TABLE IF NOT EXISTS item_movimentacao (
	item_mov_quantidade INT NOT NULL,
	mov_id INT NOT NULL,
    FOREIGN KEY (mov_id) REFERENCES movimentacao(mov_id),
    produto_id INT NOT NULL,
    FOREIGN KEY (produto_id) REFERENCES produto(produto_id)
);