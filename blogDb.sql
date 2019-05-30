CREATE DATABASE blogDb
CHARACTER
SET 'utf8';

USE blogDB;


/* ======================
Table Articles
========================*/
CREATE TABLE articles (
    art_id INT PRIMARY KEY AUTO_INCREMENT,
    art_title VARCHAR
(200),
    art_body LONGTEXT,
    art_summary VARCHAR
(1500),
    art_date DATE,
    art_author VARCHAR
(50),
    com_id INT,
    cat_id INT,
    INDEX
(art_author),
    INDEX
(art_date),
    FULLTEXT
(art_title, art_body, art_summary)
) ENGINE=INNODB;

INSERT INTO articles
VALUES
    (NULL,
        'Piratage : la Hadopi craint la montée en puissance de l''IPTV',
        'La Haute Autorité pour la diffusion des œuvres et la protection des droits sur Internet, plus communément appelée Hadopi, vient de publier les résultats d''une étude sur la consommation illicite de programmes TV en direct. Réalisée par l''institut Ifop durant la seconde moitié de l''année 2018, et notamment en marge de la Coupe du monde de football, cette étude révèle que 24 % des Français font appel à un outil illicite pour regarder la télévision en direct. Les sites spécialisés dans le streaming, notamment d''événements sportifs, sont les plus populaires : 17 % des Français y ont leurs habitudes. Viennent ensuite les réseaux sociaux (14 %), puis les boîtiers ou applications d''IPTV (pour "Internet Protocole Télévision"), déjà utilisés par 5 % des Français.',
        'Une étude de l''institut Ifop commandée par la Hadopi révèle que les Français sont très nombreux à accéder illégalement à des programmes TV en direct. La Haute Autorité s''inquiète, car les adeptes de l''IPTV se détournent des offres légales.',
        NOW(),
        'Johann Breton',
        NULL, NULL),
    (NULL,
        'À Hollywood, l''IA est en train de prendre le contrôle de l''industrie',
        'Un article très intéressant publié par The Verge attire l''attention sur le rôle grandissant de l''intelligence artificielle quant aux choix qui sont faits à Hollywood, qu''il s''agisse de sélectionner les projets les plus prometteurs d''un point de vue économique ou d''y associer tel acteur plutôt qu''un autre. C''est ce que permet de faire un outil développé par la start-up californienne Cinelytic, capable de manipuler d''énormes quantités de données (thèmes, pitchs, acteurs, budgets, nombre d''entrées en salles, etc.) à travers des algorithmes autorisant les studios et leurs producteurs à simuler — et donc anticiper — la réussite de leurs projets.',
        'Peu à peu, les studios hollywoodiens s''en remettent à des outils dopés à l''IA pour prendre leurs décisions : choix des scripts, des réalisateurs, des acteurs, ils modifient les curseurs et jouent avec les prédictions des logiciels en termes de box-office.',
        '29/05/19',
        'Mathieu Chartier',
        NULL, NULL),
    (NULL,
        'Master Coach, le premier pèse-personne Terraillon connecté en Wi-Fi',
        'Master Coach, premier pèse-personne de Terraillon connecté au Wi-Fi, fera son entrée sur le marché fin juin. Ce protocole de communication  offre une liberté accrue pour la réception des données pendant que le sujet se pèse. En effet, l''appareil “ne requiert pas la présence du smartphone lors de la pesée”, précise le constructeur avant d''ajouter que “la synchronisation des données se fait automatiquement dans l''application”. Lorsque l''on se pèse, les informations sont directement envoyées sur le smartphone, même si celui-ci est éloigné de l''appareil. Les autres pèse-personnes de la marque comme le Terraillon R-Link ou encore le Terraillon Web Coach Pop, connectés en Bluetooth, nécessitent que le smartphone soit à proximité du pèse-personne pour ce partage d''informations.',
        'Terraillon lance pour la première fois un pèse-personne connecté en Wi-Fi avec Master Coach, une réelle avancée pour la marque française, mais pas forcément pour l’univers du pèse-personne.',
        '30/05/19',
        'Chloé Monget',
        NULL, NULL);

/* ======================
Table Commentaires
========================*/
CREATE TABLE comments (
    com_id INT PRIMARY KEY AUTO_INCREMENT,
    com_body VARCHAR
(500),
    com_date TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON
UPDATE CURRENT_TIMESTAMP,
    com_id_resp INT,
    blogUser_id INT,
    INDEX
(com_date),
    FULLTEXT
(com_body)
) ENGINE=INNODB;


/* ======================
Table Users
========================*/
CREATE TABLE blogUsers (
    blogUser_id INT PRIMARY KEY AUTO_INCREMENT,
    blogUser_speudo VARCHAR
(50) UNIQUE NOT NULL,
    blogUser_email VARCHAR
(150) UNIQUE NOT NULL,
    blogUser_pwrd_hash CHAR
(40) CHARACTER
SET ASCII
NOT NULL,
    blogUser_reg BOOLEAN,
    blogUser_role INT
) ENGINE=INNODB;

INSERT INTO blogUsers
VALUES
    (NULL, 'Momo', 'momo@gmail.com', SHA1('momoSuperMotDePasse'), 1, 1),
    (NULL, 'Mama', 'mama@gmail.com', SHA1('mamaSuperMotDePasse'), 1, 3),
    (NULL, 'Mimy', 'mimy@gmail.com', SHA1('mimySuperMotDePasse'), 1, 2);


/* ======================
Table Images
========================*/
CREATE TABLE images (
    img_id INT PRIMARY KEY AUTO_INCREMENT,
    img_name VARCHAR
(50),
    img_desc VARCHAR
(150),
    img_path VARCHAR
(200),
    art_id INT,
    blogUser_id INT
) ENGINE=INNODB;


/* ======================
Table Catégories
========================*/
CREATE TABLE categories (
    cat_id INT PRIMARY KEY AUTO_INCREMENT,
    cat_name VARCHAR
(30),
    cat_desc VARCHAR
(200)
) ENGINE=INNODB;


/* Foreign keys */

ALTER TABLE articles
ADD FOREIGN KEY (com_id) REFERENCES comments
(com_id);

ALTER TABLE articles
ADD FOREIGN KEY (cat_id) REFERENCES categories
(cat_id);

ALTER TABLE comments 
ADD FOREIGN KEY (blogUser_id) REFERENCES blogUsers
(blogUser_id);

ALTER TABLE images
ADD FOREIGN KEY (art_id) REFERENCES articles
(art_id);

ALTER TABLE images
ADD FOREIGN KEY (blogUser_id) REFERENCES blogUsers
(blogUser_id);