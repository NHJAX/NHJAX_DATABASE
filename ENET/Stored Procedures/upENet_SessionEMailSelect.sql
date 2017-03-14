CREATE PROCEDURE [dbo].[upENet_SessionEMailSelect]
(
	@tech int
)
AS
SELECT     	ToList,CcList,BccList 
FROM         	sessEMail
WHERE	CreatedBy = @tech

