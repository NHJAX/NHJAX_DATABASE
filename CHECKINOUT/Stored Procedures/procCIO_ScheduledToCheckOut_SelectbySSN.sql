CREATE PROCEDURE [dbo].[procCIO_ScheduledToCheckOut_SelectbySSN]
(
	@ssn varchar(11)
) 
AS

SELECT DISTINCT 
	SCHD.CheckOutDate,
	SCHD.SSN,
	SCHD.FirstName,
	SCHD.MI,
	SCHD.LastName,
	CASE RNK.RankDesc
		WHEN 'Unknown' THEN ''
		WHEN 'NULL' THEN ''
		WHEN NULL THEN ''
		ELSE RNK.RankDesc
	END AS RankDesc,
	RNK.RankAbbrev,
	SCHD.Reason,
	SCHD.DoDEDI
FROM ScheduledToCheckOut AS SCHD
INNER JOIN ENET.dbo.TECHNICIAN AS TECH
ON SCHD.UserId = TECH.UserId
LEFT JOIN ENET.dbo.[RANK] AS RNK
ON RNK.RankId = TECH.RankId
WHERE SCHD.SSN = @ssn
