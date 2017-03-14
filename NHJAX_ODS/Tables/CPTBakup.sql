CREATE TABLE [dbo].[CPTBakup] (
    [CptId]       BIGINT          NOT NULL,
    [CptHcpcsKey] DECIMAL (11, 3) NULL,
    [CptCode]     VARCHAR (30)    NULL,
    [CptDesc]     VARCHAR (30)    NULL,
    [CptTypeId]   BIGINT          NULL,
    [RVU]         MONEY           NULL,
    [CreatedDate] DATETIME        NULL,
    [UpdatedDate] DATETIME        NULL
);

