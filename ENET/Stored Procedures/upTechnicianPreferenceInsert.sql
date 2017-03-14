CREATE PROCEDURE [dbo].[upTechnicianPreferenceInsert]
(
	@tech int,
	@pref int,
	@prefinfo varchar(100)
)
AS
INSERT INTO TECHNICIAN_PREFERENCE
(
	TechnicianId, 
	PreferenceId, 
	PreferenceInfo
) 
VALUES
(
	@tech, 
	@pref, 
	@prefinfo
)

