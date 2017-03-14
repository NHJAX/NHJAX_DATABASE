CREATE PROCEDURE [dbo].[upTechnicianPreferenceUpdate]
(
	@prefinfo varchar(100),
	@tech int,
	@pref int
)
AS
UPDATE TECHNICIAN_PREFERENCE
SET PreferenceInfo = @prefinfo
WHERE TechnicianId = @tech
	AND PreferenceId = @pref

