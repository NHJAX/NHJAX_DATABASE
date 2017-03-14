create PROCEDURE [dbo].[procENET_TECHNICIAN_UpdateLBbyLogin]
(
@log varchar(25), 
@lb bit,
@lbdate datetime,
@uby int
)
 AS

UPDATE TECHNICIAN
SET LB = @lb,
LBBy = @uby,
LBDate = @lbdate
WHERE LoginId = @log;



