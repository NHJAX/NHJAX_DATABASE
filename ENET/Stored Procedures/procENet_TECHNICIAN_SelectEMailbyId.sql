
create PROCEDURE [dbo].[procENet_TECHNICIAN_SelectEMailbyId]
(
	@usr int
)
AS
SELECT   
	UserId,  
	EMailAddress
FROM   TECHNICIAN  
WHERE	UserId = @usr





