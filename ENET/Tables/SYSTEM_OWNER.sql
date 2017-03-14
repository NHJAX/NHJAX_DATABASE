CREATE TABLE [dbo].[SYSTEM_OWNER] (
    [SystemOwnerId]   INT           NOT NULL,
    [SystemOwnerDesc] NVARCHAR (50) NULL,
    [CreatedDate]     DATETIME      CONSTRAINT [DF_OWNER_CreatedDate] DEFAULT (getdate()) NULL,
    [Inactive]        BIT           CONSTRAINT [DF_OWNER_Inactive] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_OWNER] PRIMARY KEY CLUSTERED ([SystemOwnerId] ASC)
);

