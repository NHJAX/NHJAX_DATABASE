
CREATE PROCEDURE [dbo].[procODS_PROVIDER_SPECIALTY_Insert]
(
	@desc varchar(50)
)
AS
	SET NOCOUNT ON;
	
INSERT INTO NHJAX_ODS.dbo.PROVIDER_SPECIALTY
(
	ProviderSpecialtyDesc,
	SourceSystemId
) 
VALUES
(
	@desc,
	13
);
SELECT SCOPE_IDENTITY();
