CREATE TABLE [dbo].[MILITARY_GRADE_RANK] (
    [MilitaryGradeRankId]       BIGINT          IDENTITY (1, 1) NOT NULL,
    [MilitaryGradeRankKey]      NUMERIC (10, 3) NULL,
    [MilitaryGradeRankDesc]     VARCHAR (30)    NULL,
    [MilitaryGradeRankCode]     VARCHAR (4)     NULL,
    [MilitaryGradeRankAbbrev]   VARCHAR (4)     NULL,
    [MilitaryGradeRankPayGrade] VARCHAR (2)     NULL,
    [CreatedDate]               DATETIME        CONSTRAINT [DF_MILITARY_GRADE_RANK_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedDate]               DATETIME        CONSTRAINT [DF_MILITARY_GRADE_RANK_UpdatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_MILITARY_GRADE_RANK] PRIMARY KEY CLUSTERED ([MilitaryGradeRankId] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_MILITARY_GRADE_RANK_KEY]
    ON [dbo].[MILITARY_GRADE_RANK]([MilitaryGradeRankKey] ASC);

