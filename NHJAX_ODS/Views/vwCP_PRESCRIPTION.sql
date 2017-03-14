CREATE VIEW dbo.vwCP_PRESCRIPTION
AS
SELECT     ISNULL(MAX(FILL.FillDate), '1/1/1900') AS MaxFillDate, PRE.PrescriptionId, PRE.RXNumber, PRE.PatientId, PRE.SourceSystemId, 
                      PHAR.PharmacyDesc, DRG.DrugId, ISNULL(FILL.DaysSupply, PRE.DaysSupply) AS DaysSupply, PRE.ProviderId
FROM         dbo.PRESCRIPTION AS PRE INNER JOIN
                      dbo.PHARMACY AS PHAR ON PRE.PharmacyId = PHAR.PharmacyId INNER JOIN
                      dbo.PRESCRIPTION_DRUG AS DRG ON PRE.PrescriptionId = DRG.PrescriptionId LEFT OUTER JOIN
                      dbo.PRESCRIPTION_FILL_DATE AS FILL ON DRG.PrescriptionDrugId = FILL.PrescriptionDrugId
GROUP BY PRE.PrescriptionId, PRE.RXNumber, PRE.PatientId, PRE.SourceSystemId, PHAR.PharmacyDesc, DRG.DrugId, FILL.DaysSupply, PRE.DaysSupply, 
                      PRE.ProviderId

GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
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
         Begin Table = "PRE"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 165
               Right = 230
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PHAR"
            Begin Extent = 
               Top = 6
               Left = 268
               Bottom = 99
               Right = 435
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "DRG"
            Begin Extent = 
               Top = 6
               Left = 473
               Bottom = 114
               Right = 658
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "FILL"
            Begin Extent = 
               Top = 102
               Left = 268
               Bottom = 210
               Right = 473
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
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCP_PRESCRIPTION';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCP_PRESCRIPTION';

