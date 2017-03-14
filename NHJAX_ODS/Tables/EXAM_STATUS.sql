CREATE TABLE [dbo].[EXAM_STATUS] (
    [ExamStatusId]   BIGINT         NOT NULL,
    [ExamStatusKey]  NUMERIC (8, 3) NULL,
    [ExamStatusDesc] VARCHAR (30)   NULL,
    [CreatedDate]    DATETIME       CONSTRAINT [DF_EXAMINATION_STATUS_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedDate]    DATETIME       CONSTRAINT [DF_EXAMINATION_STATUS_UpdatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_EXAMINATION_STATUS] PRIMARY KEY CLUSTERED ([ExamStatusId] ASC)
);

