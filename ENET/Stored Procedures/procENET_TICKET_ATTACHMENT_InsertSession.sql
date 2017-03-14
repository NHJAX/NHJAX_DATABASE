
create PROCEDURE [dbo].[procENET_TICKET_ATTACHMENT_InsertSession]
(
	@tik int,
	@cby int,
	@key varchar(100)
)
AS
INSERT INTO TICKET_ATTACHMENT
(
TicketId,
AttachmentName,
ShortName,
CreatedBy
)
SELECT @tik AS TicketId,
	AttachmentName,
	ShortName,
	@cby AS CBy
FROM sessTICKET_ATTACHMENT
WHERE SessionKey = @key
	



