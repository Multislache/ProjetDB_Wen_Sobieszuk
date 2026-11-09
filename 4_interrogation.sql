-- ÉTAPE 1 - IDENTIFICATION DE LA JOUEUSE

-- Retrouver le compte à partir du pseudo et de l'email donnés au support
SELECT id_joueur, pseudo, email, date_creation_compte, pays_residence FROM Joueur
WHERE pseudo = 'Keria' AND email = 'keria@gmail.com';

-- La joueuse a fait une faute de frappe dans son pseudo : recherche par masque
SELECT id_joueur, pseudo, email, pays_residence FROM Joueur
WHERE pseudo LIKE 'Ker%' AND email LIKE '%@gmail.com'
ORDER BY pseudo;

-- Statut du compte de Keria sur Valorant (id_jeu = 2)
SELECT id_joueur, id_jeu, statut_compte, date_suspension, motif_suspension FROM joue_a
WHERE id_joueur = 25 AND id_jeu = 2;




-- ÉTAPE 2 - EXAMEN DU DOSSIER

-- Jointure interne multiple : la partie Valorant où Keria a été bannie
SELECT p.id_partie, p.date_partie, p.mode_jeu, j.nom_jeu, s.id_signalement, s.motif_signalement, s.decision_moderation FROM Joueur jo
JOIN joue_dans jd ON jd.id_joueur = jo.id_joueur
JOIN Partie p ON p.id_partie = jd.id_partie
JOIN Jeu j ON j.id_jeu = p.id_jeu
JOIN Signalement s ON s.id_partie = p.id_partie
WHERE jo.pseudo = 'Keria' AND j.nom_jeu = 'Valorant' AND s.decision_moderation IN ('Bannissement', 'Rejeté');

-- Auto-jointure : les autres joueurs présents dans la partie du ban (témoins), avec leur statut sur Valorant
SELECT jd2.id_partie, jo2.pseudo AS autre_joueur, ja.statut_compte, ja.motif_suspension FROM joue_dans jd1
JOIN joue_dans jd2 ON jd2.id_partie = jd1.id_partie AND jd2.id_joueur <> jd1.id_joueur
JOIN Joueur jo2 ON jo2.id_joueur = jd2.id_joueur
LEFT JOIN joue_a ja ON ja.id_joueur = jd2.id_joueur AND ja.id_jeu = 2
WHERE jd1.id_joueur = 25 AND jd1.id_partie = 51;

-- Jointure externe droite : toutes les parties Valorant, signalées ou non (le ban de Keria est-il un cas isolé ?)
SELECT p.id_partie, p.date_partie, s.motif_signalement, s.decision_moderation FROM Signalement s
RIGHT JOIN Partie p ON p.id_partie = s.id_partie
WHERE p.id_jeu = 2
ORDER BY p.date_partie;






-- ÉTAPE 3 - LEVÉE DU BAN

-- Le ban de Keria sur Valorant est jugé illégitime : levée de la sanction
START TRANSACTION;

UPDATE joue_a SET statut_compte = 'Actif', date_suspension = NULL, motif_suspension = NULL
WHERE id_joueur = 25 AND id_jeu = 2;

-- On garde la trace du signalement mais la décision est annulée
UPDATE Signalement SET decision_moderation = 'Rejeté'
WHERE id_partie = 51 AND id_signalement = 16;

-- Variante : supprimer complètement le signalement
-- DELETE FROM Signalement WHERE id_partie = 51 AND id_signalement = 16;

COMMIT;

-- Vérification : Keria est de nouveau active sur Valorant et la décision est annulée
SELECT id_joueur, id_jeu, statut_compte, date_suspension, motif_suspension FROM joue_a
WHERE id_joueur = 25;

SELECT * FROM Signalement WHERE id_partie = 51;





-- ÉTAPE 4 - REMBOURSEMENT

-- Jointure interne : achats League of Legends de Keria
SELECT t.id_transaction, t.montant_transaction, t.date_transaction, t.moyen_paiement, j.nom_jeu FROM Transaction t
JOIN Jeu j ON j.id_jeu = t.id_jeu
JOIN Joueur jo ON jo.id_joueur = t.id_joueur
WHERE jo.pseudo = 'Keria' AND j.nom_jeu = 'League of Legends';

