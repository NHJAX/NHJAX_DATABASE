CREATE VIEW [dbo].[xxxvwENET_20120223UnmatchedbyECN]
AS
SELECT DISTINCT 
                      SUB.item_id, SUB.me_ecn_id, SUB.device_text, SUB.me_last_invntry_dt AS LastDate, SUB.me_manuf_model_id, SUB.me_mfg_serial_id, 
                      SUB.manuf_mdl_comn_id, dbo.DISPOSITION.DispositionDesc, dbo.ASSET.Room, dbo.vwENET_ASSET_MaxbySerial.MaxDate AS LastUpdated, 
                      dbo.TECHNICIAN.UFName, dbo.TECHNICIAN.ULName, dbo.TECHNICIAN.UMName, dbo.BUILDING.BuildingDesc, dbo.ASSET.PlantAccountNumber
FROM         dbo.vwENET_ASSET_MaxbySerial INNER JOIN
                      dbo.ASSET ON dbo.vwENET_ASSET_MaxbySerial.SerialNumber = dbo.ASSET.SerialNumber AND 
                      dbo.vwENET_ASSET_MaxbySerial.MaxDate = dbo.ASSET.UpdatedDate INNER JOIN
                      dbo.DISPOSITION ON dbo.ASSET.DispositionId = dbo.DISPOSITION.DispositionId INNER JOIN
                      dbo.TECHNICIAN ON dbo.ASSET.UpdatedBy = dbo.TECHNICIAN.UserId INNER JOIN
                      dbo.BUILDING ON dbo.ASSET.BuildingId = dbo.BUILDING.BuildingId RIGHT OUTER JOIN
                      dbo.xxx20120223Inventory AS SUB ON REPLACE(dbo.ASSET.EqpMgtBarCode, 'N00232', '') = SUB.me_ecn_id
WHERE     (dbo.DISPOSITION.DispositionDesc IS NULL)


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
         Begin Table = "vwENET_ASSET_MaxbySerial"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 84
               Right = 189
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ASSET"
            Begin Extent = 
               Top = 6
               Left = 227
               Bottom = 114
               Right = 420
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "DISPOSITION"
            Begin Extent = 
               Top = 6
               Left = 458
               Bottom = 114
               Right = 612
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TECHNICIAN"
            Begin Extent = 
               Top = 84
               Left = 38
               Bottom = 192
               Right = 216
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "BUILDING"
            Begin Extent = 
               Top = 114
               Left = 254
               Bottom = 222
               Right = 405
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "SUB"
            Begin Extent = 
               Top = 114
               Left = 443
               Bottom = 222
               Right = 627
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
         Widt', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'xxxvwENET_20120223UnmatchedbyECN';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'h = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'xxxvwENET_20120223UnmatchedbyECN';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'xxxvwENET_20120223UnmatchedbyECN';

