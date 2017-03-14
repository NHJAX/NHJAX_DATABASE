CREATE TABLE [dbo].[REFUSAL_REASON] (
    [RefusalReasonId]   BIGINT          IDENTITY (1, 1) NOT NULL,
    [RefusalReasonKey]  NUMERIC (8, 3)  NULL,
    [RefusalReasonCode] NUMERIC (13, 5) NULL,
    [RefusalReasonDesc] VARCHAR (65)    NULL,
    [RefusalStatusId]   BIGINT          NULL,
    [CreatedDate]       DATETIME        CONSTRAINT [DF_REFUSAL_REASON_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedDate]       DATETIME        CONSTRAINT [DF_REFUSAL_REASON_UpdatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_REFUSAL_REASON] PRIMARY KEY CLUSTERED ([RefusalReasonId] ASC)
);

