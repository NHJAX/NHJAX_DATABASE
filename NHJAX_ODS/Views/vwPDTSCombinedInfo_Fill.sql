CREATE VIEW dbo.vwPDTSCombinedInfo_Fill
AS
SELECT DISTINCT 
                      CAST(dbo.vwMDE_PDTS_PROFILE_COLLECTION_F$ACCEPTED_RESPONSE_DETAIL.ACCEPTED_PRESCRIPTION_NUMBER AS Varchar(20)) 
                      AS AcceptedPrescriptionNumber, dbo.PATIENT.PatientId, ISNULL(dbo.PHARMACY.PharmacyId, 0) AS PharmacyId, 
                      dbo.vwMDE_PDTS_PROFILE_COLLECTION_F$ACCEPTED_RESPONSE_DETAIL.ACCEPTED_PRESCRIBER_ID, 
                      dbo.vwMDE_PDTS_PROFILE_COLLECTION_F$ACCEPTED_RESPONSE_DETAIL.ACCEPTED_DATE_FILLED, 
                      dbo.vwMDE_PDTS_PROFILE_COLLECTION_F$ACCEPTED_RESPONSE_DETAIL.ACCEPTED_DAYS_SUPPLY, 
                      dbo.FormattedNDC(dbo.vwMDE_PDTS_PROFILE_COLLECTION_F$ACCEPTED_RESPONSE_DETAIL.ACCEPTED_NDC_NUMBER) AS AcceptedNDCNumber
FROM         dbo.vwMDE_PDTS_PROFILE_COLLECTION_F$ACCEPTED_RESPONSE_DETAIL INNER JOIN
                      dbo.vwMDE_PDTS_PROFILE_COLLECTION_FILE ON 
                      dbo.vwMDE_PDTS_PROFILE_COLLECTION_F$ACCEPTED_RESPONSE_DETAIL.KEY_PDTS_PROFILE_COLLECTION_FILE = dbo.vwMDE_PDTS_PROFILE_COLLECTION_FILE.KEY_PDTS_PROFILE_COLLECTION_FILE
                       INNER JOIN
                      dbo.PATIENT ON dbo.vwMDE_PDTS_PROFILE_COLLECTION_FILE.PATIENT_IEN = dbo.PATIENT.PatientKey INNER JOIN
                      dbo.DRUG ON dbo.FormattedNDC(dbo.vwMDE_PDTS_PROFILE_COLLECTION_F$ACCEPTED_RESPONSE_DETAIL.ACCEPTED_NDC_NUMBER) 
                      = dbo.DRUG.NDCNumber LEFT OUTER JOIN
                      dbo.PHARMACY ON 
                      dbo.vwMDE_PDTS_PROFILE_COLLECTION_F$ACCEPTED_RESPONSE_DETAIL.ACCEPTED_PHARMACY_NAME = dbo.PHARMACY.PharmacyDesc
WHERE     (dbo.vwMDE_PDTS_PROFILE_COLLECTION_F$ACCEPTED_RESPONSE_DETAIL.ACCEPTED_PRESCRIPTION_NUMBER IS NOT NULL)

GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[29] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "vwMDE_PDTS_PROFILE_COLLECTION_F$ACCEPTED_RESPONSE_DETAIL"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 431
            End
            DisplayFlags = 280
            TopColumn = 6
         End
         Begin Table = "vwMDE_PDTS_PROFILE_COLLECTION_FILE"
            Begin Extent = 
               Top = 114
               Left = 38
               Bottom = 222
               Right = 311
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PATIENT"
            Begin Extent = 
               Top = 115
               Left = 527
               Bottom = 223
               Right = 718
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "DRUG"
            Begin Extent = 
               Top = 0
               Left = 512
               Bottom = 108
               Right = 670
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PHARMACY"
            Begin Extent = 
               Top = 132
               Left = 350
               Bottom = 225
               Right = 501
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwPDTSCombinedInfo_Fill';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N' ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwPDTSCombinedInfo_Fill';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwPDTSCombinedInfo_Fill';

