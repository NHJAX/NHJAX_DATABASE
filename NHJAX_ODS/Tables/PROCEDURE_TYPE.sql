CREATE TABLE [dbo].[PROCEDURE_TYPE] (
    [ProcedureTypeId]   BIGINT       NOT NULL,
    [ProcedureTypeDesc] VARCHAR (50) NULL,
    [CreatedDate]       DATETIME     CONSTRAINT [DF_PROCEDURE_TYPE_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_PROCEDURE_TYPE] PRIMARY KEY CLUSTERED ([ProcedureTypeId] ASC)
);

