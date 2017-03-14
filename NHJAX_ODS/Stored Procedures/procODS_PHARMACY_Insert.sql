
create PROCEDURE [dbo].[procODS_PHARMACY_Insert]
(
	@phar varchar(50)
)
AS
	SET NOCOUNT ON;
	
INSERT INTO PHARMACY
(
	PharmacyDesc
) 
VALUES
(
	@phar
);
SELECT SCOPE_IDENTITY();
