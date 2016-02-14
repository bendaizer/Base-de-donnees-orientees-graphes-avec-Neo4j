CREATE (l1_denfert:Ligne1 {station : "denfert"})-[:CORRESPONDANCE {mn:1}]->(l2_denfert:Ligne2 {station : "denfert"})
CREATE (l1_stmichel:Ligne1 {station : "st michel"})-[:CORRESPONDANCE {mn:1}]->(l2_stmichel:Ligne2 {station : "st michel"})

CREATE (s_stmichel:Metro {station : "st michel"})-[:STATION {mn:0.5}]->l1_stmichel
CREATE s_stmichel-[:STATION {mn:0}]->l2_stmichel

CREATE (l1_nation:Ligne1 {station : "nation"})-[:LIGNE1 {mn:5}]->l1_denfert
CREATE l1_denfert-[:LIGNE1 {mn:25}]->l1_stmichel
CREATE (l2_antony:Ligne2 {station : "antony"})-[:LIGNE1 {mn:5}]->l2_denfert
CREATE l2_denfert-[:LIGNE2 {mn:5}]->(l2_luxembourg:Ligne2 {station : "luxembourg" })
CREATE l2_luxembourg-[:LIGNE2 {mn:5}]->l2_stmichel

CREATE (s_nation:Metro {station : "nation"})-[:STATION {mn:0.5}]->l1_nation


