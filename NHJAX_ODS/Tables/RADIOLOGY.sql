CREATE TABLE [dbo].[RADIOLOGY] (
    [RadiologyId]     BIGINT          IDENTITY (1, 1) NOT NULL,
    [RadiologyKey]    NUMERIC (10, 3) NULL,
    [RadiologyDesc]   VARCHAR (60)    NULL,
    [RadiologyCode]   VARCHAR (5)     NULL,
    [RadiologyTypeId] BIGINT          NULL,
    [UnitCost]        MONEY           NULL,
    [ProcedureCost]   NUMERIC (15, 5) NULL,
    [CptId]           NUMERIC (21, 3) NULL,
    [CreatedDate]     DATETIME        CONSTRAINT [DF_RADIOLOGY_PROCEDURES_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedDate]     DATETIME        CONSTRAINT [DF_RADIOLOGY_UpdatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_RADIOLOGY_PROCEDURES] PRIMARY KEY CLUSTERED ([RadiologyId] ASC),
    CONSTRAINT [FK_RADIOLOGY_RADIOLOGY_TYPE] FOREIGN KEY ([RadiologyTypeId]) REFERENCES [dbo].[RADIOLOGY_TYPE] ([RadiologyTypeId])
);


GO
CREATE NONCLUSTERED INDEX [IX_RADIOLOGY_KEY]
    ON [dbo].[RADIOLOGY]([RadiologyKey] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_RADIOLOGY_RADID_CPTID]
    ON [dbo].[RADIOLOGY]([RadiologyId] ASC, [CptId] ASC);

