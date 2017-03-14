
-- =============================================
-- Author:		K. Sean Kern
-- Create date: 2015-05-07
-- Description:	Insert from Essentris
-- =============================================

CREATE PROCEDURE [dbo].[procMDE_SE_SCHEDULE_DATE_TIMES_Insert]
(
	@key numeric(11,3),
	@dkey numeric(22,7),
	@dt datetime
)
AS

INSERT INTO SCHEDULABLE_ENTITY$SCHEDULE_DATE_TIMES
(
	KEY_SITE,
	KEY_SCHEDULABLE_ENTITY,
	KEY_SCHEDULABLE_ENTITY$SCHEDULE_DATE_TIMES,
	DATE_TIME
)
VALUES
(
	0,
	@key,
	@dkey,
	@dt
)



