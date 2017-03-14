CREATE PROCEDURE [dbo].[procAD_Audience_SelectbyCode]
(
	@code varchar(20)
)
AS

SELECT     
	AudienceId
FROM AUDIENCE
WHERE OrgChartCode = @code
AND DataLength(OrgChartCode) > 0





