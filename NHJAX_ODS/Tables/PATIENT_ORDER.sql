CREATE TABLE [dbo].[PATIENT_ORDER] (
    [OrderId]              BIGINT          IDENTITY (0, 1) NOT NULL,
    [OrderKey]             NUMERIC (20, 3) NULL,
    [OrderNumber]          VARCHAR (30)    NULL,
    [PatientId]            BIGINT          NULL,
    [OrderEncounterTypeId] BIGINT          NULL,
    [OrderTypeId]          BIGINT          NULL,
    [LocationId]           BIGINT          CONSTRAINT [DF_PATIENT_ORDER_LocationId] DEFAULT ((0)) NULL,
    [OrderingProviderId]   BIGINT          NULL,
    [SigDateTime]          DATETIME        NULL,
    [OrderDateTime]        DATETIME        NULL,
    [PatientEncounterId]   BIGINT          NULL,
    [PdtsFillCost]         NUMERIC (17, 5) NULL,
    [Quantity]             NUMERIC (15, 5) NULL,
    [UnitCost]             MONEY           NULL,
    [OrderCost]            MONEY           NULL,
    [OrderElementKey]      NUMERIC (21, 3) NULL,
    [CreatedDate]          DATETIME        CONSTRAINT [DF_PATIENT_ORDER_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedDate]          DATETIME        CONSTRAINT [DF_PATIENT_ORDER_UpdatedDate] DEFAULT (getdate()) NULL,
    [CollectionSampleId]   BIGINT          NULL,
    [OrderPriorityId]      BIGINT          NULL,
    [SourceSystemId]       BIGINT          CONSTRAINT [DF_PATIENT_ORDER_SourceSystemId] DEFAULT ((0)) NULL,
    [OrderStatusId]        BIGINT          NULL,
    [OrderComment]         VARCHAR (1000)  NULL,
    [AncillaryProcedureId] BIGINT          CONSTRAINT [DF_PATIENT_ORDER_AncillaryProcedureId] DEFAULT ((0)) NULL,
    [OrderNumberExtended]  VARCHAR (35)    NULL,
    [CreatedBy]            INT             CONSTRAINT [DF_PATIENT_ORDER_CreatedBy] DEFAULT ((0)) NULL,
    [UpdatedBy]            INT             CONSTRAINT [DF_PATIENT_ORDER_UpdatedBy] DEFAULT ((0)) NULL,
    [RequestingProviderId] BIGINT          NULL,
    [EarliestTaskDate]     DATETIME        NULL,
    [NurseSigDateTime]     DATETIME        NULL,
    [UserSigDateTime]      DATETIME        NULL,
    [StartDateTime]        DATETIME        NULL,
    [DisplayText]          VARCHAR (240)   NULL,
    [PortableId]           INT             NULL,
    [MobilityStatusId]     INT             CONSTRAINT [DF_PATIENT_ORDER_MobilityStatusId] DEFAULT ((0)) NULL,
    [ClinicalImpression]   VARCHAR (4000)  NULL,
    [OrderCategoryId]      INT             CONSTRAINT [DF_PATIENT_ORDER_OrderCategoryId] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_PATIENT_ORDER] PRIMARY KEY NONCLUSTERED ([OrderId] ASC)
);


