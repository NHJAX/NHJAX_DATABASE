create PROCEDURE [dbo].[procCIO_Designation_Preference_Select]
(
	@desg int
)
 AS

SELECT
	PreferenceId 
FROM DESIGNATION_PREFERENCE
WHERE DesignationId = @desg 




