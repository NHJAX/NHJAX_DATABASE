CREATE TABLE [dbo].[METHOD_OF_TRANSIT] (
    [MethodOfTransitId]   INT            NOT NULL,
    [MethodOfTransitKey]  NUMERIC (8, 3) NULL,
    [MethodOfTransitDesc] VARCHAR (50)   NULL,
    [MethodOfTransitCode] VARCHAR (4)    NULL,
    [CreatedDate]         DATETIME       CONSTRAINT [DF_METHOD_OF_TRANSIT_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_METHOD_OF_TRANSIT] PRIMARY KEY CLUSTERED ([MethodOfTransitId] ASC)
);