-- Achats de Keria éligibles à un remboursement automatique : montant entre 1 et 50 €, payés par carte, PayPal ou virement
SELECT id_transaction, id_jeu, montant_transaction, date_transaction, moyen_paiement FROM Transaction
WHERE id_joueur = 25 AND montant_transaction BETWEEN 1 AND 50 AND moyen_paiement IN ('Carte Bancaire', 'PayPal', 'Virement')
ORDER BY date_transaction DESC;

-- Remboursement de l'achat League of Legends (transaction 19)
-- Un montant négatif est interdit (chk_montant_positif) donc on supprime la transaction
START TRANSACTION;

DELETE FROM Transaction WHERE id_transaction = 19 AND id_joueur = 25 AND id_jeu = 1;

COMMIT;

-- Vérification : la transaction n'existe plus (aucune ligne attendue)
SELECT * FROM Transaction WHERE id_transaction = 19;




-- ÉTAPE 5 - ENQUÊTE TECHNIQUE


-- Historique des patchs Valorant, dans l'ordre chronologique
SELECT id_patch, num_version, date_publication FROM Patch
WHERE id_jeu = 2
ORDER BY date_publication;

-- Parties Valorant jouées pendant la période suspecte
SELECT id_partie, date_partie, mode_jeu, resultat_partie, score_partie FROM Partie
WHERE id_jeu = 2 AND date_partie BETWEEN '2023-06-01' AND '2023-11-30'
ORDER BY date_partie;

-- Signalements Valorant pour scripts, mois par mois (repérer le début des bans)
SELECT YEAR(p.date_partie) AS annee, MONTH(p.date_partie) AS mois, COUNT(*) AS nb_signalements FROM Signalement s
JOIN Partie p ON p.id_partie = s.id_partie
WHERE p.id_jeu = 2 AND s.motif_signalement = 'Utilisation de scripts'
GROUP BY YEAR(p.date_partie), MONTH(p.date_partie)
ORDER BY annee, mois;

-- IN : date du premier ban Vanguard sur Valorant
SELECT MIN(p.date_partie) AS debut_des_bans FROM Partie p
WHERE p.id_jeu = 2 AND p.id_partie IN (SELECT s.id_partie FROM Signalement s
    WHERE s.motif_signalement = 'Utilisation de scripts' AND s.decision_moderation IN ('Bannissement', 'Rejeté'));

-- Théta-jointure (condition non égalitaire) : pour chaque ban Valorant, les patchs déjà en ligne au moment de la partie
SELECT p.id_partie, p.date_partie, pa.num_version, pa.date_publication FROM Partie p
JOIN Signalement s ON s.id_partie = p.id_partie
JOIN Patch pa ON pa.id_jeu = p.id_jeu AND pa.date_publication <= p.date_partie
WHERE p.id_jeu = 2 AND s.decision_moderation IN ('Bannissement', 'Rejeté')
ORDER BY p.date_partie, pa.date_publication DESC;

-- ALL : le patch suspect est le patch Valorant publié avant le premier ban et plus récent que tous les autres patchs publiés avant ce ban
-- Résultat attendu : v6.11 (2023-06-27), à transmettre à l'équipe développement
SELECT pa.id_patch, pa.num_version, pa.date_publication FROM Patch pa
WHERE pa.id_jeu = 2
AND pa.date_publication <= (SELECT MIN(p.date_partie) FROM Partie p
    JOIN Signalement s ON s.id_partie = p.id_partie
    WHERE p.id_jeu = 2 AND s.motif_signalement = 'Utilisation de scripts' AND s.decision_moderation IN ('Bannissement', 'Rejeté'))
AND pa.date_publication >= ALL (SELECT pa2.date_publication FROM Patch pa2
    WHERE pa2.id_jeu = 2 AND pa2.date_publication <= (SELECT MIN(p.date_partie) FROM Partie p
        JOIN Signalement s ON s.id_partie = p.id_partie
        WHERE p.id_jeu = 2 AND s.motif_signalement = 'Utilisation de scripts' AND s.decision_moderation IN ('Bannissement', 'Rejeté')));





