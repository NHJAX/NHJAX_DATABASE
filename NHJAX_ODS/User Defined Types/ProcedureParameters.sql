CREATE TYPE [dbo].[ProcedureParameters] AS TABLE (
    [RecordId]               INT            NOT NULL,
    [ParameterName]          VARCHAR (50)   NULL,
    [ParameterType]          VARCHAR (50)   NULL,
    [ParameterIntegerValue]  INT            NULL,
    [ParameterDecimalValue]  DECIMAL (8, 2) NULL,
    [ParameterVarcharValue]  VARCHAR (MAX)  NULL,
    [ParameterDateTimeValue] DATETIME       NULL,
    [ParameterBooleanValue]  BIT            NULL,
    [ParameterXMLValue]      XML            NULL,
    PRIMARY KEY CLUSTERED ([RecordId] ASC));

