CREATE TABLE [dbo].[REFUSAL_STATUS] (
    [RefusalStatusId]   BIGINT       IDENTITY (1, 1) NOT NULL,
    [RefusalStatusDesc] VARCHAR (50) NULL,
    [CreatedDate]       DATETIME     CONSTRAINT [DF_REFUSAL_STATUS_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_REFUSAL_STATUS] PRIMARY KEY CLUSTERED ([RefusalStatusId] ASC)
);

