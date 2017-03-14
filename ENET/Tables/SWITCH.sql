CREATE TABLE [dbo].[SWITCH] (
    [SwitchId]    INT          IDENTITY (1, 1) NOT NULL,
    [SwitchDesc]  VARCHAR (50) NULL,
    [BaseId]      INT          CONSTRAINT [DF_SWITCH_AudienceId] DEFAULT ((0)) NULL,
    [CreatedDate] DATETIME     CONSTRAINT [DF_SWITCH_CreatedDate] DEFAULT (getdate()) NULL,
    [CreatedBy]   INT          CONSTRAINT [DF_SWITCH_CreatedBy] DEFAULT ((0)) NULL,
    [Inactive]    BIT          CONSTRAINT [DF_SWITCH_Inactive] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_SWITCH] PRIMARY KEY CLUSTERED ([SwitchId] ASC)
);

