CREATE TABLE [dbo].[PHONE] (
    [PhoneId]               BIGINT        IDENTITY (1, 1) NOT NULL,
    [PersonnelId]           BIGINT        NULL,
    [PhoneTypeId]           INT           NULL,
    [PhoneNumber]           NVARCHAR (50) NULL,
    [CreatedDate]           DATETIME      CONSTRAINT [DF_PHONE_CreatedDate] DEFAULT (getdate()) NULL,
    [CreatedBy]             INT           CONSTRAINT [DF_PHONE_CreatedBy] DEFAULT ((0)) NULL,
    [UpdatedDate]           DATETIME      CONSTRAINT [DF_PHONE_UpdatedDate] DEFAULT (getdate()) NULL,
    [UpdatedBy]             INT           CONSTRAINT [DF_PHONE_UpdatedBy] DEFAULT ((0)) NULL,
    [Inactive]              BIT           CONSTRAINT [DF_PHONE_Inactive] DEFAULT ((0)) NULL,
    [PreferredContactOrder] INT           CONSTRAINT [DF_PHONE_PreferredContactOrder] DEFAULT ((1)) NULL,
    [Extension]             VARCHAR (10)  NULL,
    [SessionKey]            VARCHAR (50)  NULL,
    CONSTRAINT [PK_PHONE] PRIMARY KEY CLUSTERED ([PhoneId] ASC)
);


GO
create TRIGGER [dbo].[trgENET_PHONE_Resort]
	ON dbo.PHONE
	FOR INSERT 
AS
Declare @ph bigint
Declare @usr bigint
Declare @ord int

BEGIN
	IF UPDATE(PreferredContactOrder)
		
	BEGIN
		SET NOCOUNT ON;
		SELECT @ph = PhoneId,
			@usr = PersonnelId,
			@ord = PreferredContactOrder
		FROM inserted
		
		UPDATE PHONE
		SET PreferredContactOrder = PreferredContactOrder + 1
		WHERE PreferredContactOrder >= @ord
		AND PersonnelId = @usr
		AND PhoneId <> @ph
	END
END

GO
create TRIGGER [dbo].[trgENET_PHONE_Resort_Update]
	ON dbo.PHONE
	FOR UPDATE 
AS
Declare @ph bigint
Declare @usr bigint
Declare @ord int
Declare @ordD int

BEGIN
	IF UPDATE(PreferredContactOrder)
		
	BEGIN
		SET NOCOUNT ON;
		SELECT @ph = NEW.PhoneId,
			@usr = NEW.PersonnelId,
			@ord = NEW.PreferredContactOrder
		FROM inserted AS NEW
		
		SELECT
			@ordD = OLD.PreferredContactOrder
		FROM deleted as OLD
		
		UPDATE PHONE
		SET PreferredContactOrder = @ordD
		WHERE PreferredContactOrder = @ord 
		AND PersonnelId = @usr
		AND PhoneId <> @ph
	END
END
