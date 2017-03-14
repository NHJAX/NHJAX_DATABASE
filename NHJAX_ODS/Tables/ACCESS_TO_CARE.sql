CREATE TABLE [dbo].[ACCESS_TO_CARE] (
    [AccessToCareId]       BIGINT          IDENTITY (1, 1) NOT NULL,
    [AccessToCareKey]      NUMERIC (7, 3)  NULL,
    [AccessToCareDesc]     VARCHAR (30)    NULL,
    [AccessToCareStandard] NUMERIC (10, 3) NULL,
    [CreatedDate]          DATETIME        CONSTRAINT [DF_ACCESS_TO_CARE_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedDate]          DATETIME        CONSTRAINT [DF_ACCESS_TO_CARE_UpdatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_ACCESS_TO_CARE] PRIMARY KEY CLUSTERED ([AccessToCareId] ASC)
);

