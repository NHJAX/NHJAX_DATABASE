CREATE PROCEDURE [dbo].[procCIO_CheckIn_Parameters_Insert]
(
@stp bigint,
@bas int,
@desg int, 
@info varchar(100),
@srt int,
@cby int,
@uby int,
@strux bigint = 0
)
 AS

INSERT INTO CHECKIN_PARAMETER
(
	CheckInStepId,
	BaseId,
	DesignationId,
	SpecialInformation,
	DefaultSortOrder,
	CreatedBy,
	UpdatedBy,
	CheckinTypeId,
	InstructionsFor
)
VALUES
(
	@stp,
	@bas,
	@desg, 
	@info,
	@srt,
	@cby,
	@uby,
	1,
	@strux
);
SELECT SCOPE_IDENTITY();


