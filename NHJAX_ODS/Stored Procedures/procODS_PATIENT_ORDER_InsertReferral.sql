
CREATE PROCEDURE [dbo].[procODS_PATIENT_ORDER_InsertReferral]
(
	@num varchar(30),
	@pat bigint,
	@pro bigint,
	@dt datetime,
	@enc bigint,
	@src bigint
)
AS
	SET NOCOUNT ON;

DECLARE @ordnum numeric(14,3)

UPDATE GENERATOR SET LastNumber=LastNumber+1
WHERE GeneratorTypeId = 2

SET @ordnum = dbo.GenerateOrderKey(@pat)
	
INSERT INTO NHJAX_ODS.dbo.PATIENT_ORDER
(
	OrderNumber, 
	PatientId,
	OrderEncounterTypeId,
	OrderingProviderId,
	OrderDateTime,
	PatientEncounterId,
	SourceSystemId,
	OrderKey
) 
VALUES
(
	@num,
	@pat,
	1,
	@pro,
	@dt,
	@enc,
	@src,
	@ordnum
);
SELECT SCOPE_IDENTITY();