GO
CREATE CLUSTERED INDEX [IX_PATIENT_ORDER_OrderDateTime]
    ON [dbo].[PATIENT_ORDER]([OrderDateTime] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_ORDER_PATIENT_ID]
    ON [dbo].[PATIENT_ORDER]([PatientId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PATIENT_ORDER_OrderElementKey]
    ON [dbo].[PATIENT_ORDER]([OrderElementKey] ASC) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE NONCLUSTERED INDEX [IX_PATIENT_ORDER_OrderingProviderId]
    ON [dbo].[PATIENT_ORDER]([OrderingProviderId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PATIENT_ORDER_SourceSystemId]
    ON [dbo].[PATIENT_ORDER]([SourceSystemId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PATIENT_ORDER_PatientEncounterId]
    ON [dbo].[PATIENT_ORDER]([PatientEncounterId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PATIENT_ORDER_OrderNumber]
    ON [dbo].[PATIENT_ORDER]([OrderNumber] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_PATIENT_ORDER_LocationId]
    ON [dbo].[PATIENT_ORDER]([LocationId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PATIENT_ORDER_OrderStatusId]
    ON [dbo].[PATIENT_ORDER]([OrderStatusId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PATIENT_ORDER_OrderNumberExtended]
    ON [dbo].[PATIENT_ORDER]([OrderNumberExtended] ASC);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_ORDER_KEY]
    ON [dbo].[PATIENT_ORDER]([OrderKey] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_PATIENT_ORDER_SigDateTime]
    ON [dbo].[PATIENT_ORDER]([SigDateTime] ASC);


GO
CREATE TRIGGER [dbo].[trODS_PATIENT_ORDER_UpdateOrderingHCP] ON [dbo].[PATIENT_ORDER]
FOR INSERT,UPDATE
AS


DECLARE @enc bigint
DECLARE @pro bigint

DECLARE @encX bigint
DECLARE @proX bigint

Declare @exists int

IF UPDATE(PatientEncounterId) OR UPDATE(OrderingProviderId)
BEGIN
	
	SELECT 
		@enc = ISNULL(PatientEncounterId,0),
		@pro = ISNULL(OrderingProviderId,0)
	FROM inserted 
	
	IF @enc > 0 AND @pro > 0
	BEGIN
	
		SELECT @proX = ProviderId,
			@encX = PatientEncounterId
		FROM ENCOUNTER_PROVIDER
		WHERE ProviderId = @pro
			AND PatientEncounterId = @enc
			AND ProviderRoleId = 8
		SET @exists = @@RowCount
		If @exists = 0
			BEGIN
				INSERT INTO ENCOUNTER_PROVIDER
				(
					PatientEncounterId,
					ProviderId,
					ProviderRoleId
				)
				VALUES
				(
					@enc,
					@pro,
					8
				)
			END	
		END
		
					
		--DECLARE @test varchar(50)
		--SET @test = @pfx + @strNum + @ext
		--EXEC dbo.procFORM_Activity_Log @pfx
		--EXEC dbo.procFORM_Activity_Log @strNum
		--EXEC dbo.procFORM_Activity_Log @ext
		--EXEC dbo.procFORM_Activity_Log @test


END


GO
CREATE TRIGGER [dbo].[ODS_PATIENT_ORDER_Update] 
   ON  [dbo].[PATIENT_ORDER]
   FOR INSERT,UPDATE
AS 

DECLARE @ord bigint
DECLARE @stat bigint

IF UPDATE(OrderStatusId)
BEGIN
	
	SET NOCOUNT ON;

    SELECT @ord = OrderId,
    @stat = IsNull(OrderStatusId,0)
    FROM inserted
    
    INSERT INTO PATIENT_ORDER_HISTORY
    (
    OrderId,
    OrderStatusId
    )
    VALUES
    (
    @ord,
    @stat
    )
 END

GO
 
 CREATE TRIGGER [dbo].[trODS_PATIENT_ORDER_Update] ON [dbo].[PATIENT_ORDER]
FOR INSERT,UPDATE
AS


DECLARE @ord bigint
DECLARE @dmis varchar(30)
DECLARE @num varchar(30)

IF UPDATE(OrderNumber) OR UPDATE(LocationId)
BEGIN
	
	SELECT 
		@ord = ORD.OrderId,
		@dmis = DMIS.DMISCode, 
		@num = ORD.OrderNumber
	FROM inserted AS ORD
	INNER JOIN HOSPITAL_LOCATION AS LOC 
	ON ORD.LocationId = LOC.HospitalLocationId 
	INNER JOIN MEPRS_CODE AS MEP 
	ON LOC.MeprsCodeId = MEP.MeprsCodeId 
	INNER JOIN DMIS AS DMIS 
	ON MEP.DmisId = DMIS.DMISId
		
	UPDATE PATIENT_ORDER
	SET OrderNumberExtended = @dmis + '-' + @num
	WHERE OrderId = @ord
				
	--DECLARE @test varchar(50)
	--SET @test = @pfx + @strNum + @ext
	--EXEC dbo.procFORM_Activity_Log @pfx
	--EXEC dbo.procFORM_Activity_Log @strNum
	--EXEC dbo.procFORM_Activity_Log @ext
	--EXEC dbo.procFORM_Activity_Log @test

END
