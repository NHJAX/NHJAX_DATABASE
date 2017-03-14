
CREATE PROCEDURE [dbo].[procODS_PATIENT_ORDER_Insert]
(
	@ord decimal(14,3),
	@num varchar(30),
	@pat bigint,
	@pro bigint,
	@typ bigint,
	@loc bigint,
	@sig datetime,
	@dt datetime,
	@pri bigint,
	@com varchar(100),
	@src bigint,
	@stat bigint,
	@anc bigint,
	@elm numeric(21,3) = 0,
	@pe bigint = 0
)
AS
	SET NOCOUNT ON;
	
INSERT INTO NHJAX_ODS.dbo.PATIENT_ORDER
(
	OrderKey,
	OrderNumber, 
	PatientId,
	OrderEncounterTypeId,
	OrderTypeId,
	LocationId,
	OrderingProviderId,
	SigDateTime,
	OrderDateTime,
	OrderPriorityId,
	OrderComment,
	SourceSystemId,
	OrderStatusId,
	AncillaryProcedureId,
	OrderElementKey,
	PatientEncounterId
) 
VALUES
(
	@ord,
	@num,
	@pat,
	1,
	@typ,
	@loc,
	@pro,
	@sig,
	@dt,
	@pri,
	@com,
	@src,
	@stat,
	@anc,
	@elm,
	@pe
);
SELECT SCOPE_IDENTITY();