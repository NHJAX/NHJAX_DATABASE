
create PROCEDURE [dbo].[procODS_LAB_RESULT_InsertHepatitisB]
(
	@pat bigint,
	@dt datetime,
	@ord bigint,
	@res varchar(19)
)
AS
	SET NOCOUNT ON;
	
INSERT INTO NHJAX_ODS.dbo.LAB_RESULT
(
	PatientId,
	LabTestId,
	OrderId,
	LabWorkElementId,
	TakenDate,
	Result,
	AccessionTypeId,
	SourceSystemId
) 
VALUES
(
	@pat,
	1958,
	@ord,
	306,
	@dt,
	@res,
	1,
	8
);
SELECT SCOPE_IDENTITY();