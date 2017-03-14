create PROCEDURE [dbo].[procENET_TECHNICIAN_UpdatePSQbyLogin]
(
@log varchar(25), 
@psq bit,
@psqdate datetime,
@uby int
)
 AS

UPDATE TECHNICIAN
SET PSQ = @psq,
PSQBy = @uby,
PSQDate = @psqdate
WHERE LoginId = @log



