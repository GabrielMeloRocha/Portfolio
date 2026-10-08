CREATE DATABASE IF NOT EXISTS SistemaImobiliaria;
USE SistemaImobiliaria;

CREATE TABLE Proprietario (
    codProp INT AUTO_INCREMENT,
    nomeProp VARCHAR(100) NOT NULL,
    CPFProp VARCHAR(14) NOT NULL UNIQUE,
    sexoProp VARCHAR(1),
    idadeProp INT,
    telProp VARCHAR(20),
    PRIMARY KEY (codProp) -- Corrigido: era (codigo)
);

CREATE TABLE Imovel (
    codImo INT AUTO_INCREMENT,
    endereco VARCHAR(255) NOT NULL,
    descricao TEXT,
    valor_aluguel DECIMAL(10, 2) NOT NULL,
    tipo VARCHAR(50),
    status VARCHAR(20),
    proprietario INT NOT NULL,
    PRIMARY KEY (codImo), -- Corrigido: era (codigo)
    -- Corrigido: Aponta para codProp da tabela Proprietario
    FOREIGN KEY (proprietario) REFERENCES Proprietario(codProp) 
        ON UPDATE CASCADE ON DELETE RESTRICT
);  

CREATE TABLE Inquilino (
    codInq INT AUTO_INCREMENT,
    nomeInq VARCHAR(100) NOT NULL,
    CPFInq VARCHAR(14) NOT NULL UNIQUE,
    sexoInq CHAR(1),
    idadeInq INT,
    telInq VARCHAR(20),
    PRIMARY KEY (codInq) -- Corrigido: era (codigo)
);  

CREATE TABLE Corretor(
    codCorr INT AUTO_INCREMENT,
    nomeCorr VARCHAR(100) NOT NULL,
    CPFCorr VARCHAR(14) NOT NULL UNIQUE,
    sexoCorr CHAR(1),
    dt_nascimento DATE,
    telCorr VARCHAR(20),
    CRECI VARCHAR(20) NOT NULL UNIQUE,
    PRIMARY KEY (codCorr) -- Corrigido: era (codigo)
);  

CREATE TABLE Aluguel (
    imovel INT NOT NULL,
    inquilino INT NOT NULL,
    corretor INT NOT NULL,
    dt_aluguel DATE NOT NULL,
    dt_vencimento DATE NOT NULL,
    valor_final_aluguel DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (imovel, inquilino, dt_aluguel), 
    -- Corrigido: Todas as referências abaixo apontavam para 'codigo'
    FOREIGN KEY (imovel) REFERENCES Imovel(codImo) 
        ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (inquilino) REFERENCES Inquilino(codInq) 
        ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (corretor) REFERENCES Corretor(codCorr) 
        ON UPDATE CASCADE ON DELETE RESTRICT
);


INSERT INTO Proprietario (nomeProp, CPFProp, sexoProp, idadeProp, telProp) 
VALUES ('Carlos Alberto Souza', '123.456.789-00', 'M', 52, '(11) 98888-1111');


INSERT INTO Inquilino (nomeInq, CPFInq, sexoInq, idadeInq, telInq) 
VALUES ('Ana Júlia Ribeiro', '456.789.012-33', 'F', 28, '(11) 97777-1111');


INSERT INTO Corretor (nomeCorr, CPFCorr, sexoCorr, dt_nascimento, telCorr, CRECI) 
VALUES ('Marcos Paulo Vieira', '789.012.345-66', 'M', '1985-04-12', '(11) 96666-1111', 'CRECI-12345-F');


INSERT INTO Imovel (endereco, descricao, valor_aluguel, tipo, status, proprietario) 
VALUES ('Av. Paulista, 1200 - Apto 42', 'Apartamento 2 quartos, mobiliado', 3500.00, 'Apartamento', 'Alugado', 1);


INSERT INTO Aluguel (imovel, inquilino, corretor, dt_aluguel, dt_vencimento, valor_final_aluguel) 
VALUES (1, 1, 1, '2026-01-10', '2026-01-10', 3400.00);


SELECT 
    a.dt_aluguel,
    i.endereco AS 'Endereço do Imóvel',
    p.nomeProp AS 'Nome do Proprietário',
    inq.nomeInq AS 'Nome do Inquilino',
    c.nomeCorr AS 'Corretor Responsável',
    a.valor_final_aluguel AS 'Valor Fechado'
FROM Aluguel a
INNER JOIN Imovel i ON a.imovel = i.codImo
INNER JOIN Proprietario p ON i.proprietario = p.codProp
INNER JOIN Inquilino inq ON a.inquilino = inq.codInq
INNER JOIN Corretor c ON a.corretor = c.codCorr;
