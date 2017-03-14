create PROCEDURE [dbo].[procCIO_Personnel_Inprocess_MoveUp]
(
	@stp bigint,
	@srt int,
	@pers bigint
)
 AS

BEGIN TRANSACTION
UPDATE PERSONNEL_INPROCESS
SET SortOrder = (@srt)
WHERE SortOrder = (@srt - 1)
AND PersonnelId = @pers;

UPDATE PERSONNEL_INPROCESS
SET SortOrder = (@srt - 1)
WHERE CheckInStepId = @stp
AND PersonnelId = @pers;

COMMIT


