CREATE PROCEDURE [dbo].[procCIAO_vwCIAO_Personnel_UpdateCompletedDatebyDoDEDI]
(
@dod nvarchar(10), 
@uby int,
@comp datetime
)
 AS

DECLARE @pers as bigint

		SELECT TOP 1
			@pers = PersonnelId
		FROM vwCIAO_PERSONNEL
		WHERE DoDEDI = @dod
		ORDER BY PersonnelId Desc

		IF @comp > '1/1/1776'
			BEGIN
				UPDATE vwCHECKIN_APPLICATION_FLOW
				SET CheckInStatusId = 2,
				UpdatedDate = @comp,
				UpdatedBy = @uby
				WHERE PersonnelId = @pers
				AND AudienceId = 247
			END



