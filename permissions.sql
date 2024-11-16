-- ROLES
CREATE ROLE role_administrador;
CREATE ROLE role_gerente;
CREATE ROLE role_vendedor;
CREATE ROLE role_estoquista;
CREATE ROLE role_financeiro;

-- ADMIN
GRANT ALL PRIVILEGES ON trabalhosql.* TO role_administrador;

-- GERENTE
GRANT SELECT, INSERT, UPDATE, DELETE ON trabalhosql.pedido TO role_gerente;
GRANT SELECT, INSERT, UPDATE, DELETE ON trabalhosql.venda TO role_gerente;
GRANT SELECT, INSERT, UPDATE ON trabalhosql.produto TO role_gerente;
GRANT SELECT ON trabalhosql.vw_estoque_atual TO role_gerente;
GRANT SELECT ON trabalhosql.vw_vendas_por_periodo TO role_gerente;

-- VENDEDOR
GRANT SELECT, INSERT ON trabalhosql.venda TO role_vendedor;
GRANT SELECT ON trabalhosql.produto TO role_vendedor;
GRANT SELECT ON trabalhosql.vw_estoque_atual TO role_vendedor;

-- ESTOQUISTA
GRANT SELECT, INSERT, UPDATE ON trabalhosql.produto TO role_estoquista;
GRANT SELECT, INSERT ON trabalhosql.movimentacao TO role_estoquista;
GRANT SELECT ON trabalhosql.vw_estoque_atual TO role_estoquista;

-- FINANCEIRO
GRANT SELECT ON trabalhosql.venda TO role_financeiro;
GRANT SELECT ON trabalhosql.notafiscal TO role_financeiro;
GRANT SELECT ON trabalhosql.vw_vendas_por_periodo TO role_financeiro;

-- USERS
CREATE USER 'admin_user'@'%' IDENTIFIED BY 'senha_adm';
GRANT role_administrador TO 'admin_user'@'%';

CREATE USER 'gerente_user'@'%' IDENTIFIED BY 'senha_manager';
GRANT role_gerente TO 'gerente_user'@'%';

CREATE USER 'vendedor_user'@'%' IDENTIFIED BY 'senha_vendedor';
GRANT role_vendedor TO 'vendedor_user'@'%';

CREATE USER 'estoquista_user'@'%' IDENTIFIED BY 'senha_estoquista';
GRANT role_estoquista TO 'estoquista_user';
