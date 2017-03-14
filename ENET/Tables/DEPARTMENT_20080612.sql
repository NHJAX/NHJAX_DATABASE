CREATE TABLE [dbo].[DEPARTMENT_20080612] (
    [DepartmentId]     INT           NOT NULL,
    [DCBILLET]         NVARCHAR (50) NULL,
    [DepartmentCode]   VARCHAR (50)  NULL,
    [DepartmentHeadId] INT           NULL,
    [CreatedDate]      DATETIME      NULL,
    [CreatedBy]        INT           NULL,
    [UpdatedDate]      DATETIME      NULL,
    [UpdatedBy]        INT           NULL,
    [Inactive]         BIT           NOT NULL,
    [BaseId]           INT           NULL,
    [DirectorateId]    INT           NULL,
    [DeptPhone]        VARCHAR (50)  NULL,
    [DeptFax]          VARCHAR (50)  NULL,
    [DeptPager]        VARCHAR (50)  NULL,
    [IsDirectorate]    BIT           NULL,
    CONSTRAINT [PK_DEPARTMENT] PRIMARY KEY CLUSTERED ([DepartmentId] ASC)
);

