create PROCEDURE [dbo].[procENET_sessMerge_Delete]
(
	@sess varchar(100),
	@user int
)
AS
	BEGIN TRANSACTION
	
	DELETE
    FROM sessMERGE
    WHERE (SessionKey = @sess)
    OR ((CreatedBy = @user) AND (DATEDIFF(d,CreatedDate,GETDATE()) > 1));
	COMMIT TRANSACTION




