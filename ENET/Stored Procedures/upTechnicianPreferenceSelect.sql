CREATE PROCEDURE [dbo].[upTechnicianPreferenceSelect]
(
	@tech int,
	@pref int = 0,
	@debug bit = 0
)
AS
DECLARE	
	@sql		nvarchar(4000),
	@paramlist	nvarchar(4000)
SELECT @sql = 'SELECT P.PreferenceDesc,
		TP.PreferenceId,
		TP.PreferenceInfo,
		TP.TechnicianId
	FROM PREFERENCE P
	INNER JOIN TECHNICIAN_PREFERENCE TP
	ON P.PreferenceId = TP.PreferenceId
	WHERE TP.TechnicianId = @tech '
IF @pref > 0
	SELECT @sql = @sql + 'AND TP.PreferenceId = @pref '
IF @debug = 1
	PRINT @sql
	PRINT @tech
	PRINT @pref
SELECT @paramlist = 	'@tech int,
			@pref int'
			
EXEC sp_executesql	@sql, @paramlist, @tech, @pref

