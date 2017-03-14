CREATE PROCEDURE [dbo].[upsessInvLookupSelect]
(
	@tech int,
	@lk int
)
AS
SELECT     	LookupValue
FROM         	sessINV_LOOKUP 
WHERE	CreatedBy = @tech
		AND LookupId = @lk
