CREATE PROCEDURE [dbo].[upENet_SessionEMailDelete]
(
	@tech int
)
AS
DELETE     	
FROM         	sessEMail
WHERE	CreatedBy = @tech