-- ÉTAPE 6 - RECENSEMENT DES JOUEURS TOUCHÉS

-- Tous les comptes actuellement sanctionnés, du plus récent au plus ancien
SELECT id_joueur, id_jeu, statut_compte, motif_suspension, date_suspension FROM joue_a
WHERE statut_compte IN ('Banni', 'Suspendu')
ORDER BY date_suspension DESC;

-- Motifs de sanction distincts utilisés par la modération
SELECT DISTINCT motif_suspension FROM joue_a
WHERE motif_suspension IS NOT NULL
ORDER BY motif_suspension;

-- Motifs de sanction utilisés au moins 2 fois, et sur combien de jeux
SELECT motif_suspension, COUNT(*) AS nb_sanctions, COUNT(DISTINCT id_jeu) AS nb_jeux FROM joue_a
WHERE motif_suspension IS NOT NULL
GROUP BY motif_suspension
HAVING COUNT(*) >= 2
ORDER BY nb_sanctions DESC;

-- Jeux comptant au moins 2 comptes sanctionnés (bannis ou suspendus)
SELECT j.nom_jeu, COUNT(*) AS nb_sanctions, SUM(CASE WHEN ja.statut_compte = 'Banni' THEN 1 ELSE 0 END) AS nb_bannis FROM joue_a ja
JOIN Jeu j ON j.id_jeu = ja.id_jeu
WHERE ja.statut_compte IN ('Banni', 'Suspendu')
GROUP BY j.nom_jeu
HAVING COUNT(*) >= 2
ORDER BY nb_sanctions DESC;

-- IN : joueurs ayant participé à une partie qui a mené à un bannissement
SELECT id_joueur, pseudo FROM Joueur
WHERE id_joueur IN (SELECT jd.id_joueur FROM joue_dans jd
    JOIN Signalement s ON s.id_partie = jd.id_partie
    WHERE s.decision_moderation IN ('Bannissement', 'Rejeté'))
ORDER BY pseudo;

