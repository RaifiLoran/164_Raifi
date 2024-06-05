SELECT * FROM t_personne;

SELECT * FROM t_objets WHERE etat_objets = 'Fonctionnel';

SELECT p.nom, p.prenom, o.nom_objets
FROM t_personne p
JOIN t_objets_personne op ON p.id_personne = op.id_personne
JOIN t_objets o ON op.id_objets = o.id_objets;



SELECT r.date_retour, r.etat, o.nom_objets
FROM t_retour r
JOIN t_objets o ON r.id_objets = o.id_objets;

SELECT * FROM t_emprunt WHERE date_emprunt > '2023-01-01';


SELECT * FROM t_entrepot;


SELECT * FROM t_destockage;


SELECT * FROM t_personne WHERE service = 'Informatique';