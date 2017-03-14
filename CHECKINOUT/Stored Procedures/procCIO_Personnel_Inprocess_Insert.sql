CREATE PROCEDURE [dbo].[procCIO_Personnel_Inprocess_Insert]
(
@pers bigint,
@stp bigint,
@for bigint,
@typ int, 
@srt int,
@desc varchar(50),
@info varchar(100),
@cby int,
@def bit,
@grp bit,
@desg int,
@bas int
)
 AS

INSERT INTO PERSONNEL_INPROCESS
(
	PersonnelId,
	CheckInStepId,
	InstructionsFor,
	PersonnelTypeId,
	SortOrder,
	CheckInStepDesc,
	SpecialInformation,
	CreatedBy,
	IsDefault,
	IsGroup,
	DesignationId,
	BaseId
)
VALUES
(
	@pers,
	@stp,
	@for, 
	@typ,
	@srt,
	@desc,
	@info,
	@cby,
	@def,
	@grp,
	@desg,
	@bas
);
SELECT SCOPE_IDENTITY();


