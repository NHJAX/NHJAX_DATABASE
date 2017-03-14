CREATE TABLE [dbo].[PHONE] (
    [PhoneId]               BIGINT        IDENTITY (1, 1) NOT NULL,
    [UserId]                INT           NULL,
    [PhoneTypeId]           INT           NULL,
    [PhoneNumber]           NVARCHAR (50) NULL,
    [CreatedDate]           DATETIME      CONSTRAINT [DF_PHONE_CreatedDate] DEFAULT (getdate()) NULL,
    [CreatedBy]             INT           CONSTRAINT [DF_PHONE_CreatedBy] DEFAULT ((0)) NULL,
    [UpdatedDate]           DATETIME      CONSTRAINT [DF_PHONE_UpdatedDate] DEFAULT (getdate()) NULL,
    [UpdatedBy]             INT           CONSTRAINT [DF_PHONE_UpdatedBy] DEFAULT ((0)) NULL,
    [Inactive]              BIT           CONSTRAINT [DF_PHONE_Inactive] DEFAULT ((0)) NULL,
    [PreferredContactOrder] INT           CONSTRAINT [DF_PHONE_PreferredContactOrder] DEFAULT ((1)) NULL,
    [Extension]             VARCHAR (10)  NULL,
    CONSTRAINT [PK_PHONE] PRIMARY KEY CLUSTERED ([PhoneId] ASC)
);


GO
create TRIGGER [dbo].[trgENET_PHONE_UpdateTechnician]
	ON [dbo].[PHONE]
	FOR INSERT, UPDATE
AS
Declare @num varchar(50)
Declare @tnum varchar(50)
Declare @usr int
Declare @typ int

BEGIN
	IF UPDATE(PhoneNumber)
		
	BEGIN
		SET NOCOUNT ON;
		SELECT @num = PhoneNumber,
			@usr = UserId,
			@typ = PhoneTypeId
		FROM inserted
		
		IF @typ = 1
		BEGIN
			SELECT @tnum = HomePhone
			FROM TECHNICIAN
			WHERE UserId = @usr
			
			IF @tnum <> @num
			BEGIN
				UPDATE TECHNICIAN
				SET HomePhone = @num
				WHERE UserId = @usr
			END
		END
		
		IF @typ = 2
		BEGIN
			SELECT @tnum = CellPhone
			FROM TECHNICIAN
			WHERE UserId = @usr
			
			IF @tnum <> @num
			BEGIN
				UPDATE TECHNICIAN
				SET CellPhone = @num
				WHERE UserId = @usr
			END
		END
		
		IF @typ = 3
		BEGIN
			SELECT @tnum = UPhone
			FROM TECHNICIAN
			WHERE UserId = @usr
			
			IF @tnum <> @num
			BEGIN
				UPDATE TECHNICIAN
				SET UPhone = @num
				WHERE UserId = @usr
			END
		END
		
		IF @typ = 8
		BEGIN
			SELECT @tnum = AltPhone
			FROM TECHNICIAN
			WHERE UserId = @usr
			
			IF @tnum <> @num
			BEGIN
				UPDATE TECHNICIAN
				SET AltPhone = @num
				WHERE UserId = @usr
			END
		END
		 
	END
END
GO
create TRIGGER [dbo].[trgENET_PHONE_Resort]
	ON [dbo].[PHONE]
	FOR INSERT 
AS
Declare @ph bigint
Declare @usr int
Declare @ord int

BEGIN
	IF UPDATE(PreferredContactOrder)
		
	BEGIN
		SET NOCOUNT ON;
		SELECT @ph = PhoneId,
			@usr = UserId,
			@ord = PreferredContactOrder
		FROM inserted
		
		UPDATE PHONE
		SET PreferredContactOrder = PreferredContactOrder + 1
		WHERE PreferredContactOrder >= @ord
		AND UserId = @usr
		AND PhoneId <> @ph
	END
END
GO
--create TRIGGER [dbo].[trgENET_PHONE_Resort]
--	ON [dbo].[PHONE]
--	FOR INSERT 
--AS
--Declare @ph bigint
--Declare @usr int
--Declare @ord int

--BEGIN
--	IF UPDATE(PreferredContactOrder)
		
--	BEGIN
--		SET NOCOUNT ON;
--		SELECT @ph = PhoneId,
--			@usr = UserId,
--			@ord = PreferredContactOrder
--		FROM inserted
		
--		UPDATE PHONE
--		SET PreferredContactOrder = PreferredContactOrder + 1
--		WHERE PreferredContactOrder >= @ord
--		AND UserId = @usr
--		AND PhoneId <> @ph
--	END
--END

create TRIGGER [dbo].[trgENET_PHONE_Resort_Update]
	ON [dbo].[PHONE]
	FOR UPDATE 
AS
Declare @ph bigint
Declare @usr int
Declare @ord int
Declare @ordD int

BEGIN
	IF UPDATE(PreferredContactOrder)
		
	BEGIN
		SET NOCOUNT ON;
		SELECT @ph = NEW.PhoneId,
			@usr = NEW.UserId,
			@ord = NEW.PreferredContactOrder
		FROM inserted AS NEW
		
		SELECT
			@ordD = OLD.PreferredContactOrder
		FROM deleted as OLD
		
		UPDATE PHONE
		SET PreferredContactOrder = @ordD
		WHERE PreferredContactOrder = @ord 
		AND UserId = @usr
		AND PhoneId <> @ph
	END
END