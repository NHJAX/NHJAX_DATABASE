CREATE TABLE [dbo].[THIRD_PARTY_PAYER] (
    [ThirdPartyPayerId]   INT          NOT NULL,
    [ThirdPartyPayerDesc] VARCHAR (50) NULL,
    CONSTRAINT [PK_THIRD_PARTY_PAYER] PRIMARY KEY CLUSTERED ([ThirdPartyPayerId] ASC)
);

