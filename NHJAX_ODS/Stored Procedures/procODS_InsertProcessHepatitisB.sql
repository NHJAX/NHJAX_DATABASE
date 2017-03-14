-- =============================================
-- Author:		Robert Evans
-- Create date: 12 July 2011
-- Description:	Insert into the Patient_Order table
-- and then into the LabResult table
-- Returns the newly inserted lab result id.
-- =============================================
CREATE PROCEDURE [dbo].[procODS_InsertProcessHepatitisB]
(
	@pat bigint,
	@dt datetime,
	@cby int,
	@res varchar(19)
)
AS
	SET NOCOUNT ON;
DECLARE @NewLabResultId bigint
DECLARE @NewPatientOrderId bigint
DECLARE @ordnum numeric(14,3)
--Step #1 Set the New Ids to a non NULL Value
SET @NewLabResultId = 0
SET @NewPatientOrderId = 0

BEGIN TRANSACTION
BEGIN TRY

	UPDATE GENERATOR SET LastNumber=LastNumber+1
	WHERE GeneratorTypeId = 2

	SET @ordnum = dbo.GenerateOrderKey(@pat)
	
	--Step #2 Get a Patient Order To insert into the LabResult Table	
	INSERT INTO PATIENT_ORDER
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
	SELECT @NewPatientOrderId = SCOPE_IDENTITY();
	--Step #3 If the new patient order id is > than 0 Which it should be
	--Then insert the Lab_Result value.
	IF @NewPatientOrderId > 0
		BEGIN
			INSERT INTO LAB_RESULT
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
				@NewPatientOrderId,
				306,
				@dt,
				@res,
				1,
				8
			);
			SELECT @NewLabResultId = SCOPE_IDENTITY();		
			--Step #4 Everything went well, commit everything.
			COMMIT TRANSACTION
		END
	ELSE
		BEGIN
			--Something went wrong the NewPatientOrderId was not > 0
			SELECT @NewLabResultId = -2;
			ROLLBACK TRANSACTION
		END
END TRY
BEGIN CATCH
	--Something went wrong Rollback
	SELECT @NewLabResultId = -1;
	ROLLBACK TRANSACTION
END CATCH
--Step #5 Return the newly created LabResultId
SELECT @NewLabResultId

