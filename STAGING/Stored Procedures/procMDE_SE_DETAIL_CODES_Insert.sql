
-- =============================================
-- Author:		K. Sean Kern
-- Create date: 2015-06-01
-- Description:	Insert from Cache
-- =============================================

create PROCEDURE [dbo].[procMDE_SE_DETAIL_CODES_Insert]
(
	@key numeric(7,3),
	@keyas numeric(7,3),
	@keyse numeric(11,3),
	@dkey numeric(22,7),
	@ien numeric(21,3)
)
AS

INSERT INTO SCHEDULABL$SCHEDULE_D$APPOINTMEN$APPT_DETAIL_CODES
(
	KEY_SITE,
	KEY_SCHEDULABLE_ENTITY,
	KEY_SCHEDULABL$SCHEDULE_D$APPOINTMEN$APPT_DETAIL_C,
	KEY_SCHEDULABLE_ENT$SCHEDULE_DATE_T$APPOINTMENT_SL,
	KEY_SCHEDULABLE_ENTITY$SCHEDULE_DATE_TIMES,
	APPT_DETAIL_CODES_IEN
)
VALUES
(
	0,
	@keyse,
	@key,
	@keyas,
	@dkey,
	@ien
)



