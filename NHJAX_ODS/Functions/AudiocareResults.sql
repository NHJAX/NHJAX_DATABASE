-- =============================================
-- Author:		Robert Evans
-- Create date: 22 July 2013
-- Description:	Get The AudioCare Results for a patient
-- =============================================
CREATE FUNCTION AudiocareResults 
(
	@patientid int=0, @ResultType char(3)='LAB'
)
RETURNS nvarchar(1000)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @ReturnValue nvarchar(1000) = ''

	DECLARE @14DAYResult nvarchar(500) = ''
	DECLARE @30DAYResult nvarchar(500) = ''
	IF @ResultType = 'LAB'
		BEGIN
			SELECT TOP 1 @14DAYResult = '14 Day Call:<br/>' + [ActionMonthDay] + ' ' + [ActionTime] + '<br/>' + RTRIM([Result])
			FROM [CLINICAL_PORTAL].[dbo].[AUDIOCARE]
			WHERE [patientid] = @patientid AND [RecordType] = 'LAB14'
			ORDER BY CreatedDateTime

			SELECT TOP 1 @30DAYResult = '30 Day Call:<br/>' + [ActionMonthDay] + ' ' + [ActionTime] + '<br/>' + RTRIM([Result])
			FROM [CLINICAL_PORTAL].[dbo].[AUDIOCARE]
			WHERE [patientid] = @patientid AND [RecordType] = 'LAB30'
			ORDER BY CreatedDateTime
		END
	ELSE
		BEGIN
			SELECT TOP 1 @14DAYResult = '14 Day Call:<br/>' + [ActionMonthDay] + ' ' + [ActionTime] + '<br/>' + RTRIM([Result])
			FROM [CLINICAL_PORTAL].[dbo].[AUDIOCARE]
			WHERE [patientid] = @patientid AND [RecordType] = 'RAD14'
			ORDER BY CreatedDateTime

			SELECT TOP 1 @30DAYResult = '30 Day Call:<br/>' + [ActionMonthDay] + ' ' + [ActionTime] + '<br/>' + RTRIM([Result])
			FROM [CLINICAL_PORTAL].[dbo].[AUDIOCARE]
			WHERE [patientid] = @patientid AND [RecordType] = 'RAD30'
			ORDER BY CreatedDateTime
		END

	IF @14DAYResult = ''
		BEGIN
			IF @30DAYResult = ''
				BEGIN
					SET @ReturnValue = ''
				END
			ELSE
				BEGIN
					SET @ReturnValue = @30DAYResult
				END
		END
	ELSE
		BEGIN
			IF @30DAYResult = ''
				BEGIN
					SET @ReturnValue = @14DAYResult
				END
			ELSE
				BEGIN
					SET @ReturnValue = @14DAYResult + '<br/>' + @30DAYResult
				END
		END
	-- Return the result of the function
	RETURN @ReturnValue

END
