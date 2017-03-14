
CREATE PROCEDURE [dbo].[procAIM_BaseIdGet]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT  BaseId, 
			BaseName,
			Inactive,
			BaseCode,
			LeadTechId
FROM         BASE
WHERE    BaseId > 0
order by sortorder

end

