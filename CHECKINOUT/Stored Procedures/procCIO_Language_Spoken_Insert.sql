CREATE PROCEDURE [dbo].[procCIO_Language_Spoken_Insert]
(
@sess varchar(50),
@pers bigint = 0, 
@lang int
)
 AS

INSERT INTO LANGUAGE_SPOKEN
(
SessionKey,
PersonnelId,
LanguageId
) 
VALUES(
@sess,
@pers, 
@lang 
);



