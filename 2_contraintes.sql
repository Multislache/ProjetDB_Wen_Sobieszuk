
-- Format de l'adresse email
ALTER TABLE Joueur
ADD CONSTRAINT chk_email_format CHECK (email LIKE '%_@__%.__%');

-- Valeurs autorisées pour le statut du compte
ALTER TABLE Joueur
ADD CONSTRAINT chk_statut_compte CHECK (statut_compte IN ('Actif', 'Suspendu', 'Banni', 'Inactif'));

-- Cohérence des dates : la date de suspension ne peut pas être antérieure à la date de création
ALTER TABLE Joueur
ADD CONSTRAINT chk_dates_compte CHECK (date_suspension IS NULL OR date_suspension >= date_creation_compte);

-- Le montant d'une transaction doit être strictement positif
ALTER TABLE Transaction
ADD CONSTRAINT chk_montant_positif CHECK (montant_transaction > 0);

-- Moyens de paiement acceptés
ALTER TABLE Transaction
ADD CONSTRAINT chk_moyen_paiement CHECK (moyen_paiement IN ('Carte Bancaire', 'PayPal', 'Virement', 'Crypto', 'Portefeuille'));

-- Valeurs possibles pour le mode de jeu
ALTER TABLE Partie
ADD CONSTRAINT chk_mode_jeu CHECK (mode_jeu IN ('Classé', 'Non classé', 'Tournoi', 'Entraînement', 'Coop'));

-- Valeurs possibles pour le résultat de la partie
ALTER TABLE Partie
ADD CONSTRAINT chk_resultat_partie CHECK (resultat_partie IN ('Victoire', 'Défaite', 'Égalité', 'Abandon'));

-- Validité de la durée (en secondes/minutes), des éliminations et du score (valeurs positives ou nulles)
ALTER TABLE Partie
ADD CONSTRAINT chk_duree_positive CHECK (duree_partie >= 0);

ALTER TABLE Partie
ADD CONSTRAINT chk_eliminations_positives CHECK (nb_elimination >= 0);

ALTER TABLE Partie
ADD CONSTRAINT chk_score_positif CHECK (score_partie >= 0);

-- Valeurs possibles pour les décisions de modération (Signalement)
ALTER TABLE Signalement
ADD CONSTRAINT chk_decision_moderation CHECK (decision_moderation IN ('En attente', 'Avertissement', 'Suspension', 'Bannissement', 'Aucune action', 'Rejeté'));
