CREATE TABLE [dbo].[ALTERNATE_CARE_VALUE] (
    [AlternateCareValueId]   BIGINT         IDENTITY (1, 1) NOT NULL,
    [AlternateCareValueKey]  NUMERIC (8, 3) NULL,
    [AlternateCareValueCode] VARCHAR (30)   NULL,
    [AlternateCareValueDesc] VARCHAR (40)   NULL,
    [CreatedDate]            DATETIME       CONSTRAINT [DF_ALTERNATE_CARE_VALUE_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedDate]            DATETIME       CONSTRAINT [DF_ALTERNATE_CARE_VALUE_UpdatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_ALTERNATE_CARE_VALUE] PRIMARY KEY CLUSTERED ([AlternateCareValueId] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_ALTERNATE_CARE_VALUE_KEY]
    ON [dbo].[ALTERNATE_CARE_VALUE]([AlternateCareValueKey] ASC);

