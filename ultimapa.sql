--
-- File generated with SQLiteStudio v3.3.3 on sex. nov. 18 14:06:49 2022
--
-- Text encoding used: UTF-8
--
PRAGMA foreign_keys = off;
BEGIN TRANSACTION;

-- Table: Campeonato
CREATE TABLE Campeonato (idCampeonato INTEGER PRIMARY KEY, dataInicio DATE CONSTRAINT nn_campeonato_dataInicio NOT NULL, idEpoca INTEGER REFERENCES Epoca (idEpoca));

-- Table: Clube
CREATE TABLE Clube (idClube INTEGER PRIMARY KEY, nome TEXT CONSTRAINT nn_clube_nome NOT NULL, cidade TEXT CONSTRAINT nn_clube_cidade NOT NULL, anoFundacao INTEGER CONSTRAINT nn_clube_anoFundacao NOT NULL, idPavilhao INTEGER REFERENCES Pavilhao (idPavilhao));

-- Table: Epoca
CREATE TABLE Epoca (idEpoca INTEGER PRIMARY KEY, dataInicio DATE CONSTRAINT nn_epoca_dataInicio NOT NULL, dataFim DATE CONSTRAINT nn_epoca_dataFim NOT NULL);

-- Table: Equipa
CREATE TABLE Equipa (idEquipa INTEGER PRIMARY KEY, nome TEXT CONSTRAINT nn_equipa_nome NOT NULL, escalao TEXT CONSTRAINT check_equipa_escalao CHECK (escalao = 'iniciados' OR escalao = 'juvenis' OR escalao = 'juniores' OR escalao = 'seniores'), genero TEXT CONSTRAINT check_equipa_genero CHECK (genero = 'feminino' OR genero = 'masculino'), idClube INTEGER REFERENCES Epoca (idEpoca), idCampeonato INTEGER REFERENCES Campeonato (idCampeonato));

-- Table: EquipaJogo
CREATE TABLE EquipaJogo (idEquipa INTEGER CONSTRAINT fk_equipajogo_idequipa REFERENCES Equipa (idEquipa) ON DELETE CASCADE ON UPDATE CASCADE, idJogo INTEGER CONSTRAINT fk_equipajogo_idjogo REFERENCES Jogo (idJogo) ON DELETE CASCADE ON UPDATE CASCADE, PRIMARY KEY (idEquipa, idJogo));

-- Table: FaseRegular
CREATE TABLE FaseRegular (idFaseRegular INTEGER PRIMARY KEY, dataInicio DATE CONSTRAINT nn_faseregular_datainicio NOT NULL, idCampeonato INTEGER REFERENCES Clube (idClube));

-- Table: Final
CREATE TABLE Final (idFinal INTEGER PRIMARY KEY, equipasApuradas TEXT CONSTRAINT nn_final_equipasapuradas NOT NULL, idPlayOff INTEGER REFERENCES PlayOff (idPlayOff), idJogo INTEGER REFERENCES Jogo (idJogo));

-- Table: Golo
CREATE TABLE Golo (idGolo INTEGER PRIMARY KEY, minuto INTEGER CONSTRAINT nn_golo_minuto NOT NULL, idJogo INTEGER REFERENCES Jogo (idJogo), idJogador INTEGER REFERENCES Jogador (idJogador));

-- Table: Jogador
CREATE TABLE Jogador (idJogador INTEGER PRIMARY KEY, nome TEXT CONSTRAINT nn_jogador_nome NOT NULL, dataNascimento DATE CONSTRAINT nn_jogador_dataNascimento NOT NULL, estado TEXT CONSTRAINT check_jogador_estado CHECK (estado = 'ativo' OR estado = 'inativo'), idEquipa INTEGER);

-- Table: Jogo
CREATE TABLE Jogo (idJogo INTEGER PRIMARY KEY, data DATE CONSTRAINT nn_jogo_data NOT NULL, hora TIME CONSTRAINT nn_jogo_hora NOT NULL, resultado, idPavilhao INTEGER REFERENCES Pavilhao (idPavilhao), idCampeonato INTEGER REFERENCES Clube (idClube));

-- Table: Jornada
CREATE TABLE Jornada (idJornada INTEGER PRIMARY KEY, numero INTEGER CONSTRAINT unique_jornada_numero UNIQUE CONSTRAINT nn_jornada_numero NOT NULL CONSTRAINT check_jornada_numero CHECK (numero > 0 AND numero < 27), idFaseRegular INTEGER REFERENCES FaseRegular (idFaseRegular), idJogo INTEGER REFERENCES Jogo (idJogo));

-- Table: MeiasFinais
CREATE TABLE MeiasFinais (idMeiasFinais INTEGER PRIMARY KEY, equipasApuradas TEXT CONSTRAINT nn_meiasfinais_equipasapuradas NOT NULL, idPlayOff INTEGER REFERENCES PlayOff (idPlayOff), idJogo INTEGER REFERENCES Jogo (idJogo));

-- Table: Pavilhao
CREATE TABLE Pavilhao (idPavilhao INTEGER PRIMARY KEY, nome TEXT CONSTRAINT nn_pavilhao_nome NOT NULL, local TEXT CONSTRAINT nn_pavilhao_local NOT NULL CONSTRAINT unique_pavilhao_local UNIQUE);

-- Table: PlayOff
CREATE TABLE PlayOff (idPlayOff INTEGER PRIMARY KEY, dataInicio DATE CONSTRAINT nn_playoff_datainicio NOT NULL, idCampeonato INTEGER REFERENCES Clube (idClube));

-- Table: QuartosFinal
CREATE TABLE QuartosFinal (idQuartosFinal INTEGER PRIMARY KEY, equipasApuradas TEXT CONSTRAINT nn_quartosfinal_equipasapuradas NOT NULL, idPlayOff INTEGER REFERENCES PlayOff (idPlayOff), idJogo INTEGER REFERENCES Jogo (idJogo));

-- Table: ResultadoCampeonato
CREATE TABLE ResultadoCampeonato (idResultadoCampeonato INTEGER PRIMARY KEY, equipaApuradaLigaCampeoes TEXT CONSTRAINT nn_resultadocampeonato_equipaapuradaligacampeoes NOT NULL, equipaDespromovida1 TEXT CONSTRAINT nn_resultadocampeonato_equipadespromovida1 NOT NULL, equipaDespromovida2 TEXT CONSTRAINT nn_resultadocampeonato_equipadespromovida2 NOT NULL, idFinal INTEGER REFERENCES Final (idFinal));

COMMIT TRANSACTION;
PRAGMA foreign_keys = on;
