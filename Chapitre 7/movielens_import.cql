match n optional match n-[r]-() delete r, n

// contraintes avant insertion
CREATE CONSTRAINT ON (user:User) ASSERT user.Id IS UNIQUE
CREATE CONSTRAINT ON (movie:Movie) ASSERT movie.Id IS UNIQUE
CREATE CONSTRAINT ON (genre:Genre) ASSERT genre.genre IS UNIQUE

// Genres
LOAD CSV FROM "file:///Users/abenhenni/Work/neo4j-book/Recommender/ml-100K/u.genre" AS line
FIELDTERMINATOR "|"
CREATE (n:Genre {genre:line[0]})

// Movies avec genres
LOAD CSV FROM "file:///Users/abenhenni/Work/neo4j-book/Recommender/ml-100K/u.item" AS line
FIELDTERMINATOR "|"
WITH line
FOREACH(n IN (CASE line[6] WHEN "0" THEN [] ELSE [1] END) |
  MERGE (movie:Movie {Id:line[0], title:line[1]})
  MERGE (action:Genre {genre:"Action"})
  CREATE (movie)-[:GENRE]->(action)
)
FOREACH(n IN (CASE line[7] WHEN "0" THEN [] ELSE [1] END) |
  MERGE (movie:Movie {Id:line[0], title:line[1]})
  MERGE (adventure:Genre {genre:"Adventure"})
  CREATE (movie)-[:GENRE]->(adventure)
)
FOREACH(n IN (CASE line[8] WHEN "0" THEN [] ELSE [1] END) |
  MERGE (movie:Movie {Id:line[0], title:line[1]})
  MERGE (animation:Genre {genre:"Animation"})
  CREATE (movie)-[:GENRE]->(animation)
)
FOREACH(n IN (CASE line[9] WHEN "0" THEN [] ELSE [1] END) |
  MERGE (movie:Movie {Id:line[0], title:line[1]})
  MERGE (children:Genre {genre:"Children"})
  CREATE (movie)-[:GENRE]->(children)
)
FOREACH(n IN (CASE line[10] WHEN "0" THEN [] ELSE [1] END) |
  MERGE (movie:Movie {Id:line[0], title:line[1]})
  MERGE (comedy:Genre {genre:"Comedy"})
  CREATE (movie)-[:GENRE]->(comedy)
)
FOREACH(n IN (CASE line[11] WHEN "0" THEN [] ELSE [1] END) |
  MERGE (movie:Movie {Id:line[0], title:line[1]})
  MERGE (crime:Genre {genre:"Crime"})
  CREATE (movie)-[:GENRE]->(crime)
)
FOREACH(n IN (CASE line[12] WHEN "0" THEN [] ELSE [1] END) |
  MERGE (movie:Movie {Id:line[0], title:line[1]})
  MERGE (doc:Genre {genre:"Documentary"})
  CREATE (movie)-[:GENRE]->(doc)
)
FOREACH(n IN (CASE line[13] WHEN "0" THEN [] ELSE [1] END) |
  MERGE (movie:Movie {Id:line[0], title:line[1]})
  MERGE (drama:Genre {genre:"Drama"})
  CREATE (movie)-[:GENRE]->(drama)
)
FOREACH(n IN (CASE line[14] WHEN "0" THEN [] ELSE [1] END) |
  MERGE (movie:Movie {Id:line[0], title:line[1]})
  MERGE (fantasy:Genre {genre:"Fantasy"})
  CREATE (movie)-[:GENRE]->(fantasy)
)
FOREACH(n IN (CASE line[15] WHEN "0" THEN [] ELSE [1] END) |
  MERGE (movie:Movie {Id:line[0], title:line[1]})
  MERGE (noir:Genre {genre:"Film-Noir"})
  CREATE (movie)-[:GENRE]->(noir)
)
FOREACH(n IN (CASE line[16] WHEN "0" THEN [] ELSE [1] END) |
  MERGE (movie:Movie {Id:line[0], title:line[1]})
  MERGE (horror:Genre {genre:"Horror"})
  CREATE (movie)-[:GENRE]->(horror)
)
FOREACH(n IN (CASE line[17] WHEN "0" THEN [] ELSE [1] END) |
  MERGE (movie:Movie {Id:line[0], title:line[1]})
  MERGE (musical:Genre {genre:"Musical"})
  CREATE (movie)-[:GENRE]->(musical)
)
FOREACH(n IN (CASE line[18] WHEN "0" THEN [] ELSE [1] END) |
  MERGE (movie:Movie {Id:line[0], title:line[1]})
  MERGE (mystery:Genre {genre:"Mystery"})
  CREATE (movie)-[:GENRE]->(mystery)
)
FOREACH(n IN (CASE line[19] WHEN "0" THEN [] ELSE [1] END) |
  MERGE (movie:Movie {Id:line[0], title:line[1]})
  MERGE (romance:Genre {genre:"Romance"})
  CREATE (movie)-[:GENRE]->(romance)
)
FOREACH(n IN (CASE line[20] WHEN "0" THEN [] ELSE [1] END) |
  MERGE (movie:Movie {Id:line[0], title:line[1]})
  MERGE (scifi:Genre {genre:"Sci-Fi"})
  CREATE (movie)-[:GENRE]->(scifi)
)
FOREACH(n IN (CASE line[21] WHEN "0" THEN [] ELSE [1] END) |
  MERGE (movie:Movie {Id:line[0], title:line[1]})
  MERGE (thriller:Genre {genre:"Thriller"})
  CREATE (movie)-[:GENRE]->(thriller)
)
FOREACH(n IN (CASE line[22] WHEN "0" THEN [] ELSE [1] END) |
  MERGE (movie:Movie {Id:line[0], title:line[1]})
  MERGE (war:Genre {genre:"War"})
  CREATE (movie)-[:GENRE]->(war)
)
FOREACH(n IN (CASE line[23] WHEN "0" THEN [] ELSE [1] END) |
  MERGE (movie:Movie {Id:line[0], title:line[1]})
  MERGE (western:Genre {genre:"Western"})
  CREATE (movie)-[:GENRE]->(western)
)
    
// Users
LOAD CSV FROM "file:///Users/abenhenni/Work/neo4j-book/Recommender/ml-100K/u.user" AS line
FIELDTERMINATOR "|"
WITH line
CREATE (user:User {Id:line[0], age:toInt(line[1]), sexe:line[2]})

// Ratings
USING PERIODIC COMMIT 1000
LOAD CSV FROM "file:///Users/abenhenni/Work/neo4j-book/Recommender/ml-100K/u.data" AS line
FIELDTERMINATOR "\t"
WITH line
MERGE (user:User {Id:line[0]})
MERGE (movie:Movie {Id:line[1]})
WITH line, user, movie
WHERE toInt(line[2]) >= 3
CREATE user-[:WATCHED {rating:toInt(line[2]), timestamp:toInt(line[3])}]->movie