
CREATE PROCEDURE [dbo].[procODS_PRESCRIPTION_Insert]
(
	@rx varchar(20),
	@pat bigint,
	@stat int,
	@apre varchar(26) = '',
	@ss bigint,
	@phar bigint,
	@drug bigint
)
AS
	SET NOCOUNT ON;
	
INSERT INTO PRESCRIPTION
(
	RXNumber,
	PatientId,
	PreStatusId,
	AcceptedPrescriber,
	SourceSystemId,
	PharmacyId,
	DrugId
) 
VALUES
(
	@rx,
	@pat,
	@stat,
	@apre,
	@ss,
	@phar,
	@drug
);
SELECT SCOPE_IDENTITY();
