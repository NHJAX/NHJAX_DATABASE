
CREATE PROCEDURE [dbo].[procODS_ANCILLARY_PROCEDURE_Insert]
(
	@desc varchar(30),
	@src bigint,
	@key numeric(10,3) = 0
)
AS
	SET NOCOUNT ON;
	
INSERT INTO NHJAX_ODS.dbo.ANCILLARY_PROCEDURE
(
	AncillaryProcedureDesc,
	SourceSystemId,
	AncillaryProcedureKey
) 
VALUES
(
	@desc, 
	@src,
	@key
);
SELECT SCOPE_IDENTITY();
