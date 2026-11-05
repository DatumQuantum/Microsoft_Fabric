CREATE OR ALTER PROC staging.sp_InsertRates
@SampleData NVARCHAR(MAX)
--[staging].[sp_InsertRates]
AS
BEGIN

INSERT INTO staging.CurrencyRates(RateDate , BaseCurrency , TargetCurrency , RateValue)

SELECT CAST(JSON_VALUE(@SampleData,'$.date')AS DATE) AS ratedate,
JSON_VALUE(@SampleData,'$.base') AS BaseCurrency,
x.[key] AS TargetCurrency,
x.[value] AS RateValue
FROM OPENJSON(@SampleData,'$.rates') AS x;

END;
