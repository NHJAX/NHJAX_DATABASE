-- =============================================
-- Author:		Robert Evans
-- Create date: 30 July 2013
-- Description:	Gets a list for dropdowns of pcm locations
-- =============================================
CREATE PROCEDURE procODS_PCM_Locations_Lookup

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
SELECT 0 as idNumber,'All' as LocDesc, 'All Locations' as LocName, '0000000000' as SortBy
UNION
SELECT HospitalLocationId,HospitalLocationDesc, HospitalLocationName, HospitalLocationName
FROM HOSPITAL_LOCATION
WHERE HospitalLocationId IN (
SELECT DISTINCT HospitalLocationId FROM PRIMARY_CARE_MANAGER
)
AND HospitalLocationDesc IS NOT NULL
ORDER BY SortBy

END
