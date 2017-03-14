CREATE PROCEDURE [dbo].[procENET_Audience_Update]
(
	@aud		bigint,
	@desc		varchar(50),
	@code		varchar(20),
	@inac		bit,
	@uby		int
)
 AS
UPDATE AUDIENCE SET 
    AudienceDesc = @desc, 
    OrgChartCode = @code,
    Inactive = @inac,
    UpdatedBy = @uby,
    UpdatedDate = getdate()
    WHERE AudienceId = @aud




