CREATE TABLE [dbo].[sessSYSTEM_TYPE] (
    [SessionKey]   INT          IDENTITY (1, 1) NOT NULL,
    [SessionId]    VARCHAR (50) NULL,
    [SystemTypeId] INT          NULL,
    [CreatedDate]  DATETIME     CONSTRAINT [DF_sessSYSTEM_TYPE_CreatedDate] DEFAULT (getdate()) NULL,
    [CreatedBy]    INT          NULL,
    [Active]       BIT          CONSTRAINT [DF_sessSYSTEM_TYPE_Active] DEFAULT ((1)) NULL,
    CONSTRAINT [PK_sessSYSTEM_TYPE] PRIMARY KEY CLUSTERED ([SessionKey] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_sessSYSTEM_TYPE_CreatedBy]
    ON [dbo].[sessSYSTEM_TYPE]([CreatedBy] ASC);

