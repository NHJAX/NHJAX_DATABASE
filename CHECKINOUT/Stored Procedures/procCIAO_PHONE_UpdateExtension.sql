create PROCEDURE [dbo].[procCIAO_PHONE_UpdateExtension]
(
@ph bigint, 
@ext nvarchar(10),
@uby int
)
 AS

UPDATE PHONE
SET Extension = @ext
WHERE PhoneId = @ph;



