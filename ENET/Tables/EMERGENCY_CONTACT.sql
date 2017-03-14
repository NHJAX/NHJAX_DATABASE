CREATE TABLE [dbo].[EMERGENCY_CONTACT] (
    [EmergencyContactId]     BIGINT        IDENTITY (1, 1) NOT NULL,
    [EmergencyContactDesc]   VARCHAR (150) NULL,
    [EmergencyContactTypeId] INT           CONSTRAINT [DF_EMERGENCY_CONTACT_EmergencyContactTypeId] DEFAULT ((0)) NULL,
    [CreatedDate]            DATETIME      CONSTRAINT [DF_EMERGENCY_CONTACT_CreatedDate] DEFAULT (getdate()) NULL,
    [Inactive]               BIT           CONSTRAINT [DF_EMERGENCY_CONTACT_Inactive] DEFAULT ((0)) NULL,
    [IsPrimary]              BIT           CONSTRAINT [DF_EMERGENCY_CONTACT_IsPrimary] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_EMERGENCY_CONTACT] PRIMARY KEY CLUSTERED ([EmergencyContactId] ASC)
);

