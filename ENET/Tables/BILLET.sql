CREATE TABLE [dbo].[BILLET] (
    [BilletId]        INT          NOT NULL,
    [BilletDesc]      VARCHAR (50) NULL,
    [BilletShortName] VARCHAR (25) NULL,
    [CreatedDate]     DATETIME     CONSTRAINT [DF_POSITION_CreatedDate] DEFAULT (getdate()) NULL,
    [CreatedBy]       INT          NULL,
    [Inactive]        BIT          CONSTRAINT [DF_POSITION_Inactive] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_POSITION] PRIMARY KEY CLUSTERED ([BilletId] ASC)
);

