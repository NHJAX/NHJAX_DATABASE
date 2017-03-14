CREATE TABLE [dbo].[ESS_ORDER_NEW] (
    [PatientKey]    BIGINT          NULL,
    [ESSPatientKey] BIGINT          NULL,
    [OrderTime]     DATETIME        NULL,
    [StartTime]     DATETIME        NULL,
    [StopTime]      DATETIME        NULL,
    [OrderName]     NVARCHAR (500)  NULL,
    [SetName]       NVARCHAR (500)  NULL,
    [ProviderName]  NVARCHAR (255)  NULL,
    [CategoryName]  NVARCHAR (50)   NULL,
    [OrderTypeName] NVARCHAR (50)   NULL,
    [Priority]      NVARCHAR (50)   NULL,
    [VerbalOrder]   INT             NULL,
    [ChainId]       INT             NULL,
    [OrderComments] NVARCHAR (1000) NULL,
    [CreatedDate]   DATETIME        CONSTRAINT [DF_ESS_ORDER_NEW_CreatedDate] DEFAULT (getdate()) NULL
);

