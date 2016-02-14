// plus court chemin
MATCH (start:Metro {station:"nation"}), (end:Metro {station:"st michel"})
MATCH p=allShortestPaths(start-[*]-end)
RETURN nodes(p), length(p) AS total
ORDER BY total LIMIT 1


// pondéré par temps
MATCH p=(start:Metro {station:"nation"})-[*]-(end:Metro {station:"st michel"})
RETURN DISTINCT nodes(p) AS etapes, reduce(tps=0, r in relationships(p) | tps+r.mn) AS total
ORDER BY total LIMIT 1