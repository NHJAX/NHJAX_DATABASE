CREATE TABLE [dbo].[sessPROBLEM_TYPE] (
    [SessionKey]    INT          IDENTITY (1, 1) NOT NULL,
    [SessionId]     VARCHAR (50) NOT NULL,
    [ProblemTypeId] INT          NOT NULL,
    [CreatedDate]   DATETIME     CONSTRAINT [DF_sessPROBLEM_TYPE_CreatedDate] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]     INT          NOT NULL,
    [Active]        BIT          CONSTRAINT [DF_sessPROBLEM_TYPE_Active] DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PK_sessPROBLEM_TYPE] PRIMARY KEY CLUSTERED ([SessionKey] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_sessPROBLEM_TYPE_CreatedBy]
    ON [dbo].[sessPROBLEM_TYPE]([CreatedBy] ASC);

