CREATE PROCEDURE [dbo].[procCIAO_CHECK_OUT_Select]
(
	@co int
)
AS

BEGIN
SELECT DISTINCT 
	CO.CheckOutId, 
	TECH.UserId, 
	ISNULL(TECH.UFName, '') AS FirstName, 
	ISNULL(TECH.ULName, '') AS LastName, 
	ISNULL(TECH.UMName, '') AS MI, 
	RNK.RankAbbrev, 
	TECH.Rate, 
	DESIG.DesignationDesc, 
	BASE.BaseName, 
	AUD.DisplayName, 
	CO.CheckOutDate, 
	STAT.CheckOutStatusDesc, 
	TECH.AudienceId,
	CO.ImmediateCheckOut,
	REA.CheckoutReasonDesc,
	TECH.BaseId,
	CO.TerminalLeaveEnds,
	ISNULL(TECH.DoDEDI,'') AS DoDEDI,
	TECH2.LoginId,
	CO.CheckOutStatusId,
	CO.UpdatedDate,
	CO.TransferringLocation,
	CO.CheckOutReasonId,
	CO.Notes
FROM CHECK_OUT AS CO
	INNER JOIN vwENET_TECHNICIAN AS TECH
	ON CO.UserId = TECH.UserId
	INNER JOIN vwENET_RANK AS RNK
	ON TECH.RankId = RNK.RankId 
	INNER JOIN vwENET_DESIGNATION AS DESIG 
	ON DESIG.DesignationId = TECH.DesignationId 
	INNER JOIN vwENET_AUDIENCE AS AUD 
	ON TECH.AudienceId = AUD.AudienceId 
	INNER JOIN vwENET_BASE AS BASE 
	ON BASE.BaseId = TECH.BaseId 
	INNER JOIN CHECKOUT_STATUS AS STAT
	ON CO.CheckOutStatusId = STAT.CheckOutStatusId
	INNER JOIN CHECKOUT_REASON AS REA
	ON CO.CheckOutReasonId = REA.CheckoutReasonId
	INNER JOIN vwENET_TECHNICIAN AS TECH2
	ON CO.UpdatedBy = TECH2.UserId
WHERE CO.CheckOutId = @co 

END