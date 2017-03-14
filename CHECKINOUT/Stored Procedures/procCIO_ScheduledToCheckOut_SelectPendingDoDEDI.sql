create PROCEDURE [dbo].[procCIO_ScheduledToCheckOut_SelectPendingDoDEDI]
WITH RECOMPILE 
AS

SELECT DISTINCT 
	SCH.ScheduledCheckoutId, 
	TECH.UserId, 
	ISNULL(SCH.FirstName, '') AS FirstName, 
	ISNULL(SCH.LastName, '') AS LastName, 
	ISNULL(SCH.MI, '') AS MI, 
	ISNULL(SCH.SSN, '') AS SSN, 
	RANK.RankAbbrev, 
	TECH.Rate, 
	DESIG.DesignationDesc, 
	BASE.BaseName, 
	AUD.DisplayName, 
	SCH.CheckOutDate, 
	ISNULL(SCH.Status, '') AS Status, 
	TECH.AudienceId,
	SCH.CheckedOut,
	SCH.Reason,
	TECH.BaseId,
	SCH.OfficialDate,
	SCH.TransferDate,
	SCH.RetirementDate,
	SCH.ChecklistId,
	CHK.CheckListDesc,
	ISNULL(SCH.DoDEDI,0) AS DoDEDI
FROM vwENET_RANK AS RANK 
	RIGHT OUTER JOIN vwENET_DESIGNATION AS DESIG 
	RIGHT OUTER JOIN vwENET_TECHNICIAN AS TECH 
	ON DESIG.DesignationId = TECH.DesignationId 
	LEFT OUTER JOIN vwENET_AUDIENCE AS AUD 
	ON TECH.AudienceId = AUD.AudienceId 
	ON RANK.RankId = TECH.RankId 
	RIGHT OUTER JOIN vwENET_BASE AS BASE 
	INNER JOIN ScheduledToCheckOut AS SCH 
	ON BASE.BaseId = SCH.SiteID 
	ON TECH.DoDEDI = SCH.DoDEDI
	INNER JOIN CHECKLIST AS CHK
	ON CHK.ChecklistId = SCH.ChecklistId
WHERE ((DATEDIFF(d, SCH.CheckOutDate, GETDATE()) > 5)
OR SCH.ImmediateCheckOut = 1)
AND SCH.CheckedOut IS NULL
ORDER BY SCH.CheckOutDate
