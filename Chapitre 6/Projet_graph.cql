CREATE (i1:Intervenant {qui:"Steve"})-[:TACHE]->(t1:Tasks {tache:"formulaire"})
CREATE (i2:Intervenant {qui:"Bill"})-[:TACHE]->(t2:Tasks {tache:"integration formulaire"})
CREATE i1-[:TACHE]->(t3:Tasks {tache:"super fonctionnalité"})
CREATE i2-[:TACHE]->(t4:Tasks {tache:"menu responsive"})
CREATE (i3:Intervenant {qui:"Larry"})-[:TACHE]->(t5:Tasks {tache:"mots-clés"})

CREATE t1-[:PROJET]->(p1:Projet {projet:"le projet", retard:"3"})
CREATE (t12:Tasks {tache:"module paiement"})-[:PROJET]->(p1)
CREATE t2-[:PROJET]->p1
CREATE t3-[:PROJET]->(p2:Projet {projet:"le super projet"})
CREATE t4-[:PROJET]->p2
CREATE t5-[:PROJET]->p2

CREATE t1-[:COMPETENCE]->(c1:Competences {competence:"PHP"})
CREATE t2-[:COMPETENCE]->(c2:Competences {competence:"JS"})
CREATE t3-[:COMPETENCE]->c1
CREATE t4-[:COMPETENCE]->c2
CREATE t5-[:COMPETENCE]->(c3:Competences {competence:"SEO"})

CREATE t1-[:NEXT]->t12
CREATE t12-[:NEXT]->t2
CREATE t1-[:RETARD {retard: 3}]->(cause1:Retards {cause:"modification client"})
CREATE t12-[:RETARD {retard: 1}]->(cause1)
CREATE t12-[:RETARD {retard: 1}]->(cause2:Retards {cause:"bug"})
