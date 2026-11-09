Règles de gestion
Jeux et catalogue

L'entreprise édite plusieurs jeux vidéo (ex. League of Legends, Valorant, Teamfight Tactics).
Chaque jeu possède un nom, une date de sortie, un genre et une plateforme de diffusion.
Un jeu peut recevoir plusieurs mises à jour (patchs) au fil du temps, chacune identifiée par un numéro de version et une date de publication.
Joueurs et comptes

Une personne doit créer un compte joueur pour accéder à un jeu.
Un compte est identifié par un pseudonyme unique et une adresse email.
Un joueur peut posséder un compte sur plusieurs jeux de l'entreprise.
Chaque compte enregistre une date de création et un pays de résidence déclaré.
Un compte peut être suspendu ; dans ce cas, un motif et une date de suspension sont conservés.
Parties et statistiques

Chaque partie jouée est enregistrée avec une date, une durée et un mode de jeu (classé, normal, événement spécial).
Une partie regroupe plusieurs joueurs répartis en équipes.
À l'issue de chaque partie, le système enregistre le résultat (victoire/défaite) et des statistiques individuelles (score, nombre d'éliminations, etc.) pour chaque joueur participant.
Un joueur se voit attribuer un rang (classement compétitif) qui évolue selon ses résultats en partie classée.
Personnages et contenus jouables

Chaque jeu propose un ensemble de personnages (ou agents/champions) jouables.
Un personnage possède un nom, un rôle (ex. combattant, support, tireur) et une date d'ajout au jeu.
Un joueur peut débloquer ou posséder des personnages et des objets cosmétiques (skins).
Achats et transactions

Un joueur peut effectuer des achats en jeu (monnaie virtuelle, cosmétiques, pass de combat saisonnier).
Chaque transaction est horodatée et associée à un montant et un moyen de paiement.
Support et communauté

Un joueur peut soumettre un signalement (report) contre un autre joueur pour comportement inapproprié, avec une catégorie de motif.
Un signalement est traité par un modérateur, qui enregistre une décision et une date de traitement.
Dictionnaire de données
N°	Nom de la donnée	Signification	Type	Taille 

1	id_joueur	Identifiant unique du compte joueur	Numérique	10

2	pseudo	Pseudonyme affiché du joueur	Alphanumérique	30

3	email	Adresse email du joueur	Alphanumérique	100

4	mot_de_passe_hash	Empreinte du mot de passe du compte	Alphanumérique	64

5	date_creation_compte	Date de création du compte	Date	10

6	pays_residence	Pays déclaré par le joueur	Alphabétique	50

7	statut_compte	État du compte (actif/suspendu)	Alphabétique	15

8	motif_suspension	Raison d'une suspension de compte	Alphanumérique	200

9	date_suspension	Date de suspension du compte	Date	10

10	id_jeu	Identifiant unique du jeu	Numérique	5

11	nom_jeu	Nom commercial du jeu	Alphanumérique	50

12	genre_jeu	Genre du jeu (MOBA, FPS, stratégie…)	Alphabétique	30

13	date_sortie_jeu	Date de sortie officielle du jeu	Date	10

14	plateforme	Plateforme de diffusion (PC, mobile, console)	Alphanumérique	20

15	id_patch	Identifiant unique d'une mise à jour	Numérique	8

16	numero_version	Numéro de version du patch	Alphanumérique	10

17	date_publication_patch	Date de mise en ligne du patch	Date	10

18	id_partie	Identifiant unique de la partie	Numérique	12

19	date_partie	Date à laquelle la partie a eu lieu	Date	10

20	duree_partie	Durée de la partie en minutes	Numérique	4

21	mode_jeu	Mode de la partie (classé, normal, événement)	Alphabétique	20

22	resultat_partie	Résultat pour le joueur (victoire/défaite)	Alphabétique	10

23	nombre_eliminations	Nombre d'éliminations réalisées en partie	Numérique	3

24	score_partie	Score obtenu par le joueur pendant la partie	Numérique	6

25	rang_joueur	Rang compétitif actuel du joueur	Alphanumérique	20

26	id_personnage	Identifiant unique du personnage jouable	Numérique	6

27	nom_personnage	Nom du personnage/agent/champion	Alphanumérique	30

28	role_personnage	Rôle du personnage (support, tireur…)	Alphabétique	20

29	date_ajout_personnage	Date d'ajout du personnage au jeu	Date	10

30	id_transaction	Identifiant unique de la transaction	Numérique	12

31	montant_transaction	Montant payé lors de l'achat	Numérique	8

32	date_transaction	Date et heure de la transaction	Date	19

33	moyen_paiement	Moyen de paiement utilisé	Alphanumérique	20

34	id_signalement	Identifiant unique du signalement	Numérique	10

35	motif_signalement	Catégorie du motif de signalement	Alphanumérique	100

36	decision_moderation	Décision prise par le modérateur	Alphanumérique	100




V. Cinquième étape : interrogation de la BD
1.Scénario d’utilisation

