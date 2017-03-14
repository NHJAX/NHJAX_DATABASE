CREATE TABLE [dbo].[CAPS] (
    [UserId]         INT           NOT NULL,
    [EmployeeNumber] INT           NULL,
    [DoDEDI]         NVARCHAR (10) NULL,
    [SSN]            VARCHAR (11)  NULL,
    CONSTRAINT [PK_CAPS] PRIMARY KEY CLUSTERED ([UserId] ASC)
);

