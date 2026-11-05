//***********************************************************************************************************
// Here are two articles to help you get started with KQL:
// KQL reference guide - https://aka.ms/KQLguide
// SQL - KQL conversions - https://aka.ms/sqlcheatsheet
//***********************************************************************************************************

StockTicks
| summarize arg_max(todatetime(Date),Close) by Ticker

--------------------
StockTicks
| extend IntraDayRange = High - Low
| summarize AvgRange = avg(IntraDayRange) by Ticker
-----------------------------------------------------------

StockTicks
| extend DailyReturn = Close - Open
| summarize AvgDailyReturn = avg(DailyReturn) by Ticker

--------------------------------------------------------------

StockTicks
| summarize AvgVolume = avg(Volume),MaxVolume = max(Volume) by Ticker
| extend SurgeRatio = round(MaxVolume/AvgVolume,2)
| where SurgeRatio > 1.97

-----------------------------------------------------------------

StockTicks
| where Open <=0 or High <= 0 or Close <= 0 or Low <= 0 or Volume < 0 or High < Low