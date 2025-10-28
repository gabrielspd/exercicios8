-- ===============================================
-- Cafeteria BomGosto
-- Banco: PostgreSQL
-- ===============================================

-- ============================================================
-- TABELAS gerando
-- ============================================================

-- Tabela de cardápio: lista de cafés disponíveis
CREATE TABLE cardapio (
    codigo SERIAL PRIMARY KEY,
    nome VARCHAR(100) UNIQUE NOT NULL,
    descricao TEXT NOT NULL,
    preco_unitario NUMERIC(10,2) NOT NULL
);

-- Tabela de comandas: registra as vendas de um cliente
CREATE TABLE comanda (
    codigo SERIAL PRIMARY KEY,
    data DATE NOT NULL,
    mesa INT NOT NULL,
    nome_cliente VARCHAR(100) NOT NULL
);

-- Tabela de itens da comanda: associa cafés vendidos a uma comanda
CREATE TABLE item_comanda (
    codigo_comanda INT REFERENCES comanda(codigo) ON DELETE CASCADE,
    codigo_cardapio INT REFERENCES cardapio(codigo),
    quantidade INT NOT NULL CHECK (quantidade > 0),
    PRIMARY KEY (codigo_comanda, codigo_cardapio)
);

-- ============================================================
-- Dados inserir
-- ============================================================

-- Inserindo cafés no cardápio
INSERT INTO cardapio (nome, descricao, preco_unitario) VALUES
('Café Expresso', 'Café puro', 5.00),
('Cappuccino', 'Café com leite e espuma cremosa', 8.50),
('Mocha', 'Café com chocolate e leite vaporizado', 9.00),
('Latte', 'Café suave com leite vaporizado', 7.50),
('Macchiato', 'Café expresso com uma pequena camada de espuma', 6.50);

-- Inserindo comandas
INSERT INTO comanda (data, mesa, nome_cliente) VALUES
('2025-10-25', 1, 'Ana'),
('2025-10-25', 2, 'Bruno'),
('2025-10-26', 3, 'Clara'),
('2025-10-27', 1, 'Diego');

-- Inserindo itens de comandas
INSERT INTO item_comanda (codigo_comanda, codigo_cardapio, quantidade) VALUES
(1, 1, 2),  -- Ana pediu 2 Cafés Expresso
(1, 2, 1),  -- Ana pediu 1 Cappuccino
(2, 3, 1),  -- Bruno pediu 1 Mocha
(3, 1, 1),  -- Clara pediu 1 Café Expresso
(3, 4, 2),  -- Clara pediu 2 Lattes
(4, 5, 3);  -- Diego pediu 3 Macchiatos


-- ============================================================
-- Atividade
-- ============================================================


-- ------------------------------------------------------------
-- (1) Listagem do cardápio ordenada por nome
-- ------------------------------------------------------------
SELECT * FROM cardapio ORDER BY nome;

-- ------------------------------------------------------------
-- (2) Todas as comandas e seus itens, ordenadas por data, 
--     código da comanda e nome do café
-- ------------------------------------------------------------
SELECT 
    c.*, 
    ca.nome AS nome_cafe, 
    ca.descricao, 
    i.quantidade, 
    ca.preco_unitario, 
    i.quantidade * ca.preco_unitario AS preco_total_cafe
FROM comanda c
JOIN item_comanda i ON c.codigo = i.codigo_comanda
JOIN cardapio ca ON i.codigo_cardapio = ca.codigo
ORDER BY c.data, c.codigo, ca.nome;

-- ------------------------------------------------------------
-- (3) Listar todas as comandas com valor total da comanda
-- ------------------------------------------------------------
SELECT 
    c.*, 
    SUM(i.quantidade * ca.preco_unitario) AS valor_total_comanda
FROM comanda c
JOIN item_comanda i ON c.codigo = i.codigo_comanda
JOIN cardapio ca ON i.codigo_cardapio = ca.codigo
GROUP BY c.codigo
ORDER BY c.data;

-- ------------------------------------------------------------
-- (4) Listar comandas com mais de um tipo de café
-- ------------------------------------------------------------
SELECT 
    c.*, 
    SUM(i.quantidade * ca.preco_unitario) AS valor_total_comanda
FROM comanda c
JOIN item_comanda i ON c.codigo = i.codigo_comanda
JOIN cardapio ca ON i.codigo_cardapio = ca.codigo
GROUP BY c.codigo
HAVING COUNT(DISTINCT i.codigo_cardapio) > 1
ORDER BY c.data;

-- ------------------------------------------------------------
-- (5) Total de faturamento por data
-- ------------------------------------------------------------
SELECT 
    data,
    SUM(i.quantidade * ca.preco_unitario) AS faturamento_total
FROM comanda c
JOIN item_comanda i USING (codigo)
JOIN cardapio ca ON i.codigo_cardapio = ca.codigo
GROUP BY data
ORDER BY data;

-- ============================================================
-- Comentarios
-- 
-- ============================================================

