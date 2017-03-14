CREATE TABLE [dbo].[sessINV_BASE] (
    [SessionKey]  INT      IDENTITY (1, 1) NOT NULL,
    [CreatedBy]   INT      NULL,
    [CreatedDate] DATETIME CONSTRAINT [DF_sessINV_BASE_CreatedDate] DEFAULT (getdate()) NULL,
    [BaseId]      INT      NULL,
    CONSTRAINT [PK_sessINV_BASE] PRIMARY KEY CLUSTERED ([SessionKey] ASC)
);

