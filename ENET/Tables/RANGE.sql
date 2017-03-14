CREATE TABLE [dbo].[RANGE] (
    [RangeKey]    INT          NOT NULL,
    [RangeDesc]   VARCHAR (50) NULL,
    [CreatedDate] DATETIME     CONSTRAINT [DF_RANGE_CreatedDate] DEFAULT (getdate()) NULL,
    [CreatedBy]   INT          CONSTRAINT [DF_RANGE_CreatedBy] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_RANGE] PRIMARY KEY CLUSTERED ([RangeKey] ASC)
);

