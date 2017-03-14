-- =============================================
-- Author:		Craig Foreacre
-- Create date: 08/22/2006
-- Description:	At-Risk Patient Last Appointment
-- =============================================
CREATE PROCEDURE [dbo].[upCP_Patient_By_AppointmentDateTime]
	-- Add the parameters for the stored procedure here
(
@flag int
)

AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @start datetime
	
	SET @start = dbo.StartOfDay(DATEADD(d, - 30, GETDATE()))

    -- Insert statements for procedure here
	SELECT 
			PAT.PatientId,
			PAT.FullName AS Name,
			PAT.DOB,
			PAT.Sex, 
			PE.AppointmentDateTime

	FROM    PATIENT AS PAT INNER JOIN
                 PATIENT_ENCOUNTER AS PE ON PAT.PatientId = PE.PatientId INNER JOIN
                 vwCP_PATIENT_FLAG AS PF ON PAT.PatientId = PF.PatientId
	WHERE	(PF.FlagId = @flag) AND 
			(PE.AppointmentDateTime >= @start)
	ORDER BY Fullname,
			 Appointmentdatetime desc
END
