-- ROLES
CREATE ROLE role_administrador;
CREATE ROLE role_gerente;
CREATE ROLE role_vendedor;
CREATE ROLE role_estoquista;
CREATE ROLE role_financeiro;

-- ADMIN
GRANT ALL PRIVILEGES ON localhost.* TO role_administrador;

-- GERENTE
GRANT SELECT, INSERT, UPDATE, DELETE ON localhost.pedido TO role_gerente;
GRANT SELECT, INSERT, UPDATE, DELETE ON localhost.venda TO role_gerente;
GRANT SELECT, INSERT, UPDATE ON localhost.produto TO role_gerente;
GRANT SELECT ON localhost.vw_estoque_atual TO role_gerente;
GRANT SELECT ON localhost.vw_vendas_por_periodo TO role_gerente;

-- VENDEDOR
GRANT SELECT, INSERT ON localhost.venda TO role_vendedor;
GRANT SELECT ON localhost.produto TO role_vendedor;
GRANT SELECT ON localhost.vw_estoque_atual TO role_vendedor;

-- ESTOQUISTA
GRANT SELECT, INSERT, UPDATE ON localhost.produto TO role_estoquista;
GRANT SELECT, INSERT ON localhost.movimentacao TO role_estoquista;
GRANT SELECT ON localhost.vw_estoque_atual TO role_estoquista;

-- FINANCEIRO
GRANT SELECT ON localhost.venda TO role_financeiro;
GRANT SELECT ON localhost.notafiscal TO role_financeiro;
GRANT SELECT ON localhost.vw_vendas_por_periodo TO role_financeiro;

-- USERS
CREATE USER 'admin_user'@'localhost' IDENTIFIED BY 'senha_adm';
GRANT role_administrador TO 'admin_user'@'localhost';

CREATE USER 'gerente_user'@'localhost' IDENTIFIED BY 'senha_manager';
GRANT role_gerente TO 'gerente_user'@'localhost';

CREATE USER 'vendedor_user'@'%' IDENTIFIED BY 'senha_vendedor';
GRANT role_vendedor TO 'vendedor_user'@'localhost';

CREATE USER 'estoquista_user'@'localhost' IDENTIFIED BY 'senha_estoquista';
GRANT role_estoquista TO 'estoquista_user'@'localhost';
