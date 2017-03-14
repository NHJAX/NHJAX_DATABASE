CREATE TABLE [dbo].[sessINV_AUDIENCE] (
    [SessionKey]  INT      IDENTITY (1, 1) NOT NULL,
    [CreatedBy]   INT      NULL,
    [CreatedDate] DATETIME CONSTRAINT [DF_sessINV_AUDIENCE_CreatedDate] DEFAULT (getdate()) NULL,
    [AudienceId]  BIGINT   NULL,
    CONSTRAINT [PK_sessINV_AUDIENCE] PRIMARY KEY CLUSTERED ([SessionKey] ASC)
);

