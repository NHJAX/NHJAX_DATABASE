
-- =============================================
-- Author:		Michael Bishop
-- Create date: 09 Feb 2006
-- Description:	Used for CIP
-- =============================================
CREATE PROCEDURE [dbo].[GetProviderNames20120815] 
	-- Add the parameters for the stored procedure here
	--@ClinicID int = '0'
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
SET NOCOUNT ON;
SELECT 	DISTINCT LOC.HospitalLocationId AS ClinicID, PRO.PROVIDERID AS ProviderID, PRO.PROVIDERNAME AS Provider
FROM 	HOSPITAL_LOCATION LOC INNER JOIN PATIENT_ENCOUNTER APP ON APP.HOSPITALLOCATIONID = LOC.HOSPITALLOCATIONID
		INNER JOIN PROVIDER PRO ON PRO.PROVIDERID = APP.PROVIDERID
WHERE 	/*LOC.HOSPITALLOCATIONID = @ClinicID
		AND*/ APP.APPOINTMENTDATETIME BETWEEN DATEADD(m, -1, GETDATE()) AND GETDATE()
		AND PRO.PROVIDERFLAG = '1'
ORDER BY PRO.PROVIDERNAME;
END


