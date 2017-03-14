CREATE TABLE [dbo].[DRUG_ROUTE] (
    [DrugRouteId]   NUMERIC (5)    NOT NULL,
    [DrugRouteKey]  NUMERIC (8, 3) NULL,
    [DrugRouteName] VARCHAR (5)    NULL,
    [DrugRouteDesc] VARCHAR (30)   NULL,
    [CreatedDate]   DATETIME       CONSTRAINT [DF_DRUG_ROUTE_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_DRUG_ROUTE] PRIMARY KEY CLUSTERED ([DrugRouteId] ASC)
);

