CREATE TABLE [dbo].[DMIS] (
    [DMISId]       BIGINT          IDENTITY (1, 1) NOT NULL,
    [DMISKey]      NUMERIC (10, 3) NULL,
    [DMISCode]     VARCHAR (30)    NULL,
    [FacilityName] VARCHAR (50)    NULL,
    [CreatedDate]  DATETIME        CONSTRAINT [DF_DMIS_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedDate]  DATETIME        CONSTRAINT [DF_DMIS_UpdatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_DMIS] PRIMARY KEY CLUSTERED ([DMISId] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_DMIS_KEY]
    ON [dbo].[DMIS]([DMISKey] ASC);

