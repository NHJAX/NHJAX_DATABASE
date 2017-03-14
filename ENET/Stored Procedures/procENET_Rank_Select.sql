
CREATE PROCEDURE [dbo].[procENET_Rank_Select]
(
	@des int
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
IF @des > 0
BEGIN
SELECT 
	RankId,
	RankAbbrev
FROM RANK
WHERE RankId > 0
AND DesignationId = @des
ORDER BY RankId
END
ELSE
BEGIN
SELECT 
	RankId,
	RankAbbrev
FROM RANK
WHERE RankId > 0
ORDER BY RankId
END
END

