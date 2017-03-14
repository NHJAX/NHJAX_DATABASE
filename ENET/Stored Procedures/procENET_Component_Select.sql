
create PROCEDURE [dbo].[procENET_Component_Select]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT 
	ComponentId,
	ComponentDesc
FROM COMPONENT
WHERE ComponentId > 0
ORDER BY ComponentDesc
END

