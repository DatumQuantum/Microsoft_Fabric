--select * from veritas.ref_Relationship_Managers L5
--select * from veritasglobal.stg_Flagged_Positions
SELECT 
L5.RMID,
L5.Title,
CASE
WHEN L1.RMID IS NOT NULL THEN 1
WHEN L2.RMID IS NOT NULL THEN 2
WHEN L3.RMID IS NOT NULL THEN 3
WHEN L4.RMID IS NOT NULL THEN 4
ELSE 5
END AS Hierarchy_Depth,
CONCAT_WS ('->',L5.Name,L4.Name,L3.Name,L2.Name,L1.Name) AS Hierarchy_Chain,
L1.RMID AS L1RMID,
L2.RMID AS L2RMID,
L3.RMID AS L3RMID,
L4.RMID AS L4RMID,
L5.RMID AS L5RMID
FROM veritas.ref_Relationship_Managers L5

LEFT JOIN [veritas].ref_Relationship_Managers L4 ON
L5.ManagerID = L4.RMID
LEFT JOIN [veritas].ref_Relationship_Managers L3 ON
L4.ManagerID = L3.RMID
LEFT JOIN [veritas].ref_Relationship_Managers L2 ON
L3.ManagerID = L2.RMID
LEFT JOIN [veritas].ref_Relationship_Managers L1 ON
L2.ManagerID = L1.RMID
