-- 1_creation.sql
-- MPD généré à partir de la version 2 du MLD (Corrections Transactions et Bannissements)

CREATE TABLE Joueur (
    id_joueur INT PRIMARY KEY,
    pseudo VARCHAR(50) NOT NULL,
    email VARCHAR(150) NOT NULL,
    mot_de_passe_hash VARCHAR(255) NOT NULL,
    date_creation_compte DATE NOT NULL,
    pays_residence VARCHAR(50),
    rang_joueur INT
);

CREATE TABLE Jeu (
    id_jeu INT PRIMARY KEY,
    nom_jeu VARCHAR(100) NOT NULL,
    genre_jeu VARCHAR(50),
    date_sortie_jeu DATE,
    plateforme VARCHAR(50)
);

CREATE TABLE Transaction (
    id_transaction INT PRIMARY KEY,
    montant_transaction DECIMAL(10, 2) NOT NULL,
    date_transaction DATETIME NOT NULL,
    moyen_paiement VARCHAR(50),
    id_joueur INT NOT NULL,
    id_jeu INT NOT NULL,
    FOREIGN KEY (id_joueur) REFERENCES Joueur(id_joueur) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_jeu) REFERENCES Jeu(id_jeu) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE joue_a (
    id_joueur INT,
    id_jeu INT,
    statut_compte VARCHAR(20) NOT NULL,
    date_suspension DATE,
    motif_suspension TEXT,
    PRIMARY KEY (id_joueur, id_jeu),
    FOREIGN KEY (id_joueur) REFERENCES Joueur(id_joueur) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_jeu) REFERENCES Jeu(id_jeu) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Patch (
    id_jeu INT,
    id_patch INT,
    num_version VARCHAR(20) NOT NULL,
    date_publication DATE,
    PRIMARY KEY (id_jeu, id_patch),
    FOREIGN KEY (id_jeu) REFERENCES Jeu(id_jeu) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Personnage (
    id_jeu INT,
    id_personnage INT,
    nom_personnage VARCHAR(100) NOT NULL,
    role_personnage VARCHAR(50),
    date_ajout_personnage DATE,
    PRIMARY KEY (id_jeu, id_personnage),
    FOREIGN KEY (id_jeu) REFERENCES Jeu(id_jeu) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Partie (
    id_partie INT PRIMARY KEY,
    date_partie DATETIME NOT NULL,
    mode_jeu VARCHAR(50),
    duree_partie INT,
    resultat_partie VARCHAR(20),
    nb_elimination INT,
    score_partie INT,
    id_jeu INT,
    FOREIGN KEY (id_jeu) REFERENCES Jeu(id_jeu) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE joue_dans (
    id_joueur INT,
    id_partie INT,
    PRIMARY KEY (id_joueur, id_partie),
    FOREIGN KEY (id_joueur) REFERENCES Joueur(id_joueur) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_partie) REFERENCES Partie(id_partie) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Signalement (
    id_partie INT,
    id_signalement INT,
    motif_signalement TEXT NOT NULL,
    decision_moderation VARCHAR(50),
    PRIMARY KEY (id_partie, id_signalement),
    FOREIGN KEY (id_partie) REFERENCES Partie(id_partie) ON DELETE CASCADE ON UPDATE CASCADE
);
