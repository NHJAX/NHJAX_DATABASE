
create PROCEDURE [dbo].[procODS_DMIS_UpdateDmisCode]
(
	@key numeric(10,3),
	@code varchar(30)
)
AS
	SET NOCOUNT ON;
	
UPDATE DMIS
SET DMISCode = @code,
	UpdatedDate = Getdate()
WHERE DmisKey = @key;

