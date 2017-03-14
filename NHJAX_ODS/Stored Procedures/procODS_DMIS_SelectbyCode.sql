
create PROCEDURE [dbo].[procODS_DMIS_SelectbyCode]
(
	@dmis varchar(30)
)
AS
	SET NOCOUNT ON;
SELECT     
	DMISId
FROM DMIS
WHERE (DMISCode = @dmis)