-- Joueurs ayant disputé une partie classée de Valorant, avec la date (population exposée aux bans Vanguard en classé)
-- Requête étudiée dans le README (optimisation par l'algèbre relationnelle)
SELECT jo.pseudo, p.date_partie FROM Joueur jo
JOIN joue_dans jd ON jd.id_joueur = jo.id_joueur
JOIN Partie p ON p.id_partie = jd.id_partie
WHERE p.id_jeu = 2 AND p.mode_jeu = 'Classé'
ORDER BY p.date_partie;

-- ANY : joueurs de Valorant encore actifs, mieux classés qu'au moins un joueur banni pour triche Vanguard (profils exposés au même faux positif)
SELECT jo.pseudo, jo.rang_joueur FROM Joueur jo
JOIN joue_a ja ON ja.id_joueur = jo.id_joueur
WHERE ja.id_jeu = 2 AND ja.statut_compte = 'Actif' AND jo.rang_joueur > ANY (SELECT jo2.rang_joueur FROM Joueur jo2
    JOIN joue_a ja2 ON ja2.id_joueur = jo2.id_joueur
    WHERE ja2.motif_suspension = 'Triche avérée (Vanguard)')
ORDER BY jo.rang_joueur DESC;

-- Sous-requête dans le FROM : joueurs qui jouent plus que la moyenne (les plus exposés aux contrôles de l'anti-triche, à vérifier en priorité)
SELECT jo.pseudo, stats.nb_parties FROM Joueur jo
JOIN (SELECT id_joueur, COUNT(*) AS nb_parties FROM joue_dans GROUP BY id_joueur) AS stats ON stats.id_joueur = jo.id_joueur
WHERE stats.nb_parties > (SELECT AVG(nb) FROM (SELECT COUNT(*) AS nb FROM joue_dans GROUP BY id_joueur) AS t)
ORDER BY stats.nb_parties DESC, jo.pseudo;

-- NOT EXISTS : sanctions (bans et suspensions) sans aucune partie du même jeu ayant donné lieu à une sanction, donc à revérifier
SELECT jo.pseudo, j.nom_jeu, ja.statut_compte, ja.motif_suspension, ja.date_suspension FROM joue_a ja
JOIN Joueur jo ON jo.id_joueur = ja.id_joueur
JOIN Jeu j ON j.id_jeu = ja.id_jeu
WHERE ja.statut_compte IN ('Banni', 'Suspendu') AND NOT EXISTS (SELECT 1 FROM joue_dans jd
    JOIN Partie p ON p.id_partie = jd.id_partie
    JOIN Signalement s ON s.id_partie = p.id_partie
    WHERE jd.id_joueur = ja.id_joueur AND p.id_jeu = ja.id_jeu AND s.decision_moderation IN ('Avertissement', 'Suspension', 'Bannissement'))
ORDER BY ja.date_suspension;

-- NOT IN : joueurs jamais impliqués dans une partie signalée (comptes « sains », exclus de la revérification)
SELECT id_joueur, pseudo FROM Joueur
WHERE id_joueur NOT IN (SELECT jd.id_joueur FROM joue_dans jd
    JOIN Signalement s ON s.id_partie = jd.id_partie)
ORDER BY pseudo;




-- ÉTAPE 7 - BILAN ET COMPENSATION

-- Bilan de la modération : nombre de signalements par décision
SELECT decision_moderation, COUNT(*) AS nb_signalements FROM Signalement
GROUP BY decision_moderation
ORDER BY nb_signalements DESC;

-- Statistiques de jeu par titre (jeux ayant au moins 5 parties) pour vérifier si les scores Valorant sont anormaux
SELECT j.nom_jeu, COUNT(*) AS nb_parties, ROUND(AVG(p.duree_partie)) AS duree_moyenne, MAX(p.score_partie) AS meilleur_score, SUM(p.nb_elimination) AS total_eliminations FROM Partie p
JOIN Jeu j ON j.id_jeu = p.id_jeu
GROUP BY j.nom_jeu
HAVING COUNT(*) >= 5
ORDER BY nb_parties DESC;

-- Chiffre d'affaires par jeu (jeux dépassant 200 €) : ordre de grandeur de l'enjeu financier d'une compensation
SELECT j.nom_jeu, COUNT(*) AS nb_achats, SUM(t.montant_transaction) AS total_ventes, ROUND(AVG(t.montant_transaction), 2) AS panier_moyen FROM Transaction t
JOIN Jeu j ON j.id_jeu = t.id_jeu
GROUP BY j.nom_jeu
HAVING SUM(t.montant_transaction) > 200
ORDER BY total_ventes DESC;

-- Jointure externe gauche : tous les jeux et leur dernier patch (0 patch compris), pour savoir quels jeux devront recevoir le correctif
SELECT j.nom_jeu, COUNT(pa.id_patch) AS nb_patchs, MAX(pa.date_publication) AS dernier_patch FROM Jeu j
LEFT JOIN Patch pa ON pa.id_jeu = j.id_jeu
GROUP BY j.id_jeu, j.nom_jeu
ORDER BY nb_patchs DESC, j.nom_jeu;

-- Jointure externe gauche : montant dépensé sur Valorant par chaque joueur de Valorant (0 compris), pour calibrer la compensation
SELECT jo.pseudo, COUNT(t.id_transaction) AS nb_achats_valorant, COALESCE(SUM(t.montant_transaction), 0) AS total_depense FROM joue_a ja
JOIN Joueur jo ON jo.id_joueur = ja.id_joueur
LEFT JOIN Transaction t ON t.id_joueur = ja.id_joueur AND t.id_jeu = ja.id_jeu
WHERE ja.id_jeu = 2
GROUP BY jo.id_joueur, jo.pseudo
ORDER BY total_depense DESC, jo.pseudo;

-- EXISTS : joueurs ayant déjà acheté sur Valorant, éligibles à une compensation en points de jeu
SELECT jo.id_joueur, jo.pseudo FROM Joueur jo
WHERE EXISTS (SELECT 1 FROM Transaction t WHERE t.id_joueur = jo.id_joueur AND t.id_jeu = 2)
ORDER BY jo.pseudo;