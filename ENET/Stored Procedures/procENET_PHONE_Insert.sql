CREATE PROCEDURE [dbo].[procENET_PHONE_Insert]
(
@usr int, 
@typ int,
@num varchar(50),
@cby int,
@ord int,
@ext varchar(10) = ''
)
 AS
 
DECLARE @max int
DECLARE @ph bigint

SET @ph = 0

SELECT @ph = PhoneId
FROM PHONE
WHERE UserId = @usr
AND PhoneNumber = @num

IF @ph > 0
BEGIN
	UPDATE PHONE
	SET Inactive = 0
	WHERE UserId = @usr
	AND PhoneNumber = @ph
END

ELSE
BEGIN
SELECT @max = MAX(PreferredContactOrder)
FROM PHONE 
WHERE UserId = @usr

IF @max IS NULL
BEGIN
SET @max = 0
END

--INSERT INTO ACTIVITY_LOG
--(
--LogDescription)
--values(@max
--)

INSERT INTO PHONE
(
	UserId,
	PhoneTypeId,
	PhoneNumber,
	CreatedBy,
	UpdatedBy,
	PreferredContactOrder,
	Extension
) 
VALUES
(
@usr, 
@typ,
@num,
@cby,
@cby,
@max + 1,
@ext
);
END



