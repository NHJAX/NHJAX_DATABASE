create PROCEDURE [dbo].[procCIO_CHECK_OUT_SelectReport]
(
	@usr int
) 
AS

SELECT DISTINCT 
	CO.CheckOutDate,
	TECH.DoDEDI,
	TECH.UFName,
	TECH.UMName,
	TECH.ULName,
	CASE RNK.RankDesc
		WHEN 'Unknown' THEN ''
		WHEN 'NULL' THEN ''
		WHEN NULL THEN ''
		ELSE RNK.RankDesc
	END AS RankDesc,
	RNK.RankAbbrev,
	REA.CheckoutReasonDesc
FROM CHECK_OUT AS CO
INNER JOIN ENET.dbo.TECHNICIAN AS TECH
ON CO.UserId = TECH.UserId
LEFT JOIN ENET.dbo.[RANK] AS RNK
ON RNK.RankId = TECH.RankId
INNER JOIN CHECKOUT_REASON AS REA
ON CO.CheckOutReasonId = REA.CheckoutReasonId
WHERE CO.UserId = @usr
