CREATE PROCEDURE [dbo].[procENET_Active_Directory_Computer_UpdateDeletedDate]
(
@cn varchar(50),
@clr bit = 0
)
 AS

--Added @clr parameter to reset deleted items 11/6/08

IF @clr = 0
BEGIN
UPDATE ACTIVE_DIRECTORY_COMPUTER
SET DeletedDate = getdate()
WHERE CommonName = @cn;
END

ELSE
BEGIN
UPDATE ACTIVE_DIRECTORY_COMPUTER
SET DeletedDate = '1/1/1776'
WHERE CommonName = @cn;
END



