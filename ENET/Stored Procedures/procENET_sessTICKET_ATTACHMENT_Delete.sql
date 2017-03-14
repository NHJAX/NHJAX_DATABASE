CREATE PROCEDURE [dbo].[procENET_sessTICKET_ATTACHMENT_Delete]
(
	@key varchar(100),
	@dby int
)
AS
	BEGIN TRANSACTION
	
	DELETE
    FROM sessTICKET_ATTACHMENT
    WHERE (SessionKey = @key)
    OR ((CreatedBy = @dby) AND (DATEDIFF(d,CreatedDate,GETDATE()) > 1));
	COMMIT TRANSACTION




