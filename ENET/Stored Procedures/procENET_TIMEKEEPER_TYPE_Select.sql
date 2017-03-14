create PROCEDURE [dbo].[procENET_TIMEKEEPER_TYPE_Select]

 AS

SELECT     
	TimekeeperTypeId, 
	TimekeeperTypeDesc
FROM TIMEKEEPER_TYPE
WHERE TimekeeperTypeId > 0

