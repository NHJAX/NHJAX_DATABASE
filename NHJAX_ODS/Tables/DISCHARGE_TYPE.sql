CREATE TABLE [dbo].[DISCHARGE_TYPE] (
    [DischargeTypeId]   BIGINT         IDENTITY (1, 1) NOT NULL,
    [DischargeTypeKey]  NUMERIC (9, 4) NULL,
    [DischargeTypeDesc] VARCHAR (60)   NULL,
    [DischargeTypeCode] VARCHAR (2)    NULL,
    [CreatedDate]       DATETIME       CONSTRAINT [DF_DISCHARGE_TYPE_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedDate]       DATETIME       CONSTRAINT [DF_DISCHARGE_TYPE_UpdatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_DISCHARGE_TYPE] PRIMARY KEY CLUSTERED ([DischargeTypeId] ASC)
);

