CREATE TABLE [dbo].[CHECKIN_PARAMETER] (
    [CheckInParameterId] BIGINT        IDENTITY (1, 1) NOT NULL,
    [CheckInStepId]      BIGINT        NULL,
    [BaseId]             INT           NULL,
    [DesignationId]      INT           NULL,
    [SpecialInformation] VARCHAR (100) NULL,
    [DefaultSortOrder]   INT           CONSTRAINT [DF_CHECKIN_PARAMETER_SortOrder] DEFAULT ((0)) NULL,
    [CreatedDate]        DATETIME      CONSTRAINT [DF_CHECKIN_PARAMETER_CreatedDate] DEFAULT (getdate()) NULL,
    [CreatedBy]          INT           CONSTRAINT [DF_CHECKIN_PARAMETER_CreatedBy] DEFAULT ((0)) NULL,
    [UpdatedDate]        DATETIME      CONSTRAINT [DF_CHECKIN_PARAMETER_UpdatedDate] DEFAULT (getdate()) NULL,
    [UpdatedBy]          INT           CONSTRAINT [DF_CHECKIN_PARAMETER_UpdatedBy] DEFAULT ((0)) NULL,
    [CheckInTypeId]      INT           NULL,
    [IsGroup]            BIT           CONSTRAINT [DF_CHECKIN_PARAMETER_IsGroup] DEFAULT ((0)) NULL,
    [InstructionsFor]    BIGINT        CONSTRAINT [DF_CHECKIN_PARAMETER_InstructionsFor] DEFAULT ((0)) NULL,
    [OldSortOrder]       INT           NULL,
    CONSTRAINT [PK_CHECKIN_PARAMETER] PRIMARY KEY CLUSTERED ([CheckInParameterId] ASC)
);


GO
create TRIGGER [dbo].[trCIAO_CHECKIN_PARAMETER_Update] ON [dbo].[CHECKIN_PARAMETER]
FOR UPDATE
AS


DECLARE @cip bigint
DECLARE @cis bigint
DECLARE @bas int
DECLARE @desg int
DECLARE @si varchar(100)
DECLARE @srt int
DECLARE @cdate datetime
DECLARE @cby int
DECLARE @udate datetime
DECLARE @uby int
DECLARE @ctyp int
DECLARE @grp bit
DECLARE @i4 bigint
DECLARE @hby int

	SELECT 
		@cip = CheckInParameterId,
		@cis = CheckInStepId, 
		@bas = BaseId, 
		@desg = DesignationId, 
		@si = SpecialInformation, 
		@srt = DefaultSortOrder, 
		@cdate = CreatedDate, 
		@uby = UpdatedBy, 
		@udate = UpdatedDate, 
		@ctyp = CheckInTypeId, 
		@grp = IsGroup, 
		@i4 = InstructionsFor,
		@hby = UpdatedBy

	FROM deleted 

	INSERT INTO CHECKIN_PARAMETER_HISTORY
		(
			CheckInParameterId,
			CheckInStepId,
			BaseId,
			DesignationId,
			SpecialInformation,
			DefaultSortOrder, 
			CreatedDate, 
			CreatedBy, 
			UpdatedDate, 
			UpdatedBy, 
			CheckInTypeId,
			IsGroup,
			InstructionsFor, 
			HistoryBy
		)
		VALUES     
		(
			@cip,
			@cis,
			@bas, 
			@desg, 
			@si, 
			@srt, 
			@cdate, 
			@cby,
			@udate, 
			@uby,
			@ctyp, 
			@grp, 
			@i4,
			@hby
		)


