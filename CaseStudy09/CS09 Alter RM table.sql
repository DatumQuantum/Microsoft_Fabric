-- ALTER TABLE [veritas].[ref_Relationship_Managers]
-- ADD
-- start_date DATE,
-- end_date DATE,
-- is_active BIT
-------------------
-- select * from veritas.ref_Relationship_Managers
-- UPDATE [veritas].ref_Relationship_Managers
-- SET start_date  = '2026-10-30',
-- is_active = 1
-----------------------------------
BEGIN TRANSACTION
UPDATE T
SET
T.end_date = DATEADD(DAY,-1,CAST(GETDATE() AS DATE)),
T.is_active = 0
FROM [veritas].[ref_Relationship_Managers] T
INNER JOIN [stg].[New_RM_Roster] S ON
S.RMID = T.RMID
WHERE T.is_active = 1 AND
(T.Title <> S.Title OR T.Name <> S.Name OR T.ManagerID <> S.ManagerID OR T.Jurisdiction <> S.Jurisdiction OR T.Desk <> S.Desk);

INSERT INTO [veritas].[ref_Relationship_Managers]
(RMID,Name,Title,ManagerID,Jurisdiction,Desk,start_date,end_date,is_active)

SELECT DISTINCT
RMID,
Name,
Title,
ManagerID,
Jurisdiction,
Desk,
CAST(GETDATE() AS DATE),
NULL,
1
FROM [stg].New_RM_Roster S LEFT JOIN veritas.ref_Relationship_Managers T ON S.RMID = T.RMID AND T.is_active = 1;

COMMIT TRANSACTION













