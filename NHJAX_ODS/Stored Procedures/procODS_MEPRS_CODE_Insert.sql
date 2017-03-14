
create PROCEDURE [dbo].[procODS_MEPRS_CODE_Insert]
(
	@key numeric(10,3),
	@code varchar(4),
	@desc varchar(50),
	@dmis bigint
)
AS
	SET NOCOUNT ON;
	
INSERT INTO MEPRS_CODE
(
	MeprsCodeKey,
	MeprsCode,
	MeprsCodeDesc,
	DmisId
) 
VALUES
(
	@key, 
	@code,
	@desc,
	@dmis
);
SELECT SCOPE_IDENTITY();
