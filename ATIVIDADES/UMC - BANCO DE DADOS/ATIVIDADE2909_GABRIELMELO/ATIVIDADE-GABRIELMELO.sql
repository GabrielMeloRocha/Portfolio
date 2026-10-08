CREATE DATABASE IF NOT EXISTS SistemaLogistica;
USE SistemaLogistica;

CREATE TABLE Fornecedor (    
    codFornecedor INT AUTO_INCREMENT,    
    nomeFornecedor VARCHAR (100) NOT NULL,    
    endereco VARCHAR (255),    
    telefone VARCHAR (25),    
    ativo BOOLEAN DEFAULT TRUE,    
    PRIMARY KEY (codFornecedor) 
);

CREATE TABLE Produto (
   codProduto INT AUTO_INCREMENT,
   nomeProduto VARCHAR (100) NOT NULL,
   dt_validade DATE NOT NULL,
   ativo BOOLEAN DEFAULT TRUE,
  PRIMARY KEY (codProduto)
);

CREATE TABLE Fornecimento (
   codFornecedor INT,
   codProduto INT,
   dt_fornecimento DATE NOT NULL,
   quantidade INT NOT NULL,
   PRIMARY KEY (codFornecedor, codProduto, dt_fornecimento),
   CONSTRAINT fk_fornecimento_fornecedor
       FOREIGN KEY (codFornecedor)
	   REFERENCES Fornecedor (codFornecedor)
       ON DELETE CASCADE,
	CONSTRAINT fk_fornecimento_produto
       FOREIGN KEY (codProduto)
	   REFERENCES Produto (codProduto)
       ON DELETE CASCADE
	);
    
INSERT INTO Fornecedor (nomeFornecedor, endereco, telefone) VALUES
('Distribuidora Omega', 'Rua Monteiro Lobato, 981 - São Paulo', '(11) 99999-1111'),
('Logística Veraz', 'Av. Central do Brasil, 478 - Rio de Janeiro', '(21) 98888-2222');

INSERT INTO Produto (nomeProduto, dt_validade) VALUES
('Arroz Integral 1kg', '2027-06-30'),
('Feijão Preto 1kg', '2027-05-15');

INSERT INTO Fornecimento (codFornecedor, codProduto, dt_fornecimento, quantidade) VALUES 
(1, 1, '2026-11-01', 650),
(2, 2, '2026-10-31', 495);

SET SQL_SAFE_UPDATES = 0;

-- Executa as atualizações em lote
UPDATE Fornecedor SET ativo = TRUE;
UPDATE Produto SET ativo = TRUE;

-- Reativa o modo seguro (Boa prática)
SET SQL_SAFE_UPDATES = 1;

SELECT 
    p.nomeProduto AS "Nome do Produto",
    f.nomeFornecedor AS "Nome do Fornecedor",
    fo.dt_fornecimento AS "Data do Fornecimento"
FROM Fornecimento fo
INNER JOIN Produto p ON fo.codProduto = p.codProduto
INNER JOIN Fornecedor f ON fo.codFornecedor = f.codFornecedor;