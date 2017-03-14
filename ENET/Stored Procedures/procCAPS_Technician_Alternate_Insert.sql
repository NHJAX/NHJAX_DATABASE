CREATE PROCEDURE [dbo].[procCAPS_Technician_Alternate_Insert]
(
	@usr int,
	@alt int,
	@alias bigint,
	@typ int
)
 AS
DELETE FROM TECHNICIAN_ALTERNATE
WHERE TechnicianId = @usr
AND AlternateId = @alt
AND AliasId = @alias
AND AliasTypeId = @typ;

INSERT INTO TECHNICIAN_ALTERNATE
(
TechnicianId,
AlternateId,
AliasId,
AliasTypeId
)
VALUES
(
@usr,
@alt,
@alias,
@typ
)

