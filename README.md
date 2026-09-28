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

