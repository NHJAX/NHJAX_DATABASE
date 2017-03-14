create PROCEDURE [dbo].[procCIAO_PHONE_Insert]
(
@pers bigint, 
@typ int,
@num varchar(50),
@cby int,
@ord int,
@ext varchar(10) = '',
@sess varchar(50)
)
 AS
 
DECLARE @max int

SELECT @max = MAX(PreferredContactOrder)
FROM PHONE 
WHERE PersonnelId = @pers

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
	PersonnelId,
	PhoneTypeId,
	PhoneNumber,
	CreatedBy,
	UpdatedBy,
	PreferredContactOrder,
	Extension,
	SessionKey
) 
VALUES
(
@pers, 
@typ,
@num,
@cby,
@cby,
@max + 1,
@ext,
@sess
);



