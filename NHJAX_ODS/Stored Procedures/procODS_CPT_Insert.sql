
create PROCEDURE [dbo].[procODS_CPT_Insert]
(
	@key numeric(11,3),
	@cd varchar(30),
	@desc varchar(30),
	@typ bigint
)
AS
	SET NOCOUNT ON;
	
INSERT INTO NHJAX_ODS.dbo.CPT
(
	CptHcpcsKey,
	CptCode,
	CptDesc,
	CptTypeId
) 
VALUES
(
	@key, 
	@cd,
	@desc,
	@typ
);
SELECT SCOPE_IDENTITY();