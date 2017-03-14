
create PROCEDURE [dbo].[procODS_CPT_UpdateDesc]
(
	@key numeric(11,3),
	@desc varchar(30)
)
AS
	SET NOCOUNT ON;
	
UPDATE CPT
SET CptDesc = @desc,
	UpdatedDate = Getdate()
WHERE CptHcpcsKey = @key;

