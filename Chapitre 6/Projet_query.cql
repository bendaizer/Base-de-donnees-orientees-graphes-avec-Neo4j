// Identification d'experts
MATCH (c:Competences)-[:COMPETENCE]-t-[:TACHE]-(i:Intervenant)
WHERE c.competence in ["JS", "SEO"]
RETURN i AS intervenant, count(t) AS score
ORDER BY score DESC

// Taches du projet
MATCH (p:Projet {projet:"le projet"})<-[:PROJET]-(t1:Tasks {tache:"formulaire"})
WITH t1
MATCH p=t1-[:NEXT*]-(t2:Tasks {tache:"integration formulaire"})
RETURN nodes(p)


// Retards
MATCH (p:Projet {projet:"le projet"})<-[:PROJET]-()-[r:RETARD]-cause
RETURN cause, count(r) AS score
ORDER BY score DESC


//statistiques retard
MATCH (p:Projet {projet:"le projet"})<-[:PROJET]-()-[r:RETARD]-cause
RETURN sum(r.retard) AS `total retard`, avg(r.retard) AS `retard moyen`