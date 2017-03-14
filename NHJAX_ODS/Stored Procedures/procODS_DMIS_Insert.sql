
create PROCEDURE [dbo].[procODS_DMIS_Insert]
(
	@key numeric(10,3),
	@code varchar(30),
	@desc varchar(50)
	
)
AS
	SET NOCOUNT ON;
	
INSERT INTO DMIS
(
	DMISKey,
	DMISCode,
	FacilityName
) 
VALUES
(
	@key, 
	@code,
	@desc
);
SELECT SCOPE_IDENTITY();
