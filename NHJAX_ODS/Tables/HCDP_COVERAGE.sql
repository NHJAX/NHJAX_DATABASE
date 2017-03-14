CREATE TABLE [dbo].[HCDP_COVERAGE] (
    [HCDPCoverageId]   INT            IDENTITY (1, 1) NOT NULL,
    [HCDPCoverageKey]  NUMERIC (9, 3) NULL,
    [HCDPCoverageCode] VARCHAR (3)    NULL,
    [HCDPCoverageDesc] VARCHAR (125)  NULL,
    [CreatedDate]      DATETIME       CONSTRAINT [DF_HCDP_COVERAGE_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedDate]      DATETIME       CONSTRAINT [DF_HCDP_COVERAGE_UpdatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_HCDP_COVERAGE] PRIMARY KEY CLUSTERED ([HCDPCoverageId] ASC)
);

