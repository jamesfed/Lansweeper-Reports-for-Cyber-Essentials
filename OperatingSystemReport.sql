Select Top (1000000) tsysOS.Image As icon,
  tblAssets.AssetID,
  tblAssets.AssetName,
  tblOperatingsystem.Caption,
  tblAssets.Version,
  tblAssetCustom.Manufacturer,
  tblAssetCustom.Model,
  tblAssets.Lastseen As [Last successful scan]
From tblAssets
  Inner Join tblOperatingsystem On
      tblAssets.AssetID = tblOperatingsystem.AssetID
  Inner Join tsysOS On tsysOS.OScode = tblAssets.OScode
  Inner Join tblAssetCustom On tblAssets.AssetID = tblAssetCustom.AssetID
  Left Outer Join tsysIPLocations On tblAssets.LocationID =
      tsysIPLocations.LocationID
  Left Join (Select Max(tblIndirectScan.LastChanged) As lastIndirectScan,
      tblIndirectScan.AssetId
    From tblIndirectScan
    Group By tblIndirectScan.AssetId) indirect On tblAssetCustom.AssetId =
      indirect.AssetId
Where tblAssetCustom.State = 1
Order By tsysOS.OSname,
  tblAssets.AssetName,
  tblOperatingsystem.Caption
