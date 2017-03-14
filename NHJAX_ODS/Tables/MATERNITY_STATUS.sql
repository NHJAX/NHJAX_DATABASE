CREATE TABLE [dbo].[MATERNITY_STATUS] (
    [MaternityStatusId]   INT          NOT NULL,
    [MaternityStatusDesc] VARCHAR (50) NULL,
    [IsInactive]          BIT          CONSTRAINT [DF_MATERNITY_STATUS_IsInactive] DEFAULT ((0)) NULL,
    [CreatedDate]         DATETIME     CONSTRAINT [DF_MATERNITY_STATUS_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_MATERNITY_STATUS] PRIMARY KEY CLUSTERED ([MaternityStatusId] ASC)
);

