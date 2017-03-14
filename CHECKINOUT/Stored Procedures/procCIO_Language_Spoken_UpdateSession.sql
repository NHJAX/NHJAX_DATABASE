CREATE PROCEDURE [dbo].[procCIO_Language_Spoken_UpdateSession]
(
@sess varchar(50),
@pers bigint
)
 AS

UPDATE LANGUAGE_SPOKEN
SET PersonnelId = @pers,
SessionKey = ''
WHERE SessionKey = @sess;



