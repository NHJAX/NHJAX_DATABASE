
create PROCEDURE [dbo].[procENET_TIER_Select]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT 
	TierId,
	TierDesc
FROM TIER

END

