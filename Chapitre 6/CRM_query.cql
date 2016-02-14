//// E-commerce
// Avoir les achats
MATCH a-[:A_ACHETE]->b
RETURN a,b

// Produits similaires par tag (similarité structurelle)
MATCH (i:Item {item:'ipad'})-[:TAG]->tag<-[r:TAG]-sim
RETURN sim, tag, i

// Exemple iphone similaire ipad
MATCH (i:Item {item:'ipad'})-[:TAG]->tag<-[r:TAG]-sim
RETURN sim AS `similaire à ipad`, count(r) AS score 
ORDER BY score DESC LIMIT 1

// Complémentarité par transaction
MATCH (i:Item {item:'ipad'})-[:A_ACHETE]->()<-[r:A_ACHETE]-sim
RETURN sim AS `produit complémentaire`, count(r) AS score 
ORDER BY score DESC LIMIT 1


//Recherche par similarité
MATCH (u:User)<-[:A_ACHETE]-i
WHERE u.name IN ['Audrey', 'Bertrand']
RETURN u, i

// Recommandation par similarité
MATCH (u:User {name:'Bertrand'})<-[:A_ACHETE]-i-[r1:A_ACHETE]->sim
WITH u, sim, count(r1) AS score1
ORDER BY score1 DESC
MATCH sim<-[r2:A_ACHETE]-rec
WHERE NOT(u--rec)
RETURN rec AS `recommandation pour Bertrand`, count(r2) AS score 
ORDER BY score DESC

//// CRM
// Campagnes par marques
MATCH u<-[:A_ACHETE]-a-[:MARQUE]->b
RETURN u,a,b

//Ciblage campagne emailing
MATCH c-[:AMI]-u<-[:A_ACHETE]-a-[:MARQUE]->b
RETURN u,a,b,c

MATCH c-[:AMI]-u<-[:A_ACHETE]-a-[:MARQUE]->(b:Brand {brand:'Apple'})
WHERE c.age < 28
RETURN u,a,b,c

MATCH (b:Brand {brand:'Apple'})-[:MARQUE]-()-[:A_ACHETE]-u-[:AMI]-target
WHERE NOT(b-[:MARQUE]-()-[:A_ACHETE]-target)
AND target.age<25
RETURN DISTINCT target AS `cible dans la bonne catégorie`


// BI
// nombre d'achats par tag et tranche d'âge
WITH length(["nomade", "blanc"]) AS ntag
MATCH (i:Item), (t:Tag)
WHERE t.tag IN ["nomade", "blanc"]
WITH i, t, ntag
MATCH u-[:A_ACHETE]-i-[r:TAG]->t
WHERE u.age >= 25 AND u.age < 35
RETURN i,t,u


WITH length(["nomade", "blanc"]) AS ntag
MATCH (i:Item), (t:Tag)
WHERE t.tag IN ["nomade", "blanc"]
WITH i, t, ntag
MATCH i-[r:TAG]->t
WITH i, count(r) AS score, ntag
ORDER BY score DESC
WHERE score = ntag
WITH i
MATCH i-[:A_ACHETE]-u
WHERE u.age >=25 AND u.age < 35
RETURN count(DISTINCT u) AS `nombre de personnes dans les catégorie et la tranche d'âge`


