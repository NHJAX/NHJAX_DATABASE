-- =============================================
-- Author:		Robert Evans
-- Create date: 30 July 2013
-- Description:	Returns 0 For False 1 For True
-- =============================================
CREATE FUNCTION PatientHasHedisFlag
(
	-- Add the parameters for the function here
	@patientId int=0, @flagId int=0
)
RETURNS bit
AS
BEGIN
	-- Declare the return variable here
	DECLARE @ResultVar  bit = 0


	IF (Exists(SELECT flagid FROM PATIENT_FLAG WHERE PatientId = @patientId AND FlagId = @flagId))
		BEGIN
			SET @ResultVar = 1
		END

	-- Return the result of the function
	RETURN @ResultVar

END
