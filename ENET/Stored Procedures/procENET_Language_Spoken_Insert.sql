create PROCEDURE [dbo].[procENET_Language_Spoken_Insert]
(
@usr int, 
@lang int
)
 AS

INSERT INTO LANGUAGE_SPOKEN
(
UserId,
LanguageId
) 
VALUES(
@usr, 
@lang 
);



