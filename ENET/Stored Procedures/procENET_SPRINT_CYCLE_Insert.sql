
create PROCEDURE [dbo].[procENET_SPRINT_CYCLE_Insert]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
DECLARE @max datetime
DECLARE @next datetime

SELECT @max = MAX(BeginDate)
FROM SPRINT_CYCLE

SET @next = DATEADD(DAY,14,@max)

INSERT INTO SPRINT_CYCLE
( 
	BeginDate
)
VALUES
(
	@next
);

END

