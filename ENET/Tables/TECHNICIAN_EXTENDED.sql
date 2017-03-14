CREATE TABLE [dbo].[TECHNICIAN_EXTENDED] (
    [UserId]               INT             NOT NULL,
    [ProviderId]           BIGINT          NULL,
    [IsException]          BIT             CONSTRAINT [DF_TECHNICIAN_EXTENDED_IsException] DEFAULT ((0)) NULL,
    [CreatedDate]          DATETIME        CONSTRAINT [DF_TECHNICIAN_EXTENDED_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedDate]          DATETIME        CONSTRAINT [DF_TECHNICIAN_EXTENDED_UpdatedDate] DEFAULT (getdate()) NULL,
    [Deployed]             BIT             CONSTRAINT [DF_TECHNICIAN_EXTENDED_Deployed] DEFAULT ((0)) NULL,
    [DeployDate]           DATETIME        NULL,
    [ReturnDate]           DATETIME        NULL,
    [UpdatedBy]            INT             NULL,
    [HasAlt]               BIT             CONSTRAINT [DF_TECHNICIAN_EXTENDED_HasAlt] DEFAULT ((0)) NULL,
    [AltId]                VARCHAR (25)    NULL,
    [AvailableForDisaster] BIT             CONSTRAINT [DF_TECHNICIAN_EXTENDED_AvailableForDisaster] DEFAULT ((0)) NULL,
    [HasServerAccess]      BIT             CONSTRAINT [DF_TECHNICIAN_EXTENDED_HasServerAccess] DEFAULT ((0)) NULL,
    [ExcludeTrainingDept]  BIT             CONSTRAINT [DF_TECHNICIAN_EXTENDED_ExcludeTrainingDept] DEFAULT ((0)) NULL,
    [TeamId]               INT             CONSTRAINT [DF_TECHNICIAN_EXTENDED_TeamId] DEFAULT ((0)) NULL,
    [TimekeeperTypeId]     INT             CONSTRAINT [DF_TECHNICIAN_EXTENDED_TimekeeperTypeId] DEFAULT ((0)) NULL,
    [HasDriversLicense]    BIT             CONSTRAINT [DF_TECHNICIAN_EXTENDED_HasDriversLicense] DEFAULT ((0)) NULL,
    [AltIssueDate]         DATETIME        CONSTRAINT [DF_TECHNICIAN_EXTENDED_AltIssueDate] DEFAULT ('1/1/1776') NULL,
    [ExcludeVolunteer]     BIT             CONSTRAINT [DF_TECHNICIAN_EXTENDED_ExcludeVolunteer] DEFAULT ((0)) NULL,
    [IsSupervisor]         BIT             CONSTRAINT [DF_TECHNICIAN_EXTENDED_IsSupervisor] DEFAULT ((0)) NOT NULL,
    [IsORM]                BIT             CONSTRAINT [DF_TECHNICIAN_EXTENDED_IsORM] DEFAULT ((0)) NOT NULL,
    [IsSupplyPO]           BIT             CONSTRAINT [DF_TECHNICIAN_EXTENDED_IsSupplyPO] DEFAULT ((0)) NOT NULL,
    [NPIKey]               NUMERIC (16, 3) NULL,
    CONSTRAINT [PK_TECHNICIAN_EXTENDED] PRIMARY KEY CLUSTERED ([UserId] ASC)
);


GO
CREATE TRIGGER [dbo].[trENet_TECHNICIAN_EXTENDED_Update] ON [dbo].[TECHNICIAN_EXTENDED]
FOR UPDATE
AS

DECLARE @usr int
DECLARE @pro bigint
DECLARE @exc bit
DECLARE	@cdate datetime 
DECLARE	@udate datetime
DECLARE	@depl bit
DECLARE @ddate datetime 
DECLARE @rdate datetime
DECLARE	@uby int
DECLARE @alt bit 
DECLARE @altid varchar(25)
DECLARE @dis bit
DECLARE @svr bit
DECLARE @excl bit
DECLARE @team int
DECLARE @ttyp int 
DECLARE @dl bit
DECLARE @adate datetime
DECLARE @exvol bit
DECLARE @sup bit
DECLARE @orm bit
DECLARE @hby int
DECLARE @spo bit
DECLARE @npi	numeric(16,3)

--Don't want the generic updates to trigger

IF NOT UPDATE(UpdatedBy) AND NOT UPDATE(UpdatedDate)
BEGIN

	SELECT 
		@usr = UserId, 
		@pro = ProviderId,
		@exc = IsException,
		@cdate = CreatedDate,
		@udate = UpdatedDate,
		@depl = Deployed,
		@ddate = DeployDate,
		@rdate = ReturnDate,
		@uby = UpdatedBy,
		@alt = HasAlt, 
		@altid = AltId,
		@dis = AvailableForDisaster,
		@svr = HasServerAccess,
		@excl = ExcludeTrainingDept,
		@team = TeamId,
		@ttyp = TimekeeperTypeId,
		@dl = HasDriversLicense,
		@adate = AltIssueDate,
		@exvol = ExcludeVolunteer,
		@sup = IsSupervisor,
		@orm = IsORM,
		@hby = UpdatedBy,
		@spo = IsSupplyPO,
		@npi = NPIKey
	FROM deleted 

		BEGIN
		INSERT INTO TECHNICIAN_EXTENDED_HISTORY
		(
			UserId, 
			ProviderId, 
			IsException, 
			CreatedDate, 
			UpdatedDate, 
			Deployed, 
			DeployDate, 
			ReturnDate, 
			UpdatedBy, 
			HasAlt, 
			AltId, 
            AvailableForDisaster, 
            HasServerAccess, 
            ExcludeTrainingDept, 
            TeamId, 
            TimekeeperTypeId, 
            HasDriversLicense, 
            AltIssueDate, 
            ExcludeVolunteer, 
            IsSupervisor, 
            IsORM, 
            HistoryBy,
            IsSupplyPO,
            NPIKey
		)
		VALUES     
		(
			@usr, 
			@pro,
			@exc,
			@cdate,
			@udate,
			@depl,
			@ddate,
			@rdate,
			@uby,
			@alt, 
			@altid,
			@dis,
			@svr,
			@excl,
			@team,
			@ttyp,
			@dl,
			@adate,
			@exvol,
			@sup,
			@orm,
			@hby, 
			@spo,
			@npi
		)
		END

END

