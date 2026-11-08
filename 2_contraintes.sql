-- 2_contraintes.sql
-- Contraintes de validation des données ajustées au nouveau MLD.

ALTER TABLE Joueur
ADD CONSTRAINT chk_email_format CHECK (email LIKE '%_@__%.__%');

-- La contrainte du statut_compte est déplacée sur la table joue_a
ALTER TABLE joue_a
ADD CONSTRAINT chk_statut_compte CHECK (statut_compte IN ('Actif', 'Suspendu', 'Banni', 'Inactif'));

ALTER TABLE Transaction
ADD CONSTRAINT chk_montant_positif CHECK (montant_transaction > 0);

ALTER TABLE Transaction
ADD CONSTRAINT chk_moyen_paiement CHECK (moyen_paiement IN ('Carte Bancaire', 'PayPal', 'Virement', 'Crypto', 'Portefeuille'));

ALTER TABLE Partie
ADD CONSTRAINT chk_mode_jeu CHECK (mode_jeu IN ('Classé', 'Non classé', 'Tournoi', 'Entraînement', 'Coop'));

ALTER TABLE Partie
ADD CONSTRAINT chk_resultat_partie CHECK (resultat_partie IN ('Victoire', 'Défaite', 'Égalité', 'Abandon'));

ALTER TABLE Partie
ADD CONSTRAINT chk_duree_positive CHECK (duree_partie >= 0);

ALTER TABLE Partie
ADD CONSTRAINT chk_eliminations_positives CHECK (nb_elimination >= 0);

ALTER TABLE Partie
ADD CONSTRAINT chk_score_positif CHECK (score_partie >= 0);

ALTER TABLE Signalement
ADD CONSTRAINT chk_decision_moderation CHECK (decision_moderation IN ('En attente', 'Avertissement', 'Suspension', 'Bannissement', 'Aucune action', 'Rejeté'));
