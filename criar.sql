PRAGMA foreign_keys = on;
.mode columns
.headers on

#TABELA Equipa
DROP TABLE IS EXISTS Equipa;
CREATE TABLE Equipa (
    nome            STRING NOT NULL,
    faixaEtaria     STRING NOT NULL,
    genero          STRING NOT NULL

)