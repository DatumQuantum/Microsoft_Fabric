--CREATE SCHEMA gold;

CREATE  VIEW [gold].[Clean_Positions]
AS
SELECT 
p.PositionID,
TRY_CAST(p.RMID AS INT) as RMID,
ISNULL(r.Name,'Unassigned') AS RM_Name,
p.Asset_Class,
p.Currency,
p.Flag_Type,
p.Status,
p.Regulatory_Signoff,
ISNULL(TRY_CAST(p.Settlement_Date AS DATE), '1900-01-01') AS Clean_Settlement_Date,
ISNULL(TRY_CAST(p.Flag_Date AS DATE), '1900-01-01') AS Clean_Flag_Date,
TRY_CAST(p.Notional_Value AS DECIMAL(20,2)) AS Clean_Notional_Value,

CASE
WHEN TRY_CAST(p.Notional_Value AS DECIMAL(20,2)) IS NULL THEN 'Unclassified'
WHEN TRY_CAST(p.Notional_Value AS DECIMAL(20,2)) < 1000000 THEN 'Low Exposure'
WHEN TRY_CAST(p.Notional_Value AS DECIMAL(20,2)) BETWEEN 1000000 AND 9999999.99 THEN 'Medium Exposure'
WHEN TRY_CAST(p.Notional_Value AS DECIMAL(20,2)) BETWEEN 10000000 AND 99999999.99 THEN 'High Exposure'
WHEN TRY_CAST(p.Notional_Value AS DECIMAL(20,2)) > 100000000 THEN 'Critical Exposure'
ELSE 'Unknown'
END AS Exposure_Category
FROM [veritasglobal].[stg_Flagged_Positions] p
LEFT JOIN [veritas].[ref_Relationship_Managers] r ON 
TRY_CAST(p.RMID AS INT)=r.RMID