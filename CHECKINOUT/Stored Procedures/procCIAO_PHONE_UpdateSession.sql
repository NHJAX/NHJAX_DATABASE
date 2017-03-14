create PROCEDURE [dbo].[procCIAO_PHONE_UpdateSession]
(
@sess varchar(50),
@pers bigint
)
 AS

UPDATE PHONE
SET PersonnelId = @pers,
SessionKey = ''
WHERE SessionKey = @sess;