Un lundi matin, Keria contacte le support de Riot Games. Elle affirme avoir été bannie à tort de Valorant pour triche. Le modérateur, qui est la personne qui utilise la base de données, commence par l'identifier. Pour cela, il retrouve son compte à partir du pseudo et de l'email qu'elle lui donne, même lorsqu'elle se trompe dans l'orthographe de son pseudo, puis consulte son statut sur Valorant. Il examine ensuite son dossier en retrouvant la partie où le ban a été prononcé, le signalement associé et les autres joueurs présents dans cette partie, qui pourraient servir de témoins. Il regarde aussi si d'autres parties Valorant ont été signalées, afin de savoir si le cas de Keria est isolé. Convaincu qu'il s'agit d'un faux positif de l'anti-triche Vanguard, il lève le ban sur Valorant et annule la décision du signalement. Keria en profite pour demander le remboursement d'un achat fait sur League of Legends, alors le modérateur vérifie que l'achat est éligible, d'après son montant et son moyen de paiement, puis l'annule.

Alerté, le service développement lui demande ensuite de mener l'enquête afin de déterminer à partir de quand les bans illégitimes ont commencé sur Valorant et quel patch contient le problème. En croisant les parties signalées avec l'historique des patchs, le modérateur retrouve la date du premier ban et le dernier patch publié juste avant, la version v6.11 du 27 juin 2023, qu'il transmet à l'équipe développement. Il cherche alors les autres joueurs qui ont pu être touchés, c'est-à-dire ceux qui ont joué dans une partie ayant mené à un ban, ceux qui ont disputé des parties classées et les joueurs actifs d'un niveau comparable aux bannis. Il repère également les sanctions qui ne reposent sur aucun signalement et qui doivent donc être revérifiées. Enfin, sa direction lui demande un bilan chiffré sur les décisions de modération, les statistiques de jeu, le chiffre d'affaires par jeu et les jeux qui devront recevoir le correctif, car elle souhaite offrir aux joueurs de Valorant une compensation calibrée sur leurs achats.


Étape 1 – Identification : retrouver le compte de Keria et son statut sur Valorant.
Étape 2 – Examen du dossier : retrouver la partie du ban, le signalement, les témoins et les autres parties signalées.
Étape 3 – Décision : lever le ban sur Valorant et annuler la décision du signalement.
Étape 4 – Remboursement : vérifier l'éligibilité de l'achat League of Legends puis l'annuler.
Étape 5 – Enquête technique : trouver la date du premier ban et le patch en cause.
Étape 6 – Recensement : identifier les autres joueurs touchés et les sanctions à revérifier.
Étape 7 – Bilan et compensation : chiffrer la modération, les ventes et la compensation des joueurs de Valorant.




3.Requete etudié

La requête choisie est celle de l'étape 6 qui recherche les joueurs ayant disputé une partie classée de Valorant, avec la date de la partie.

SELECT jo.pseudo, p.date_partie FROM Joueur jo
JOIN joue_dans jd ON jd.id_joueur = jo.id_joueur
JOIN Partie p ON p.id_partie = jd.id_partie
WHERE p.id_jeu = 2 AND p.mode_jeu = 'Classé'
ORDER BY p.date_partie;




Elle utilise trois opérateurs différents de l'algèbre relationnelle :

La sélection (σ), la jointure (⋈) et la projection (π).

π pseudo, date_partie (σ id_jeu = 2 ∧ mode_jeu = 'Classé' ( Joueur ⋈ joue_dans ⋈ Partie ))




Plan 1 : jointures d'abord, sélection à la fin

C'est la traduction directe de la requête. On réalise d'abord les jointures entre les trois tables, puis on applique la sélection du WHERE et enfin la projection.

π pseudo, date_partie  (7 lignes)
└── σ id_jeu = 2 ∧ mode_jeu = 'Classé'  (7 lignes)
    └── ⋈ jd.id_partie = p.id_partie  (123 lignes)
        ├── ⋈ jo.id_joueur = jd.id_joueur  (123 lignes)
        │   ├── Joueur  (30 lignes)
        │   └── joue_dans  (123 lignes)
        └── Partie  (52 lignes)

Joueur ⋈ joue_dans                   30 × 123 = 3 690
(…) ⋈ Partie                         123 × 52 = 6 396
σ id_jeu = 2 ∧ mode_jeu = 'Classé'   123
π pseudo, date_partie                7

Total = 30 × 123 + 123 × 52 + 123 + 7 = 10216





Plan 2 : sélection descendue au plus près des feuilles

On applique les règles d'optimisation vues en cours. La sélection ne porte que sur Partie, on la fait donc avant toute jointure. On joint ensuite d'abord les relations les plus petites, c'est-à-dire la table filtrée (3 lignes) avec joue_dans, puis seulement ce résultat (7 lignes) avec Joueur.

π pseudo, date_partie  (7 lignes)
└── ⋈ jd.id_joueur = jo.id_joueur  (7 lignes)
    ├── ⋈ p.id_partie = jd.id_partie  (7 lignes)
    │   ├── σ id_jeu = 2 ∧ mode_jeu = 'Classé'  (3 lignes)
    │   │   └── Partie  (52 lignes)
    │   └── joue_dans  (123 lignes)
    └── Joueur  (30 lignes)

σ id_jeu = 2 ∧ mode_jeu = 'Classé' (Partie)   52
(…) ⋈ joue_dans                               3 × 123 = 369
(…) ⋈ Joueur                                  7 × 30 = 210
π pseudo, date_partie                         7

Total = 52 + 3x123 + 7x30 + 7 = 638




Comparaison et conclusion

Plan	Instructions
Plan 1 : jointures puis sélection	10216
Plan 2 : sélection descendue	638