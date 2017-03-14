CREATE PROCEDURE [dbo].[procENET_sessTICKET_ATTACHMENT_DeleteByName]
(
	@key varchar(100),
	@name varchar(250)
)
AS
	BEGIN TRANSACTION
	
	DELETE
    FROM sessTICKET_ATTACHMENT
    WHERE (SessionKey = @key)
		AND ShortName = @name;
	COMMIT TRANSACTION




