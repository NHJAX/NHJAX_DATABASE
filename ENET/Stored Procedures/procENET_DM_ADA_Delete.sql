create PROCEDURE [dbo].[procENET_DM_ADA_Delete] 
(
	@sess varchar(50) = 'xyz'
)

AS
SET NOCOUNT ON;

--DELETE ANY CURRENT SESSION DATA
BEGIN

DELETE FROM DM_ADA
WHERE SessionKey = @sess
OR DMCreatedDate < dbo.startofday(DATEADD(d,-3,getdate())) 

END

