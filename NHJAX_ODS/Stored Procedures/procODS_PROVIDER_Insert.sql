
CREATE PROCEDURE [dbo].[procODS_PROVIDER_Insert]
(
	@name varchar(30),
	@pc bigint,
	@loc bigint,
	@src bigint,
	@ph varchar(18),
	@code varchar(30) = '',
	@ssn varchar(30) = '',
	@npi numeric(16,3) = 0,
	@key numeric(12,4) = 0
)
AS
	SET NOCOUNT ON;

IF LEN(@name) > 0	
BEGIN
INSERT INTO NHJAX_ODS.dbo.PROVIDER
(
	ProviderName, 
	ProviderClassId,
	LocationId,
	SourceSystemId,
	DutyPhone,
	ProviderCode,
	ProviderSSN,
	NPIKey,
	ProviderKey
) 
VALUES
(
	@name, 
	@pc,
	@loc,
	@src,
	@ph,
	@code,
	@ssn,
	CAST(@npi AS varchar(20)),
	@key
);
SELECT SCOPE_IDENTITY();
END