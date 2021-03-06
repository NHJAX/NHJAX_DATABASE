﻿
create PROCEDURE [dbo].[procMDE_SE_APPOINTMENT_SLOTS_UpdateProvider]
(
	@key numeric(7,3),
	@keyse numeric(11,3),
	@dkey numeric(22,7),
	@pro numeric(21,3)
)
AS
	SET NOCOUNT ON;
	
UPDATE SCHEDULABLE_ENT$SCHEDULE_DATE_T$APPOINTMENT_SLOTS
SET PROVIDER_IEN = @pro
WHERE KEY_SCHEDULABLE_ENTITY = @keyse
	AND KEY_SCHEDULABLE_ENT$SCHEDULE_DATE_T$APPOINTMENT_SL = @key
	AND KEY_SCHEDULABLE_ENTITY$SCHEDULE_DATE_TIMES = @dkey;