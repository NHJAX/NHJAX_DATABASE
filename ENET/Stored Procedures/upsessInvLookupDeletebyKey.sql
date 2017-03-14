CREATE PROCEDURE [dbo].[upsessInvLookupDeletebyKey]
(
	@tech int,
	@lk int
)
AS
DELETE     	
FROM         	sessINV_LOOKUP
WHERE	CreatedBy = @tech
AND		LookupId = @lk
