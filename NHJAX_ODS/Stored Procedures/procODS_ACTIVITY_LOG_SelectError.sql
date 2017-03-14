

create PROCEDURE [dbo].[procODS_ACTIVITY_LOG_SelectError] 
AS
BEGIN
	
	SET NOCOUNT ON;

	SELECT TOP 1 LogDescription, CreatedDate
	FROM ACTIVITY_LOG

	ORDER BY CreatedDate DESC
END













