CREATE TABLE [dbo].[STATUS_MODIFIER] (
    [StatusModifierId]   BIGINT       IDENTITY (1, 1) NOT NULL,
    [StatusModifierDesc] VARCHAR (50) NULL,
    [CreatedDate]        DATETIME     CONSTRAINT [DF_STATUS_MODIFIER_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_STATUS_MODIFIER] PRIMARY KEY CLUSTERED ([StatusModifierId] ASC)
);

