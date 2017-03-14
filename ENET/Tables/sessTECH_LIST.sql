CREATE TABLE [dbo].[sessTECH_LIST] (
    [SessionKey]  INT          IDENTITY (1, 1) NOT NULL,
    [SessionId]   VARCHAR (50) NOT NULL,
    [UserId]      INT          NOT NULL,
    [CreatedDate] DATETIME     CONSTRAINT [DF_sessTECH_LIST_CreatedDate] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]   INT          NOT NULL,
    [Active]      BIT          CONSTRAINT [DF_sessTECH_LIST_Active] DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PK_sessTECH_LIST] PRIMARY KEY CLUSTERED ([SessionKey] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_sessTECH_LIST_Createdby]
    ON [dbo].[sessTECH_LIST]([CreatedBy] ASC);

