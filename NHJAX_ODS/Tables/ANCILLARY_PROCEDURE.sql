CREATE TABLE [dbo].[ANCILLARY_PROCEDURE] (
    [AncillaryProcedureId]   BIGINT          IDENTITY (1, 1) NOT NULL,
    [AncillaryProcedureKey]  NUMERIC (10, 3) NULL,
    [AncillaryProcedureDesc] VARCHAR (30)    NULL,
    [CreatedDate]            DATETIME        CONSTRAINT [DF_ANCILLARY_PROCEDURE_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedDate]            DATETIME        CONSTRAINT [DF_ANCILLARY_PROCEDURE_UpdatedDate] DEFAULT (getdate()) NULL,
    [SourceSystemId]         BIGINT          CONSTRAINT [DF_ANCILLARY_PROCEDURE_SourceSystemId] DEFAULT ((2)) NULL,
    CONSTRAINT [PK_ANCILLARY_PROCEDURE] PRIMARY KEY CLUSTERED ([AncillaryProcedureId] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_ANCILLARY_PROCEDURE_AncillaryProcedureDesc]
    ON [dbo].[ANCILLARY_PROCEDURE]([AncillaryProcedureDesc] ASC);

