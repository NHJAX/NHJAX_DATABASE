
create PROCEDURE [dbo].[procENET_sessTICKET_ATTACHMENT_SelectByKey]
(
	@key varchar(100)
)
AS
SELECT 
	AttachmentName,
	ShortName,
	CreatedDate,
	CreatedBy
FROM sessTICKET_ATTACHMENT
WHERE SessionKey = @key





