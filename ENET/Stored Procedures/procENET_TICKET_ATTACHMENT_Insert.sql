
CREATE PROCEDURE [dbo].[procENET_TICKET_ATTACHMENT_Insert]
(
	@tik int,
	@atch varchar(250),
	@short varchar(250),
	@cby int
)
AS
INSERT INTO TICKET_ATTACHMENT
(
TicketId,
AttachmentName,
ShortName,
CreatedBy
)
VALUES
(
@tik,
@atch,
@short,
@cby
)



