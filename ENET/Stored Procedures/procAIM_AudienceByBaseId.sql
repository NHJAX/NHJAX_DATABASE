
CREATE PROCEDURE [dbo].[procAIM_AudienceByBaseId]
(
@base int
)
AS
declare
@sql nvarchar(500)
BEGIN
	
	SET NOCOUNT ON;

SELECT	@sql = 'Select
			AUD.BaseId,
			Aud.AudienceId,
			AUD.DisplayName,
			AUD.AudienceDesc,
			AUD.OrgChartCode,
			AUD.ReportsUnder

FROM         AUDIENCE as AUD INNER JOIN
                      BASE ON AUD.BaseId = BASE.BaseId
WHERE     (AUD.AudienceCategoryId < 4)
and (base.baseid =1)'

exec sp_executesql @sql

END


