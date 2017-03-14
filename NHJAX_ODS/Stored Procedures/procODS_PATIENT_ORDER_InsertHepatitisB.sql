
CREATE PROCEDURE [dbo].[procODS_PATIENT_ORDER_InsertHepatitisB]
(
	@pat bigint,
	@dt datetime,
	@cby int,
	@ordnum numeric(14,3)
)
AS
	SET NOCOUNT ON;
	
UPDATE GENERATOR SET LastNumber=LastNumber+1
WHERE GeneratorTypeId = 2

SET @ordnum = dbo.GenerateOrderKey(@pat)
	
INSERT INTO NHJAX_ODS.dbo.PATIENT_ORDER
(
	PatientId,
	OrderEncounterTypeId,
	OrderTypeId,
	LocationId,
	OrderingProviderId,
	SigDateTime,
	OrderDateTime,
	OrderElementKey,
	OrderComment,
	SourceSystemId,
	CreatedBy,
	UpdatedBy,
	OrderKey
) 
VALUES
(
	@pat,
	1,
	11,
	1,
	0,
	@dt,
	@dt,
	3144,
	'Clinical Portal',
	8,
	@cby,
	@cby,
	@ordnum
);
SELECT SCOPE_IDENTITY();