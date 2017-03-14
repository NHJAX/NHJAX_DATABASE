
create PROCEDURE [dbo].[procENET_sessTICKET_ATTACHMENT_Insert]
(
	@key varchar(100),
	@atch varchar(250),
	@short varchar(250),
	@cby int
)
AS
INSERT INTO sessTICKET_ATTACHMENT
(
SessionKey,
AttachmentName,
ShortName,
CreatedBy
)
VALUES
(
@key,
@atch,
@short,
@cby
)



