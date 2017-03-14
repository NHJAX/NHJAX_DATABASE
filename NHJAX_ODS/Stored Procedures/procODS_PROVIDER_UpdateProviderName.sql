

create PROCEDURE [dbo].[procODS_PROVIDER_UpdateProviderName]
	@pro decimal,
	@name varchar(30)
AS
BEGIN
	
	SET NOCOUNT ON;

	UPDATE PROVIDER
	SET 
		ProviderName = @name,
		UpdatedDate = GetDate()
	WHERE ProviderKey = @pro
END

