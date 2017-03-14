
-- =============================================
-- Author:		K. Sean Kern
-- Create date: 2015-05-07
-- Description:	Insert from Cache
-- =============================================

CREATE PROCEDURE [dbo].[procMDE_SE_APPOINTMENT_SLOTS_Insert]
(
	@key numeric(7,3),
	@keyse numeric(11,3),
	@dkey numeric(22,7),
	@as varchar(5),
	@typ numeric(21,3),
	@clin numeric(21,3),
	@stat varchar(30),
	@pro numeric(21,3)
)
AS

INSERT INTO SCHEDULABLE_ENT$SCHEDULE_DATE_T$APPOINTMENT_SLOTS
(
	KEY_SITE,
	KEY_SCHEDULABLE_ENTITY,
	KEY_SCHEDULABLE_ENT$SCHEDULE_DATE_T$APPOINTMENT_SL,
	KEY_SCHEDULABLE_ENTITY$SCHEDULE_DATE_TIMES,
	APPOINTMENT_SLOT,
	APPOINTMENT_TYPE_IEN,
	CLINIC_IEN,
	APPT_SLOT_STATUS,
	PROVIDER_IEN
)
VALUES
(
	0,
	@keyse,
	@key,
	@dkey,
	@as,
	@typ,
	@clin,
	@stat,
	@pro
)



